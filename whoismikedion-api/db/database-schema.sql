USE whoismikedion;


DROP TABLE IF EXISTS chat_messages;
DROP TABLE IF EXISTS chat_sessions;
DROP TABLE IF EXISTS skill_weaknesses;
DROP TABLE IF EXISTS weaknesses;
DROP TABLE IF EXISTS work_story_links;
DROP TABLE IF EXISTS story_skills;
DROP TABLE IF EXISTS work_history;
DROP TABLE IF EXISTS stories;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS core_values;
DROP TABLE IF EXISTS profile;


CREATE TABLE profile (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    tagline VARCHAR(255) NOT NULL,
    photo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE core_values (
    id INT PRIMARY KEY AUTO_INCREMENT,
    value_text VARCHAR(255) NOT NULL,
    description TEXT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    skill_id VARCHAR(100) UNIQUE NOT NULL,
    canonical_name VARCHAR(100) NOT NULL,
    category ENUM('pm_competency', 'technical_skill', 'soft_skill', 'domain_knowledge') NOT NULL,
    proficiency ENUM('expert', 'proficient', 'developing') NOT NULL,
    synonyms TEXT,  -- JSON array: ["synonym1", "synonym2"]
    notes TEXT,
    is_top_skill BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_skill_id (skill_id),
    INDEX idx_category (category),
    INDEX idx_proficiency (proficiency)
);


CREATE TABLE stories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    story_id VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    context TEXT NOT NULL,
    challenge TEXT NOT NULL,
    solution TEXT NOT NULL,
    outcome TEXT NOT NULL,
    quantifiable_impact TEXT,
    skills_demonstrated TEXT,  -- Summary text
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_story_id (story_id)
);


CREATE TABLE work_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,  
    key_accomplishments TEXT,  
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_dates (start_date, end_date)
);


CREATE TABLE story_skills (
    story_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (story_id, skill_id),
    FOREIGN KEY (story_id) REFERENCES stories(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
    INDEX idx_story (story_id),
    INDEX idx_skill (skill_id)
);


CREATE TABLE work_story_links (
    work_id INT NOT NULL,
    story_id INT NOT NULL,
    PRIMARY KEY (work_id, story_id),
    FOREIGN KEY (work_id) REFERENCES work_history(id) ON DELETE CASCADE,
    FOREIGN KEY (story_id) REFERENCES stories(id) ON DELETE CASCADE,
    INDEX idx_work (work_id),
    INDEX idx_story (story_id)
);


CREATE TABLE weaknesses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    weakness_id VARCHAR(100) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    strategic_positioning TEXT,
    growth_plan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE skill_weaknesses (
    skill_id INT NOT NULL,
    weakness_id INT NOT NULL,
    PRIMARY KEY (skill_id, weakness_id),
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
    FOREIGN KEY (weakness_id) REFERENCES weaknesses(id) ON DELETE CASCADE,
    INDEX idx_skill (skill_id),
    INDEX idx_weakness (weakness_id)
);


CREATE TABLE chat_sessions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(36) UNIQUE NOT NULL, 
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_message_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    message_count INT DEFAULT 0,
    INDEX idx_session (session_id),
    INDEX idx_started (started_at)
);


CREATE TABLE chat_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT NOT NULL,
    role ENUM('user', 'assistant') NOT NULL,
    content TEXT NOT NULL,
    context_used TEXT, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES chat_sessions(id) ON DELETE CASCADE,
    INDEX idx_session_messages (session_id, created_at)
);


INSERT INTO profile (name, tagline, photo_url) VALUES
('Mike Dion', 'Technical Product Strategist Building Systems That Support Vulnerable Populations', '/images/profile.jpg');


INSERT INTO core_values (value_text, description, display_order) VALUES
('Bridge-building across divided communities', 'Fostering vulnerability that enables true integrity and compassion', 1),
('Supporting vulnerable populations through holistic systems', 'Designing systems that treat people with dignity and address root causes', 2),
('Connecting artists with audiences through accessible technology', 'Democratizing art and breaking barriers between creators and experiencers', 3);
