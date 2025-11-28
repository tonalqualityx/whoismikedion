-- Work History Data for Mike Dion
-- Run with: mysql -u root -p whoismikedion < insert-work-history.sql

USE whoismikedion;

-- Clear existing data (safe for fresh start)
DELETE FROM work_story_links;
DELETE FROM work_history;

-- Reset auto-increment
ALTER TABLE work_history AUTO_INCREMENT = 1;

-- ============================================
-- INSERT WORK HISTORY
-- ============================================
-- Ordered by start_date for insertion, displayed reverse chronologically

-- Position 1: Independent Consulting (2022-present)
INSERT INTO work_history (title, company, start_date, end_date, key_accomplishments, display_order) VALUES
(
    'Independent Consultant',
    'Independent Consulting',
    '2022-01-01',
    NULL,  -- Current position
    '["Product strategy consulting for mission-driven organizations", "AI integration and systems design for social services", "Technical product management for vulnerable population support systems", "WordPress and web application development consulting"]',
    1
);

-- Position 2: Indelible (2013-present)
INSERT INTO work_history (title, company, start_date, end_date, key_accomplishments, display_order) VALUES
(
    'Founder & Product Manager',
    'Indelible',
    '2013-01-01',
    NULL,  -- Current position (concurrent with consulting)
    '["Built and grew restaurant content management platform from concept to 200+ clients", "Led product strategy, UX design, and technical architecture decisions", "Reduced client support tickets by 73% through strategic UX redesign", "Developed and maintained WordPress plugin architecture serving thousands of monthly users", "Created content strategy systems that increased client engagement metrics"]',
    2
);

-- Position 3: Executive Cellular Phones (2011-2014)
INSERT INTO work_history (title, company, start_date, end_date, key_accomplishments, display_order) VALUES
(
    'Special Projects',
    'Executive Cellular Phones',
    '2011-01-01',
    '2014-12-31',
    '["Created internal tools to streamline business operations", "Authored comprehensive training manuals for staff onboarding", "Processed and analyzed sales data to inform business decisions", "Developed systems for tracking and reporting key metrics"]',
    3
);

-- ============================================
-- LINK STORIES TO WORK POSITIONS
-- ============================================
-- Stories 001-005 → Indelible
-- Stories 006-009 → Independent Consulting
-- Story 010 → No work link (passion project)

-- Link Indelible stories (STORY-001 through STORY-005)
INSERT INTO work_story_links (work_id, story_id)
SELECT wh.id, s.id
FROM work_history wh
CROSS JOIN stories s
WHERE wh.company = 'Indelible'
AND s.story_id IN ('STORY-001', 'STORY-002', 'STORY-003', 'STORY-004', 'STORY-005');

-- Link Independent Consulting stories (STORY-006 through STORY-009)
INSERT INTO work_story_links (work_id, story_id)
SELECT wh.id, s.id
FROM work_history wh
CROSS JOIN stories s
WHERE wh.company = 'Independent Consulting'
AND s.story_id IN ('STORY-006', 'STORY-007', 'STORY-008', 'STORY-009');

-- Note: STORY-010 is a passion project - intentionally not linked to any work position

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Show work history with story counts
SELECT 
    wh.id,
    wh.company,
    wh.title,
    DATE_FORMAT(wh.start_date, '%b %Y') as start_formatted,
    CASE 
        WHEN wh.end_date IS NULL THEN 'Present'
        ELSE DATE_FORMAT(wh.end_date, '%b %Y')
    END as end_formatted,
    COUNT(wsl.story_id) as story_count
FROM work_history wh
LEFT JOIN work_story_links wsl ON wh.id = wsl.work_id
GROUP BY wh.id
ORDER BY wh.start_date DESC;

-- Show which stories are linked to which jobs
SELECT 
    wh.company,
    s.story_id,
    s.title as story_title
FROM work_history wh
INNER JOIN work_story_links wsl ON wh.id = wsl.work_id
INNER JOIN stories s ON wsl.story_id = s.id
ORDER BY wh.start_date DESC, s.story_id;

-- Show unlinked stories (should be STORY-010)
SELECT 
    s.story_id,
    s.title,
    '(Passion Project - No work link)' as note
FROM stories s
LEFT JOIN work_story_links wsl ON s.id = wsl.story_id
WHERE wsl.work_id IS NULL;
