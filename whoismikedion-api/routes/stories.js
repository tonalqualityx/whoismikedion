const express = require('express');
const router = express.Router();
const db = require('../db/connection');
const { formatDateRange } = require('../utils/formatters');

//================================
// GET /api/stories
//================================

router.get('/', async (req, res) => {
    try {
        const skillFilter = req.query.skill;

        console.log('=== Stories List Endpoint Called ===');
        console.log('Skill Filter:', skillFilter || 'None');
    
        let query = `
            SELECT
                s.id,
                s.story_id,
                s.title,
                s.quantifiable_impact,
                SUBSTRING(s.context, 1, 200) as summary,
                GROUP_CONCAT(
                    DISTINCT sk.skill_id
                    ORDER BY sk.canonical_name
                    SEPARATOR ', '
                ) AS skills,
                COUNT(DISTINCT sk.id) as skill_count,
                s.created_at
            FROM stories s
            LEFT JOIN story_skills ss ON s.id = ss.story_id
            LEFT JOIN skills sk ON ss.skill_id = sk.id
        `;

        const queryParams = [];

        if(skillFilter) {
            query += `
                WHERE s.id IN (
                    SELECT story_id
                    FROM story_skills ss2
                    JOIN skills sk2 ON ss2.skill_id = sk2.id
                    WHERE sk2.skill_id = ?
                )
            `;
            queryParams.push(skillFilter);
        }

        query += `
            GROUP BY s.id
            ORDER BY s.created_at DESC
        `;

        console.log('Executing Query...');

        const [rows] = await db.query(query, queryParams);

        console.log(`Found ${rows.length} stories.`);

        const stories = rows.map(row => ({
            id: row.id,
            story_id: row.story_id,
            title: row.title,
            summary: row.summary + (row.summary.length >= 200 ? '...' : ''),
            skills: row.skills ? row.skills.split(', ') : [],
            skill_count: row.skill_count,
            quantifiable_impact: row.quantifiable_impact,
            created_at: row.created_at
        }));

        res.json({
            stories: stories,
            total: stories.length,
            filtered: !!skillFilter,
            filter: skillFilter || null
        });
    } catch (error) {
        console.error('Error fetching stories:', error);
        res.status(500).json({
            error: 'An error occurred while fetching stories.',
            message: error.message,
        });
    }
});

router.get('/:story_id', async (req, res) => {
    try {
        const storyId = req.params.story_id;

        console.log(`=== Story Detail Endpoint Called for story_id: ${storyId} ===`);

        //================================
        // Fetch Story Details
        //================================

        const [storyRows] = await db.query(
            'SELECT * FROM stories WHERE story_id = ?',
            [storyId]
        );

        // Check if story exists
        if (storyRows.length === 0 ) {
            console.log( 'Story not found.' );
            return res.status(404).json({ 
                error: 'Story not found.',
                story_id: storyId,
                message: 'No story exists with the provided story_id.'
            });
        }

        const story = storyRows[0];
        console.log('Story found:', story.title);

        //================================
        // Fetch Associated Skills
        //================================

        const [skillRows] = await db.query(`
            SELECT
                sk.skill_id,
                sk.canonical_name,
                sk.proficiency,
                sk.category
            FROM skills sk
            INNER JOIN story_skills ss ON sk.id = ss.skill_id
            WHERE ss.story_id = ?
            ORDER BY sk.canonical_name ASC
        `, [story.id]);

        console.log(`Found ${skillRows.length} associated skills.`);

        //================================
        // Get Related Work History
        //================================

        const [workRows] = await db.query( `
            SELECT
                wh.title,
                wh.company,
                wh.start_date,
                wh.end_date
            FROM work_history wh
            INNER JOIN work_story_links wsl ON wh.id = wsl.work_id
            WHERE wsl.story_id = ?
            ORDER BY wh.start_date DESC
            `, [story.id]);

        console.log(`Found ${workRows.length} related work history entries.`);

        //================================
        // Construct Response
        //================================

        const response = {
            story_id: story.story_id,
            title: story.title,
            context: story.context,
            solution: story.solution,
            outcome: story.outcome,
            quantifiable_impact: story.quantifiable_impact,
            skills : skillRows.map(skill => ({
                skill_id: skill.skill_id,
                name: skill.canonical_name,
                proficiency: skill.proficiency,
                catgory: skill.category
            })),

            work_history: workRows.map(work => ({
                title: work.title,
                company: work.company,
                dates: formatDateRange(work.start_date, work.end_date)
            })),

            created_at: story.created_at,
            updated_at: story.updated_at
        };

        res.json(response);
    
    } catch (error) {
        console.error('Error fetching story details:', error);
        res.status(500).json({
            error: 'Failed to fetch story details.',
            message: error.message
        });
    }
});



module.exports = router;