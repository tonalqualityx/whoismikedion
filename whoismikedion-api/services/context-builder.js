/**
 * Context Builder Service
 * 
 * Builds relevant context from the database based on user questions.
 * This is the "Retrieval" part of RAG (Retrieval-Augmented Generation).
 * 
 * Services/context-builder.js
 */

const db = require('../db/connection');

// CONFIG
const CONFIG = {
    maxStories: 3,
    maxSkills: 10,
    maxWorkHistory: 3,
    weaknessKeywords: ['weakness', 'weaknesses', 'weak', 'improve', 'improvement', 
                     'growth', 'develop', 'developing', 'gap', 'gaps', 'lack',
                     'struggle', 'challenge', 'difficult', 'better', 'limitation']
};

const STOP_WORDS = new Set([
  'a', 'an', 'the', 'is', 'are', 'was', 'were', 'be', 'been', 'being',
  'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would', 'could',
  'should', 'may', 'might', 'must', 'can', 'about', 'your', 'you', "you're",
  'what', 'how', 'tell', 'me', 'i', 'my', 'with', 'for', 'to', 'of',
  'and', 'or', 'but', 'in', 'on', 'at', 'by', 'any', 'some', 'like',
  'work', 'working', 'experience', 'experienced', 'background', 'know',
  'mike', 'dion', "mike's", 'his', 'him', 'he'
]);

/**
 * Extract meaningful keywords from user message.
 * Filters out common words to focus on topic-relevant terms.
 * 
 * @param {string} message - User's message
 * @returns {string[]} - Array of keywords
 */

function extractKeywords(message) {
    const cleaned = message
        .toLowerCase()
        .replace(/[^\w\s-]/g, ' ')
        .replace(/\s+/g, ' ')
        .trim();

    const words = cleaned.split(' ');

    const keywords = words.filter(word => {
        return word.length > 2 && !STOP_WORDS.has(word);
    });

    return [...new Set(keywords)];
}

/**
 * Extract keywords from recent conversation history.
 * Used to enrich context when the current message yields few/no keywords
 * (e.g., "yes", "tell me more").
 *
 * For assistant messages: extracts topic keywords from <strong> tags and story references.
 * For user messages: runs through standard extractKeywords().
 * Only processes last 4 messages to keep context recent.
 *
 * @param {Array} history - Conversation history array [{role, content}, ...]
 * @returns {string[]} - Deduplicated keyword array
 */
function extractKeywordsFromHistory(history) {
    if (!history || history.length === 0) return [];

    const recentHistory = history.slice(-4);
    const allKeywords = [];

    for (const msg of recentHistory) {
        if (msg.role === 'assistant') {
            // Extract topic keywords from <strong> tags (bold text in responses)
            const strongMatches = msg.content.match(/<strong>(.*?)<\/strong>/g) || [];
            for (const match of strongMatches) {
                const text = match.replace(/<\/?strong>/g, '');
                const words = extractKeywords(text);
                allKeywords.push(...words);
            }

            // Extract story/project name references (story_id patterns like "restaurant-content-strategy")
            const storyIdMatches = msg.content.match(/\b[a-z]+-[a-z]+-[a-z]+(?:-[a-z]+)*\b/g) || [];
            for (const id of storyIdMatches) {
                const words = id.split('-').filter(w => w.length > 2 && !STOP_WORDS.has(w));
                allKeywords.push(...words);
            }
        } else if (msg.role === 'user') {
            allKeywords.push(...extractKeywords(msg.content));
        }
    }

    return [...new Set(allKeywords)];
}

/**
 * Check if message is asking about weaknesses/growth areas.
 * 
 * @param {string} message - User's message
 * @returns {boolean}
 */

function isAskingAboutWeaknesses(message) {
    const lowerMessage = message.toLowerCase();
    return CONFIG.weaknessKeywords.some(keyword => lowerMessage.includes(keyword));
}

// DB Queries

/**
 * Find skills matching the extracted keywords.
 * Searches skill_id, canonical_name, and synonyms.
 * 
 * @param {string[]} keywords - Extracted keywords
 * @returns {Promise<Array>} - Matching skills
 */

async function findMatchingSkills(keywords) {
    if (keywords.length === 0) {
        const [skills] = await db.query(`
            SELECT skill_id, canonical_name, proficiency, notes
            FROM skills
            WHERE is_top_skill = TRUE
            ORDER BY 
                CASE proficiency
                    WHEN 'expert' THEN 1
                    WHEN 'proficient' THEN 2
                    WHEN 'developing' THEN 3
                END
            LIMIT ?
            `, [CONFIG.maxSkills]);

        return skills;
    }

    const likeConditions = keywords.map( () => `(
        skill_id LIKE ? OR
        canonical_name LIKE ? OR
        synonyms LIKE ?
    )`).join(' OR ');

    const params = keywords.flatMap( keyword => {
        const pattern = `%${keyword}%`;  // Contains match, not just prefix
        return [pattern, pattern, pattern];
    });

    const [skills] = await db.query(`
        SELECT skill_id, canonical_name, proficiency, notes
        FROM skills
        WHERE ${likeConditions}
        ORDER BY
            CASE proficiency
                WHEN 'expert' THEN 1
                WHEN 'proficient' THEN 2
                WHEN 'developing' THEN 3
            END
        LIMIT ?
        `, [...params, CONFIG.maxSkills]);

    // Fallback to top skills if keyword search returns nothing
    if (skills.length === 0) {
        const [topSkills] = await db.query(`
            SELECT skill_id, canonical_name, proficiency, notes
            FROM skills
            WHERE is_top_skill = TRUE
            ORDER BY
                CASE proficiency
                    WHEN 'expert' THEN 1
                    WHEN 'proficient' THEN 2
                    WHEN 'developing' THEN 3
                END
            LIMIT ?
            `, [CONFIG.maxSkills]);
        return topSkills;
    }

    return skills;
}

/**
 * Find stories related to keywords (by title) or matched skills.
 * Falls back to random stories if no matches found.
 *
 * @param {string[]} keywords - Extracted keywords from user message
 * @param {Array} skills - Matched skills
 * @returns {Promise<Object>} - { stories: Array, isFallback: boolean }
 */

async function findRelatedStories(keywords, skills) {
    // First, try to find stories by keyword match in title or keywords field
    if (keywords.length > 0) {
        const titleConditions = keywords.map(() => `(st.title LIKE ? OR st.keywords LIKE ?)`).join(' OR ');
        const titleParams = keywords.flatMap(kw => [`%${kw}%`, `%${kw}%`]);

        const [titleMatches] = await db.query(`
            SELECT
                st.story_id,
                st.title,
                st.context,
                st.challenge,
                st.solution,
                st.outcome,
                st.quantifiable_impact,
                GROUP_CONCAT(DISTINCT sk.canonical_name SEPARATOR ', ') AS demonstrated_skills
            FROM stories st
            LEFT JOIN story_skills ss ON st.id = ss.story_id
            LEFT JOIN skills sk ON ss.skill_id = sk.id
            WHERE ${titleConditions}
            GROUP BY st.id, st.story_id, st.title, st.context, st.challenge, st.solution, st.outcome, st.quantifiable_impact
            ORDER BY st.id
            LIMIT ?
        `, [...titleParams, CONFIG.maxStories]);

        if (titleMatches.length > 0) {
            return { stories: titleMatches, isFallback: false };
        }
    }

    // Second, try to find stories by skill match
    if (skills.length > 0) {
        const skillIds = skills.map(s => s.skill_id);
        const placeholders = skillIds.map(() => '?').join(', ');

        const [skillMatches] = await db.query(`
            SELECT
                st.story_id,
                st.title,
                st.context,
                st.challenge,
                st.solution,
                st.outcome,
                st.quantifiable_impact,
                GROUP_CONCAT(DISTINCT sk.canonical_name SEPARATOR ', ') AS demonstrated_skills
            FROM stories st
            JOIN story_skills ss ON st.id = ss.story_id
            JOIN skills sk ON ss.skill_id = sk.id
            WHERE sk.skill_id IN (${placeholders})
            GROUP BY st.id, st.story_id, st.title, st.context, st.challenge, st.solution, st.outcome, st.quantifiable_impact
            ORDER BY st.id
            LIMIT ?
        `, [...skillIds, CONFIG.maxStories]);

        if (skillMatches.length > 0) {
            return { stories: skillMatches, isFallback: false };
        }
    }

    // Fallback: return 3 random stories for general context
    const [fallbackStories] = await db.query(`
        SELECT
            st.story_id,
            st.title,
            st.context,
            st.challenge,
            st.solution,
            st.outcome,
            st.quantifiable_impact,
            GROUP_CONCAT(DISTINCT sk.canonical_name SEPARATOR ', ') AS demonstrated_skills
        FROM stories st
        LEFT JOIN story_skills ss ON st.id = ss.story_id
        LEFT JOIN skills sk ON ss.skill_id = sk.id
        GROUP BY st.id, st.story_id, st.title, st.context, st.challenge, st.solution, st.outcome, st.quantifiable_impact
        ORDER BY RAND()
        LIMIT ?
    `, [CONFIG.maxStories]);

    return { stories: fallbackStories, isFallback: true };
}

/**
 * Get relevant work history based on keywords or default to recent positions.
 * 
 * @param {string[]} keywords - Extracted keywords
 * @returns {Promise<Array>} - Work history entries
 */

async function getWorkHistory(keywords) {
    const [positions] = await db.query(`
        SELECT
            title,
            company,
            start_date,
            end_date,
            key_accomplishments,
            CASE
                WHEN end_date IS NULL THEN 'Present'
                ELSE DATE_FORMAT(end_date, '%b %Y')
            END as end_display,
            DATE_FORMAT(start_date, '%b %Y') as start_display
        FROM work_history
        ORDER BY start_date DESC
        LIMIT ?
        `, [CONFIG.maxWorkHistory]);

    return positions;
}


/**
 * Get weaknesses/growth areas.
 * Called when user asks about limitations or improvements.
 * 
 * @returns {Promise<Array>} - Weaknesses with related skills
 */
async function getWeaknesses() {
    const [weaknesses] = await db.query(`
        SELECT
            w.weakness_id,
            w.title,
            w.description,
            w.strategic_positioning,
            w.growth_plan,
            GROUP_CONCAT(DISTINCT sk.canonical_name SEPARATOR ', ') AS related_skills
        FROM weaknesses w
        LEFT JOIN skill_weaknesses sw ON w.id = sw.weakness_id
        LEFT JOIN skills sk ON sw.skill_id = sk.id
        GROUP BY w.id
    `);

    return weaknesses;
}

/**
 * Get core values.
 * 
 * @returns {Promise<Array>} - Core values
 */

async function getCoreValues() {
    const [coreValues] = await db.query(`
        SELECT value_text, description
        FROM core_values
        ORDER BY display_order
    `);

    return coreValues;
}

/**
 * Get all skills grouped by category.
 * Used to provide complete skills inventory to LLM.
 *
 * @returns {Promise<Object>} - Skills grouped by category
 */
async function getAllSkills() {
    const [skills] = await db.query(`
        SELECT skill_id, canonical_name, category, proficiency
        FROM skills
        ORDER BY
            CASE category
                WHEN 'pm_competency' THEN 1
                WHEN 'technical_skill' THEN 2
                WHEN 'soft_skill' THEN 3
                WHEN 'domain_knowledge' THEN 4
                WHEN 'hobby' THEN 5
            END,
            CASE proficiency
                WHEN 'expert' THEN 1
                WHEN 'proficient' THEN 2
                WHEN 'developing' THEN 3
            END,
            canonical_name
    `);

    // Group by category
    const grouped = {
        pm_competency: [],
        technical_skill: [],
        soft_skill: [],
        domain_knowledge: [],
        hobby: []
    };

    skills.forEach(skill => {
        if (grouped[skill.category]) {
            grouped[skill.category].push(skill);
        }
    });

    return grouped;
}

/**
 * Format skills into a readable context section.
 * 
 * @param {Array} skills - Skills array
 * @returns {string} - Formatted skills text
 */

function formatSkills(skills) {
    if(skills.length === 0) {
        return '';
    }

    const lines = skills.map(skill => {
        const notes = skill.notes ? ` - Notes: ${skill.notes}` : '';
        return `- ${skill.canonical_name} (${skill.proficiency})${notes}`;
    });

    return `## Relevant Skills\n` + lines.join('\n');
}

/**
 * Format all skills into a compact inventory grouped by category.
 *
 * @param {Object} groupedSkills - Skills grouped by category from getAllSkills()
 * @returns {string} - Formatted complete skills inventory
 */
function formatAllSkills(groupedSkills) {
    const categoryLabels = {
        pm_competency: 'PM Competencies',
        technical_skill: 'Technical Skills',
        soft_skill: 'Soft Skills',
        domain_knowledge: 'Domain Knowledge',
        hobby: 'Hobbies'
    };

    const sections = [];

    for (const [category, skills] of Object.entries(groupedSkills)) {
        if (skills.length === 0) continue;

        const label = categoryLabels[category] || category;
        const lines = skills.map(s => `- ${s.canonical_name} (${s.proficiency})`);
        sections.push(`### ${label}\n${lines.join('\n')}`);
    }

    if (sections.length === 0) {
        return '';
    }

    return `## Complete Skills Inventory\n\n${sections.join('\n\n')}`;
}

/**
 * Format stories into a readable context section.
 * Uses STAR format for clarity.
 *
 * @param {Array} stories - Stories array
 * @param {boolean} isFallback - Whether these are fallback stories (not directly related to query)
 * @returns {string} - Formatted stories text
 */

function formatStories(stories, isFallback = false) {
    if(stories.length === 0) {
        return '';
    }

    const formated = stories.map(story => {
        return `### ${story.title} (${story.story_id})
        **Skills Demonstrated:** ${story.demonstrated_skills || 'Various'}
        **Situation:** ${story.context}
        **Challenge:** ${story.challenge}
        **Action:** ${story.solution}
        **Result:** ${story.outcome}
        ${story.quantifiable_impact ? `**Quantifiable Impact:** ${story.quantifiable_impact}` : ''}`
    });

    if (isFallback) {
        return `## Success Stories\n**Note:** These stories are not directly related to the user's query keywords, but provide general context about Mike's experience.\n\n` + formated.join('\n\n');
    }

    return `## Success Stories\n` + formated.join('\n\n');
}

/**
 * Format work history into a readable context section.
 * 
 * @param {Array} positions - Work history array
 * @returns {string} - Formatted work history text
 */

function formatWorkHistory(positions) {
    if(positions.length === 0) {
        return '';
    }

    const formatted = positions.map(pos => {
        const accomplishments = pos.key_accomplishments
            ? `\n Key accomplishments: ${pos.key_accomplishments.substring(0, 200)}...`
            : '';
        return `- **${pos.title}** at ${pos.company} (${pos.start_display} - ${pos.end_display})${accomplishments}`;
    })

    return `## Work History\n` + formatted.join('\n');
}


/**
 * Format weaknesses into a readable context section.
 * 
 * @param {Array} weaknesses - Weaknesses array
 * @returns {string} - Formatted weaknesses text
 */

function formatWeaknesses(weaknesses) {
    if(weaknesses.length === 0) {
        return '';
    }

    const formatted = weaknesses.map(w => {
        return `${w.title}
        **Description:** ${w.description}
        **Strategic Positioning:** ${w.strategic_positioning}
        **Growth Plan:** ${w.growth_plan}
        ${w.related_skills ? `**Related Skills:** ${w.related_skills}` : ''}`
    });

    return `## Areas for Growth (Honest Self-Assessment)\n` + formatted.join('\n\n');
}


/**
 * Format core values into a readable context section.
 * 
 * @param {Array} coreValues - Core values array
 * @returns {string} - Formatted values text
 */

function formatCoreValues(coreValues) {
    if(coreValues.length === 0) {
        return '';
    }

    const formatted = coreValues.map( v=> {
        return `- **${v.value_text}**: ${v.description}`;
    });

    return `## Core Values\n` + formatted.join('\n');
}

// =============================================
// MAIN BUILD FUNCTION
// =============================================

/**
 * Build context from database based on user message.
 * This is the main entry point for the context builder.
 * 
 * @param {string} userMessage - The user's message
 * @returns {Promise<Object>} - { context: string, metadata: Object }
 */

async function buildContext(userMessage, conversationHistory = []) {
    const metadata = {
        keywords: [],
        skillsFound: 0,
        storiesFound: 0,
        storiesAreFallback: false,
        includesWeaknesses: false,
        includesValues: false,
        enrichedFromHistory: false
    };

    try {
        let keywords = extractKeywords(userMessage);

        // If current message yields sparse keywords, enrich from conversation history
        if (keywords.length <= 1 && conversationHistory.length > 0) {
            const historyKeywords = extractKeywordsFromHistory(conversationHistory);
            if (historyKeywords.length > 0) {
                keywords = [...new Set([...keywords, ...historyKeywords])];
                metadata.enrichedFromHistory = true;
            }
        }

        metadata.keywords = keywords;

        const skills = await findMatchingSkills(keywords);
        metadata.skillsFound = skills.length;

        // Find stories by title keywords, then skills, then fallback to random
        const { stories, isFallback } = await findRelatedStories(keywords, skills);
        metadata.storiesFound = stories.length;
        metadata.storyIds = stories.map(s => s.story_id);
        metadata.storiesAreFallback = isFallback;

        const workHistory = await getWorkHistory(keywords);

        const askingAboutWeaknesses = isAskingAboutWeaknesses(userMessage);
        let weaknesses = [];
        if ( askingAboutWeaknesses ) {
            weaknesses = await getWeaknesses();
            metadata.includesWeaknesses = weaknesses.length > 0;
        }

        const coreValues = await getCoreValues();
        metadata.includesValues = coreValues.length > 0;

        // Get complete skills inventory for full context
        const allSkills = await getAllSkills();

        const section = [
            formatSkills(skills),
            formatAllSkills(allSkills),
            formatStories(stories, isFallback),
            formatWorkHistory(workHistory),
            formatWeaknesses(weaknesses),
            formatCoreValues(coreValues)
        ].filter(section => section.length > 0);

        const context = section.join('\n\n');

        return { context, metadata };

    } catch (error) {
        console.error('Context builder error:', error);
        return {
            context: '',
            metadata: {
                ...metadata,
                error: error.message
            }
        };
    }
}


module.exports = {
  buildContext,
  extractKeywords,
  extractKeywordsFromHistory,
  isAskingAboutWeaknesses,
  findMatchingSkills,
  findRelatedStories,
  getWorkHistory,
  getWeaknesses,
  getCoreValues,
  getAllSkills,
  CONFIG
};