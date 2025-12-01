-- add-story-keywords.sql
-- Adds keywords column to stories table for better keyword matching in context builder
-- Run with: mysql -u root -p whoismikedion < scripts/add-story-keywords.sql

-- =====================================================
-- 1. ADD KEYWORDS COLUMN
-- =====================================================
ALTER TABLE stories ADD COLUMN keywords TEXT NULL;

-- =====================================================
-- 2. POPULATE KEYWORDS FOR EXISTING STORIES
-- =====================================================

UPDATE stories SET keywords = '["ai", "llm", "content", "copywriting", "bakery", "restaurant", "workflow", "budget"]'
WHERE story_id = 'STORY-001';

UPDATE stories SET keywords = '["seo", "marketing", "traffic", "leads", "builder", "construction", "google"]'
WHERE story_id = 'STORY-002';

UPDATE stories SET keywords = '["emergency", "crisis", "ecommerce", "launch", "woocommerce", "weekend", "recovery"]'
WHERE story_id = 'STORY-003';

UPDATE stories SET keywords = '["debugging", "troubleshooting", "problem solving", "pattern", "bug"]'
WHERE story_id = 'STORY-004';

UPDATE stories SET keywords = '["adhd", "process", "checklist", "requirements", "support", "team"]'
WHERE story_id = 'STORY-005';

UPDATE stories SET keywords = '["ai", "social", "polling", "platform", "wordpress", "pivot", "feature flags"]'
WHERE story_id = 'STORY-006';

UPDATE stories SET keywords = '["cms", "headless", "static", "api", "multi-site", "portfolio", "gaming"]'
WHERE story_id = 'STORY-007';

UPDATE stories SET keywords = '["game", "puzzle", "product", "0-to-1", "wordle", "perception"]'
WHERE story_id = 'STORY-008';

UPDATE stories SET keywords = '["design system", "atomic", "components", "wordpress", "acf"]'
WHERE story_id = 'STORY-009';

UPDATE stories SET keywords = '["birthday", "scavenger hunt", "iot", "magic", "personal", "creative"]'
WHERE story_id = 'STORY-010';

UPDATE stories SET keywords = '["gtm", "go-to-market", "marketing", "b2b", "sales"]'
WHERE story_id = 'STORY-011';

UPDATE stories SET keywords = '["hospital", "badge", "door access", "database", "healthcare", "merger"]'
WHERE story_id = 'STORY-012';

UPDATE stories SET keywords = '["portfolio", "vue", "node", "chat", "ai", "this project"]'
WHERE story_id = 'STORY-013';

UPDATE stories SET keywords = '["maintenance", "hospital", "php", "on-call", "preventative", "healthcare"]'
WHERE story_id = 'STORY-014';

UPDATE stories SET keywords = '["committee", "safety", "hipaa", "compliance", "healthcare", "pandemic"]'
WHERE story_id = 'STORY-015';
