-- db-updates-11-30-b.sql
-- Updates STORY-014, adds new skills, adds committee story (STORY-015)
-- Run with: mysql -u root -p whoismikedion < scripts/db-updates-11-30-b.sql

-- =====================================================
-- 1. UPDATE STORY-014: Add card access inventory notification
-- =====================================================
UPDATE stories
SET solution = 'Built custom PHP/MySQL/JavaScript web application from scratch. Designed mobile/iPad-friendly interface for non-technical maintenance staff. Card access module with full history tracking for troubleshooting and automatic low-inventory notifications when card stock ran low. On-call system with automatic schedule generation following business logic (weekly rotation), clickable contact info (page, home, cell), and custom print styles for those preferring paper. Flexible PM database architecture handling different machine types, multiple components with different maintenance rhythms, auto-scheduling next maintenance upon completion, overdue views for management, and parts ordering integration. Added mailbox directory with self-service update requests and approval workflow. Set up Linux server at Indelible to host the application.'
WHERE id = 14;

-- =====================================================
-- 2. NEW SKILLS
-- =====================================================

-- Adobe Lightroom (proficient)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    90,
    'adobe-lightroom',
    'Adobe Lightroom',
    'technical_skill',
    'proficient',
    '["lightroom", "photo editing", "lightroom classic", "photo processing", "raw processing"]',
    NULL,
    0
);

-- Adobe Photoshop (developing)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    91,
    'adobe-photoshop',
    'Adobe Photoshop',
    'technical_skill',
    'developing',
    '["photoshop", "image editing", "photo manipulation", "PS", "raster graphics"]',
    NULL,
    0
);

-- Videography (proficient)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    92,
    'videography',
    'Videography',
    'technical_skill',
    'proficient',
    '["video production", "filming", "video shooting", "camera work", "video capture"]',
    NULL,
    0
);

-- Risk Assessment (pm_competency, proficient)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    93,
    'risk-assessment',
    'Risk Assessment',
    'pm_competency',
    'proficient',
    '["risk analysis", "risk evaluation", "risk identification", "risk management", "compliance assessment"]',
    NULL,
    0
);

-- Healthcare (domain_knowledge, proficient)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    94,
    'healthcare',
    'Healthcare',
    'domain_knowledge',
    'proficient',
    '["medical", "health systems", "hospital", "clinical", "patient care", "HIPAA"]',
    NULL,
    0
);

-- =====================================================
-- 3. NEW STORY: Safety & Technical Committees (STORY-015)
-- =====================================================
INSERT INTO stories (id, story_id, title, context, challenge, solution, outcome, quantifiable_impact, skills_demonstrated)
VALUES (
    15,
    'STORY-015',
    'Healthcare Safety & Technical Committee Participation',
    'Hospital organization with established safety committee and newly formed technical committee. Safety committee covered broad areas from emergency preparedness to physical safety protocols. Technical committee was created to align technical stakeholders across departments (IT, building maintenance, marketing, nursing) on technology decisions and HIPAA compliance.',
    'Learning the organizational landscape while contributing meaningfully to cross-departmental coordination. Needed to represent maintenance department perspective while understanding the broader technical and safety needs of a healthcare organization. Both committees dealt with complex compliance requirements including HIPAA risk assessments and safety protocols.',
    'Served as regular member on both committees, responsible for keeping and distributing meeting notes. Brought insights from maintenance department as well as technical perspective to discussions. Participated in HIPAA compliance risk assessments through the technical committee and various safety risk assessments through the safety committee. Contributed to emergency preparedness planning including active shooter protocols, lockdown procedures, and outbreak preparedness discussions.',
    'Gained valuable experience in healthcare organizational dynamics and compliance requirements. Improved cross-departmental coordination through committee participation. When the pandemic arrived, leveraged outbreak preparedness knowledge to design and deploy safety signage throughout the building to reduce traffic and ensure protocol compliance.',
    'Participation in 2 cross-functional committees, contributed to HIPAA and safety risk assessments, pandemic signage deployment across facility',
    'Cross-functional coordination, stakeholder management, communication, risk assessment, healthcare domain knowledge, compliance navigation'
);

-- =====================================================
-- 4. LINK STORY-015 TO SKILLS (story_skills junction table)
-- =====================================================
INSERT INTO story_skills (story_id, skill_id) VALUES
    (15, 2),   -- stakeholder-management
    (15, 15),  -- cross-functional-coordination
    (15, 46),  -- communication
    (15, 93),  -- risk-assessment (new)
    (15, 94),  -- healthcare (new)
    (15, 72);  -- compliance-navigation (existing)

-- =====================================================
-- 5. LINK WORK HISTORY TO STORY (work_story_links junction table)
-- =====================================================
INSERT INTO work_story_links (work_id, story_id) VALUES (4, 15);

-- =====================================================
-- 6. UPDATE TOP SKILLS
-- =====================================================
-- Add 5 additional skills to top skills list based on story frequency and alignment with telos
UPDATE skills SET is_top_skill = 1 WHERE skill_id = 'stakeholder-management';  -- 3 stories, expert
UPDATE skills SET is_top_skill = 1 WHERE skill_id = 'database-design';         -- 4 stories, proficient
UPDATE skills SET is_top_skill = 1 WHERE skill_id = 'api-design';              -- 3 stories, expert
UPDATE skills SET is_top_skill = 1 WHERE skill_id = 'user-psychology';         -- 2 stories, expert
UPDATE skills SET is_top_skill = 1 WHERE skill_id = 'performance-optimization'; -- 2 stories, expert
