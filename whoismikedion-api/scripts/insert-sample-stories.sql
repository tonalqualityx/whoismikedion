-- Stories Data for Mike Dion
-- Database: whoismikedion
-- Generated from actual story files

USE whoismikedion;

-- Insert all 12 stories with actual content
INSERT INTO stories (story_id, title, context, challenge, solution, outcome, quantifiable_impact, skills_demonstrated) VALUES

('STORY-001',
 'Restaurant Content Strategy - LLM-Assisted Workflow',
 'Client opening restaurant with community-building mission needed authentic content on modest $4k budget. Traditional copywriting not feasible at this price point.',
 'Limited budget, client couldn''t articulate vision in writing, needed content that captured authentic voice AND deeper mission, typical web content would miss emotional/community aspect.',
 'Built systematic LLM-assisted workflow: deep discovery interview, market research via AI, integration and synthesis, section-by-section content generation, live client review for real-time feedback and adjustments.',
 'Client had emotional reaction (tears/goosebumps) to content. Delivered $15k+ value on $4k budget. Process efficient enough to be profitable. Content authentically captured voice and mission.',
 '$15k value on $4k budget (375% multiplier), feedback cycle reduced from weeks to hours',
 'Product strategy, systems thinking, AI workflow design, user research, process innovation, stakeholder management, value creation'),

('STORY-002',
 'Luxury Home Builder SEO Strategy',
 'Vermont luxury home builder getting <20 monthly visitors and 1-2 leads per YEAR. Small $1,500/month budget had to cover content creation AND promotion.',
 'Competitive keywords, long sales cycles, limited budget split between content and promotion, needed qualified leads not just traffic in small local market.',
 'Strategic budget allocation (50% content, 50% Facebook ads). Wrote content himself for quality control. Targeted achievable keywords with purchase intent. Monthly owner interviews for authentic expertise. Vermont-specific case studies.',
 'Traffic increased 900%+ (20 to 200-300 monthly). Achieved #1 Google ranking for "how to build a new home in Vermont". Lead generation increased 1200% (2-3 qualified leads/month vs 1-2/year). Results maintained 6+ months AFTER campaign ended.',
 '900%+ traffic increase, 1200%+ lead increase, #1 ranking maintained, sustainable results 6+ months post-campaign',
 'Strategic thinking, market research, content strategy, stakeholder management, ROI focus, long-term planning, sustainable value creation'),

('STORY-003',
 'Emergency E-Commerce Migration',
 'Friend''s kratom product launch crashed due to poor WordPress site and garbage hosting. Had to pull back launch. Mike called for weekend emergency rebuild.',
 'Weekend timeline (4 days), site had to handle launch traffic, kratom industry legal compliance, new business needed separation from old business, every day offline = lost sales momentum, no LLM assistance available (pre-modern era).',
 'Weekend 1: Emergency meeting, rapid content strategy with legal compliance, designer built mockups. Weekend 2: Built new WordPress site from scratch (60+ person-hours), infrastructure upgrade to proper hosting, launch coordination.',
 '$6,000 in first-day sales. Site stayed up under launch traffic (vs previous 0% uptime). Site paid for itself by day 2. Zero downtime during high-traffic launch. Proper business separation achieved.',
 '4-day timeline, 60+ person-hours, $6k day 1 revenue, 100% uptime vs 0% previous attempt',
 'Crisis management, project management, technical architecture, risk mitigation, compliance navigation, team leadership, cross-functional coordination'),

('STORY-004',
 'Poodle Debugging - Pattern Recognition',
 'Business partner stuck for hours getting garbage data from WordPress AJAX filters. Variable name was reserved word, but partner tested with another reserved word and assumed that wasn''t the issue.',
 'Partner tried "category" → "tag" (both reserved), assumed not reserved word problem. Getting increasingly frustrated. Time pressure - client work blocked.',
 'Immediately suspected reserved word. Asked clarifying question: "What other word did you try?" Suggested testing with nonsense word: "Let''s call it poodle" - eliminated variable as factor entirely. Problem solved immediately.',
 'Hours of stuck time → minutes to solution. Partner learned debugging methodology (test with extremes). Strengthened pattern recognition reputation. Work could proceed.',
 'Hours to minutes resolution time, taught reusable debugging methodology',
 'Debugging methodology, pattern recognition, emotional regulation, teaching, communication, trust building, calm under pressure'),

('STORY-005',
 'Business Partner Support System',
 'Partner consistently missing requirements from multi-part emails, shipping incomplete work. Company "hanging on for dear life" financially - couldn''t afford rework.',
 'Two distinct failure modes: no internal operational checklist (would ship without basic QA), inability to extract multi-part requirements from complex emails (would complete 60% and think done).',
 'Built two-tier checklist system: (1) SOPs with one-click Trello automation for quality checks (mobile responsiveness, completeness, etc.), (2) Requirements extraction - Mike parsed emails into discrete checklist items. Made it mandatory: all tickets must have both.',
 'Partner completed tasks correctly first time much more frequently. Reduced incomplete work comebacks from clients. Mobile issues caught before shipping. Multi-part requirements no longer missed.',
 'Significant quality improvement (mandatory across all work), reduced client comeback rate',
 'Pattern recognition, systems thinking, empathy, process design, requirements translation, automation mindset, individual adaptation, leadership'),

('STORY-006',
 'AI-Powered Social Polling Platform',
 'Client building social polling platform with constantly shifting requirements over nearly a year. Started simple (2-option polls, no accounts) and evolved dramatically.',
 'Requirements changed continuously - features built, launched, disabled days later. Working through 20-year-old with limited technical understanding. Mockups in Canva JPGs. "MVP" followed by 3-6 months of feature requests.',
 'Built 32 custom database tables on WordPress foundation. Recognized pattern of pivots - architected ALL features with toggle capability. Isolation strategy ensured features don''t break when disabled. Built: vector DB recommendations, AI bot personalities, ML content moderation, custom commenting, user profiles, feed algorithms.',
 'Built sophisticated AI/ML platform on rapid timelines. Feature toggle system prevented cascade failures. Delivered features in 1-3 day sprints consistently. Maintained code quality despite year of pivots. Professional relationship maintained despite difficult circumstances.',
 '~1 year development, 15+ major features, 32 custom tables, 3 external APIs, 1-3 day sprint velocity, zero cascade failures',
 'AI/ML integration, system architecture, API design, database design, feature flag patterns, dependency management, technical debt management, stakeholder management, rapid delivery, professional maturity'),

('STORY-007',
 'Headless CMS Platform - Multi-Tenant SaaS',
 'Client managing dozen+ gaming sites, manually updating same games across all sites with clunky page builders. Every game update required updating all sites individually.',
 'Updating one game = updating dozen+ sites manually. No single source of truth. Inconsistent implementations. Time-consuming maintenance.',
 'Built centralized WordPress CMS as content hub. Multi-tenant site configuration (branding, templates, game selection, tracking codes). Static site generation from JSON payloads. Dual provisioning: new site creation via API, existing site updates via JSON push. Template system for extensibility.',
 'One-to-many updates: add game once, propagates everywhere. Centralized management for entire portfolio. 99 GTmetrix scores baseline. Scalable to unlimited sites. Guaranteed consistency across portfolio.',
 'Dozen+ sites managed centrally, hours to minutes for portfolio updates, 99 GTmetrix scores, 100% consistency',
 'Multi-tenant SaaS design, API-first architecture, static site generation, scalability planning, single source of truth, headless CMS, performance optimization'),

('STORY-008',
 'Depixelit - Daily Image Puzzle Game (0-1 Product)',
 'Client found Paper.js division raster demo and envisioned daily puzzle game - "Wordle for images" where users depixelate images to guess content.',
 'The Perception Problem: Image starts as 1 rectangle, full reveal = 2,073,600 pixels. Early splits create huge visual changes but tiny mathematical progress. True percentage would show 0.0001% when user sees massive progress. What looks "pretty much complete" would show as tiny percentage.',
 'Designed perceptual curve for progress display: weighted early rectangle splits more heavily, compressed later splits. Progress increases faster early (big visual changes), slower later (imperceptible changes). Display matched what user SEES, not mathematical truth.',
 'Successfully launched 0-1 product. Progress display aligned with human perception. Users feel consistent advancement. No frustrating "stuck at 0.01%" experience. Daily puzzle game with archive system and hint/guess mechanics.',
 '2,073,600 potential rectangles per image, daily puzzles + archive + hints + progress tracking',
 'Product development (0-1), user experience design, perception vs reality problem-solving, algorithm design, user psychology, product sense, mathematical modeling'),

('STORY-009',
 'Atomic Design System - Component Library',
 'Client needed professionally designed pages initially, but wanted ability to add/remove components independently post-launch without developer intervention.',
 'Balance flexibility with performance. Make intuitive for non-technical users. Build for extensibility. Avoid page builder bloat while maintaining user-friendliness.',
 'Implemented atomic design: atoms (buttons, inputs) → molecules (button groups, form fields) → organisms (navigation, hero sections) → sections (complete blocks). Programmatic ACF definitions. Each component defined once, reused everywhere. Master features admin with drag-and-drop section arrangement.',
 'Client manages pages independently post-launch. All green Lighthouse scores initially. Clean, maintainable codebase. Easy to extend with new components. Performance degradation came from client choices (FontAwesome, large images), not architecture.',
 'All green Lighthouse scores, server + edge caching, client self-sufficiency post-launch',
 'Platform engineering, atomic design patterns, component architecture, performance optimization, user empowerment, DRY principles, frontend architecture'),

('STORY-010',
 'Birthday Scavenger Hunts - Technology as Magic',
 'Annual tradition starting ~2012 - building custom web-based scavenger hunts for wife''s birthdays. Started because they were broke - instead of expensive gifts, she''d follow clues around region.',
 'Zero budget, one night to build (April 6-7 overnight), make technology feel magical not mechanical, mobile browser constraints, rural Vermont GPS coverage, express care through custom experiences.',
 'Greatest Showman: Curtain animation that rises to start music (turned audio requirement into theatrical experience). AOL Instant Messenger: Full interface recreation of their pre-dating story. Triwizard Tournament: Location-aware spells, IoT integration (Alohomora unlocked actual doors via Amazon Dots), multi-user wand system, geofencing.',
 'Created unique experiences "nobody else in the world would ever have". Technology felt like actual magic (door unlock "REALLY felt like magic"). Best reaction: Triwizard Tournament. Learned ruthless prioritization under extreme constraints.',
 'Built in single overnight sessions (5-6am bedtime), most complex: Triwizard with geolocation + IoT + multi-user',
 'User experience design, emotional design, geolocation technology, IoT integration, rapid development, crisis management, product philosophy, user psychology'),

('STORY-011',
 'Vermont Hardwoods GTM Strategy',
 'Spec work for Vermont Hardwoods trying to break into metro frame shop markets. Shops stick with existing suppliers unless customers demand new products.',
 'Traditional B2B push not working - shops resistant to being sold to. Switching suppliers is work with no incentive unless customer demand exists.',
 'Dual-channel strategy: (1) Send shops framed Google reviews of their business as gifts (made from product - sample + appreciation + marketing), (2) Run consumer ads in shop areas: "Ask for Vermont Hardwoods". Create demand pull - shops hear from both supplier AND customers simultaneously.',
 'Proposal not accepted due to budget (~$10k + materials + ad spend too high). Learned to present multiple pricing tiers instead of single option.',
 'Projected: 50-200 shops targeted, thousands of consumer ad reach per metro',
 'Strategic thinking, go-to-market innovation, demand creation, multi-channel marketing, systems thinking, audience segmentation, creative problem-solving'),

('STORY-012',
 'Hospital Systems Management',
 'Contracted through Indelible as technical support in hospital maintenance department. Managed door access control and badge management across two merged organizations with shared systems.',
 'Very old door/badge system with parts that never worked (holiday schedules). Two merged companies using employee numbers as sole identifier - collision risk. Badge issues affected timeclock, creating HR problems that appeared as maintenance tickets.',
 'Built custom PHP/MySQL/JavaScript tool suite for maintenance operations. Database detective work: When employees couldn''t clock in ("employee terminated" error), systematically diagnosed database collision - system found old terminated record in Company 1 DB before checking Company 3''s active record. Direct SQL troubleshooting for ongoing access issues.',
 'Resolved 100% of badge/timeclock issues. Built functioning custom tools. Identified critical technical debt (employee numbering collision) before systemic failure. Zero security incidents managing door access across merged organizations.',
 'Zero security incidents, 100% issue resolution, identified architectural flaw before systemic failure',
 'Database design, SQL proficiency, full-stack development, technical debugging, systems thinking, cross-functional coordination, legacy system management, risk identification, stakeholder management');


-- Link stories to skills
-- Note: Skill IDs should match the skills table in your database

-- STORY-001: Restaurant Content Strategy
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-001'
AND sk.skill_id IN ('product-strategy', 'systems-thinking', 'stakeholder-management', 'process-innovation');

-- STORY-002: Luxury Home Builder SEO
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-002'
AND sk.skill_id IN ('product-strategy', 'market-research', 'content-strategy', 'strategic-thinking');

-- STORY-003: Emergency E-Commerce Migration
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-003'
AND sk.skill_id IN ('crisis-management', 'project-management', 'technical-architecture', 'team-leadership');

-- STORY-004: Poodle Debugging
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-004'
AND sk.skill_id IN ('debugging', 'pattern-recognition', 'technical-troubleshooting', 'mentoring');

-- STORY-005: Business Partner Support System
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-005'
AND sk.skill_id IN ('systems-thinking', 'process-design', 'product-strategy', 'leadership');

-- STORY-006: AI Polling Platform
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-006'
AND sk.skill_id IN ('ai-ml-integration', 'system-architecture', 'api-design', 'database-design', 'stakeholder-management');

-- STORY-007: Headless CMS Platform
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-007'
AND sk.skill_id IN ('system-architecture', 'api-design', 'performance-optimization', 'scalability-planning');

-- STORY-008: Depixelit
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-008'
AND sk.skill_id IN ('product-strategy', 'ux-design', 'algorithm-design', 'user-psychology');

-- STORY-009: Atomic Design System
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-009'
AND sk.skill_id IN ('platform-engineering', 'component-architecture', 'frontend-architecture', 'performance-optimization');

-- STORY-010: Birthday Scavenger Hunts
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-010'
AND sk.skill_id IN ('ux-design', 'iot-integration', 'rapid-development', 'product-strategy', 'user-psychology');

-- STORY-011: Vermont Hardwoods GTM
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-011'
AND sk.skill_id IN ('strategic-thinking', 'go-to-market-strategy', 'marketing-strategy', 'creative-problem-solving');

-- STORY-012: Hospital Systems Management
INSERT INTO story_skills (story_id, skill_id)
SELECT s.id, sk.id
FROM stories s
CROSS JOIN skills sk
WHERE s.story_id = 'STORY-012'
AND sk.skill_id IN ('database-design', 'sql', 'full-stack-development', 'technical-debugging', 'systems-thinking');


-- Verify data was inserted
SELECT
  s.story_id,
  s.title,
  COUNT(ss.skill_id) as skill_count
FROM stories s
LEFT JOIN story_skills ss ON s.id = ss.story_id
GROUP BY s.id
ORDER BY s.story_id;

-- Show summary of quantifiable impacts
SELECT
  story_id,
  title,
  quantifiable_impact
FROM stories
ORDER BY story_id;