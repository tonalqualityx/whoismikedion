-- STORY-013: Who is Mike Dion - AI-Powered Portfolio Platform
-- Database: whoismikedion

USE whoismikedion;

-- Insert the story
INSERT INTO stories (story_id, title, context, challenge, solution, outcome, quantifiable_impact, skills_demonstrated) VALUES
('STORY-013',
 'Who is Mike Dion - AI-Powered Portfolio Platform',
 'Needed a way to showcase professional experience in an engaging, interactive format. Traditional resumes and portfolios don''t convey the depth of skills and stories that demonstrate real capability.',
 'How to build a system that captures the complexity of professional experience - stories, skills, work history - and makes it accessible through natural conversation? Needed to connect narrative examples to specific competencies while making exploration intuitive.',
 'Built full-stack platform with Node.js/Express API backend, Vue.js frontend, and MySQL database. Designed relational schema with stories, skills, and work history connected through junction tables. Integrated Claude API for conversational interface that can surface relevant stories based on skill queries. Custom context builder assembles relevant data for each chat interaction.',
 'Working portfolio platform with 12+ stories linked to 80+ skills across 4 categories. Chat interface powered by Claude understands natural queries and surfaces relevant experience. Architecture demonstrates exactly the skills it describes - a meta-proof of capability.',
 '32 database tables, 80+ skills catalogued, 12+ stories with quantifiable impacts, real-time AI chat, full API documentation',
 'AI/ML integration, API design, database design, system architecture, frontend development, 0-to-1 product development, rapid prototyping');

-- Link story to skills
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-013'
AND sk.skill_id IN (
    'ai-ml-integration',
    'api-design',
    'database-design',
    'system-architecture',
    'frontend-development',
    '0-to-1-product-development',
    'rapid-prototyping'
);

-- Link to Independent Consulting work history
INSERT INTO work_story_links (work_id, story_id)
SELECT w.id, s.id
FROM work_history w
CROSS JOIN stories s
WHERE w.company = 'Independent Consulting'
AND s.story_id = 'STORY-013';

-- Verify insertion
SELECT
  s.story_id,
  s.title,
  COUNT(ss.skill_id) as skill_count
FROM stories s
LEFT JOIN story_skills ss ON s.id = ss.story_id
WHERE s.story_id = 'STORY-013'
GROUP BY s.id;

-- Show linked skills
SELECT
  s.story_id,
  sk.canonical_name as skill,
  sk.category
FROM stories s
JOIN story_skills ss ON s.id = ss.story_id
JOIN skills sk ON ss.skill_id = sk.id
WHERE s.story_id = 'STORY-013';
