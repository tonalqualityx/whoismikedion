-- db-updates-11-30.sql
-- Adds SMCS job, Adobe skills, Linux skill, and maintenance platform story
-- Run with: mysql -u root -p whoismikedion < scripts/db-updates-11-30.sql

-- =====================================================
-- 1. NEW WORK HISTORY: Springfield Medical Care Systems
-- =====================================================
INSERT INTO work_history (id, title, company, start_date, end_date, key_accomplishments, display_order)
VALUES (
    4,
    'Engineer',
    'Springfield Medical Care Systems',
    '2015-01-01',
    '2016-06-30',
    '[
        "Managed door/card access database and security camera systems for hospital network",
        "Built custom PHP/MySQL web application for on-call scheduling with automatic calendar generation, holiday rotations, and manual swap overrides",
        "Designed flexible preventative maintenance system with variable data structures for different machine types, auto-scheduling, and overdue tracking",
        "Created parts ordering integration and inventory tracking for card access and PM supplies",
        "Built mailbox directory with self-service update requests and approval workflow",
        "Developed MS Access tool for HR to process employee raises",
        "Produced video content using Adobe Premiere and After Effects",
        "Set up and configured Linux server at Indelible to host the application",
        "Transitioned to Indelible client relationship post-employment, maintaining the systems"
    ]',
    4
);

-- =====================================================
-- 2. NEW SKILLS
-- =====================================================

-- Adobe Premiere
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    87,
    'adobe-premiere',
    'Adobe Premiere',
    'technical_skill',
    'proficient',
    '["premiere pro", "video editing", "premiere", "video production"]',
    NULL,
    0
);

-- Adobe After Effects
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    88,
    'adobe-after-effects',
    'Adobe After Effects',
    'technical_skill',
    'proficient',
    '["after effects", "motion graphics", "AE", "visual effects", "compositing"]',
    NULL,
    0
);

-- Linux
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    89,
    'linux',
    'Linux',
    'technical_skill',
    'proficient',
    '["ubuntu", "debian", "linux server", "bash", "shell", "command line", "terminal"]',
    'Primary development OS for 8 years',
    0
);

-- =====================================================
-- 3. NEW STORY: Healthcare Maintenance Operations Platform
-- =====================================================
INSERT INTO stories (id, story_id, title, context, challenge, solution, outcome, quantifiable_impact, skills_demonstrated)
VALUES (
    14,
    'STORY-014',
    'Healthcare Maintenance Operations Platform',
    'Hospital maintenance department relying on manual processes: physical notebook mapping card numbers to employees (100+ staff, thousands of cards over years - essentially useless for troubleshooting), spreadsheet calendars requiring manual printing and physical delivery to multiple departments for on-call schedules, and printed maintenance sheets literally taped to air handlers at each location (one filter bank was lost for years because of this system).',
    'First production application ever built (only basic WordPress experience prior). Required complex database architecture decisions: role-based access control with different permission levels, calendar logic handling rotating on-call schedules with holiday rotations and manual swap overrides, and flexible PM system supporting variable machine types with different maintenance rhythms, multiple components per machine, and varying part requirements.',
    'Built custom PHP/MySQL/JavaScript web application from scratch. Designed mobile/iPad-friendly interface for non-technical maintenance staff. Card access module with full history tracking for troubleshooting. On-call system with automatic schedule generation following business logic (weekly rotation), clickable contact info (page, home, cell), and custom print styles for those preferring paper. Flexible PM database architecture handling different machine types, multiple components with different maintenance rhythms, auto-scheduling next maintenance upon completion, overdue views for management, and parts ordering integration. Added mailbox directory with self-service update requests and approval workflow. Set up Linux server at Indelible to host the application.',
    'System used for 5 years before organization transitioned to commercial subscription solution. Single source of truth eliminated constant out-of-date schedule issues and physical distribution runs. PM reporting provided visibility into completed and pending work that was never available when paperwork lived scattered on machines throughout the building. Lost filter bank captured immediately upon discovery - system ensured it would never be overlooked again. Self-service mailbox updates reduced administrative overhead and kept information current.',
    '5 years in production use, eliminated paper-based processes across 4 functional areas, prevented \"lost\" maintenance tasks, self-service updates reduced administrative overhead',
    'PHP development, database design, SQL, user experience design, debugging methodology, Linux administration, full-stack development, human-centered design'
);

-- =====================================================
-- 4. LINK STORY TO SKILLS (story_skills junction table)
-- =====================================================
INSERT INTO story_skills (story_id, skill_id) VALUES
    (14, 40),  -- php-development
    (14, 39),  -- sql
    (14, 21),  -- database-design
    (14, 73),  -- user-experience-design
    (14, 31),  -- debugging-methodology
    (14, 89);  -- linux (new)

-- =====================================================
-- 5. LINK WORK HISTORY TO STORY (work_story_links junction table)
-- =====================================================
INSERT INTO work_story_links (work_id, story_id) VALUES (4, 14);
