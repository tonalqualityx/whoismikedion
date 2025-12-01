USE whoismikedion;

-- ============================================
-- DROP EXISTING TABLES (if recreating)
-- ============================================
-- Uncomment these lines if you need to recreate tables
-- DROP TABLE IF EXISTS chat_messages;
-- DROP TABLE IF EXISTS chat_sessions;

-- ============================================
-- CREATE CHAT SESSIONS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS chat_sessions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(36) UNIQUE NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_message_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    message_count INT DEFAULT 0,
    cleared_at TIMESTAMP NULL DEFAULT NULL,
    INDEX idx_session (session_id),
    INDEX idx_started (started_at)
);

-- ============================================
-- CREATE CHAT MESSAGES TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS chat_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT NOT NULL,
    role ENUM('user', 'assistant') NOT NULL,
    content TEXT NOT NULL,
    context_used TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES chat_sessions(id) ON DELETE CASCADE,
    INDEX idx_session_messages (session_id, created_at)
);

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Check tables were created
SHOW TABLES LIKE 'chat%';

-- Describe table structures
DESCRIBE chat_sessions;
DESCRIBE chat_messages;

-- Show indexes
SHOW INDEX FROM chat_sessions;
SHOW INDEX FROM chat_messages;