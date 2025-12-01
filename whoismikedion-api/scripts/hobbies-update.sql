-- hobbies-update.sql
-- Adds hobby category and hobby skills (music, acting)
-- Run with: mysql -u root -p whoismikedion < scripts/hobbies-update.sql

-- =====================================================
-- 1. ADD HOBBY CATEGORY TO SKILLS TABLE
-- =====================================================
ALTER TABLE skills MODIFY COLUMN category ENUM('pm_competency','technical_skill','soft_skill','domain_knowledge','hobby') NOT NULL;

-- =====================================================
-- 2. ADD HOBBY SKILLS
-- =====================================================

-- Guitar (proficient)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    95,
    'guitar',
    'Guitar',
    'hobby',
    'proficient',
    '["acoustic guitar", "electric guitar", "six-string", "instrument", "instruments", "music", "hobby", "hobbies"]',
    NULL,
    0
);

-- Bass Guitar (proficient)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    96,
    'bass-guitar',
    'Bass Guitar',
    'hobby',
    'proficient',
    '["bass", "electric bass", "four-string", "instrument", "instruments", "music", "hobby", "hobbies"]',
    NULL,
    0
);

-- Drums (proficient)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    97,
    'drums',
    'Drums',
    'hobby',
    'proficient',
    '["percussion", "drumming", "drum kit", "instrument", "instruments", "music", "hobby", "hobbies"]',
    'Plays percussion with the Black River Band',
    0
);

-- Piano (developing)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    98,
    'piano',
    'Piano',
    'hobby',
    'developing',
    '["keyboard", "keys", "piano playing", "instrument", "instruments", "music", "hobby", "hobbies"]',
    NULL,
    0
);

-- Hulusi (developing)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    99,
    'hulusi',
    'Hulusi',
    'hobby',
    'developing',
    '["chinese flute", "gourd flute", "cucurbit flute", "instrument", "instruments", "music", "hobby", "hobbies"]',
    NULL,
    0
);

-- Music Composition (developing)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    100,
    'music-composition',
    'Music Composition',
    'hobby',
    'developing',
    '["songwriting", "composing", "music writing", "hobby", "hobbies"]',
    'Some terrible old compositions available at crappymusic.io from late teens and early twenties',
    0
);

-- Acting (developing)
INSERT INTO skills (id, skill_id, canonical_name, category, proficiency, synonyms, notes, is_top_skill)
VALUES (
    101,
    'acting',
    'Acting',
    'hobby',
    'developing',
    '["theater", "theatre", "performance", "drama", "hobby", "hobbies"]',
    'Currently taking an acting class',
    0
);
