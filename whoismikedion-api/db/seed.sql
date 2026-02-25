-- ============================================
-- Who Is Mike Dion - Database Seed Data
-- ============================================
-- This file contains all seed data for the portfolio database.
-- It does NOT include chat_sessions or chat_messages (those are runtime data).
-- 
-- Usage: mysql -u root -p whoismikedion < db/seed.sql
-- 
-- Tables included:
--   - profile
--   - core_values
--   - skills
--   - stories
--   - story_skills
--   - work_history
--   - work_story_links
--   - weaknesses
--   - skill_weaknesses
-- 
-- Generated: 2025-11-29
-- ============================================

/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: whoismikedion
-- ------------------------------------------------------
-- Server version	10.11.13-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- ============================================
-- TRUNCATE TABLES (order matters for foreign keys)
-- ============================================
-- Junction tables first (no dependencies)
TRUNCATE TABLE `story_skills`;
TRUNCATE TABLE `work_story_links`;
TRUNCATE TABLE `skill_weaknesses`;
-- Then tables with foreign key references
TRUNCATE TABLE `weaknesses`;
TRUNCATE TABLE `work_history`;
TRUNCATE TABLE `stories`;
TRUNCATE TABLE `skills`;
TRUNCATE TABLE `core_values`;
TRUNCATE TABLE `profile`;

--
-- Dumping data for table `core_values`
--

LOCK TABLES `core_values` WRITE;
/*!40000 ALTER TABLE `core_values` DISABLE KEYS */;
INSERT INTO `core_values` (`id`, `value_text`, `description`, `display_order`, `created_at`) VALUES (1,'Bridge-building across divided communities','Fostering vulnerability that enables true integrity and compassion',1,'2025-11-20 21:15:50');
INSERT INTO `core_values` (`id`, `value_text`, `description`, `display_order`, `created_at`) VALUES (2,'Supporting vulnerable populations through holistic systems','Designing systems that treat people with dignity and address root causes',2,'2025-11-20 21:15:50');
INSERT INTO `core_values` (`id`, `value_text`, `description`, `display_order`, `created_at`) VALUES (3,'Connecting artists with audiences through accessible technology','Democratizing art and breaking barriers between creators and experiencers',3,'2025-11-20 21:15:50');
INSERT INTO `core_values` (`id`, `value_text`, `description`, `display_order`, `created_at`) VALUES (4,'Continuous growth through intentional learning','Combining hands-on practice with theoretical depth—reading technical manuals and leadership books while actively applying concepts to real projects. Building understanding through cross-domain learning, connecting patterns across technology, systems thinking, and leadership.',4,'2025-11-29 20:14:21');
/*!40000 ALTER TABLE `core_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` (`id`, `name`, `tagline`, `photo_url`, `created_at`, `updated_at`) VALUES (1,'Mike Dion','Product Strategist & Technical Leader | 12+ Years Turning Complex Problems Into Systems People Actually Use','/images/profile.png','2025-11-20 21:15:50','2025-11-29 22:18:56');
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `skill_weaknesses`
--

LOCK TABLES `skill_weaknesses` WRITE;
/*!40000 ALTER TABLE `skill_weaknesses` DISABLE KEYS */;
/*!40000 ALTER TABLE `skill_weaknesses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (1,'product-strategy','Product Strategy','pm_competency','expert','[\"strategic planning\", \"product planning\", \"strategic thinking\"]',NULL,1,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (2,'stakeholder-management','Stakeholder Management','pm_competency','expert','[\"client management\", \"relationship management\", \"stakeholder communication\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (3,'user-research','User Research','pm_competency','expert','[\"discovery\", \"user interviews\", \"customer research\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (4,'requirements-translation','Requirements Translation','pm_competency','expert','[\"requirements extraction\", \"technical translation\", \"requirements engineering\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (5,'roadmap-planning','Roadmap Planning','pm_competency','proficient','[\"product planning\", \"strategic planning\", \"feature prioritization\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (6,'product-vision','Product Vision','pm_competency','expert','[\"vision setting\", \"product direction\", \"strategic vision\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (7,'0-to-1-product-development','0-to-1 Product Development','pm_competency','expert','[\"new product development\", \"product creation\", \"building from scratch\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (8,'feature-prioritization','Feature Prioritization','pm_competency','expert','[\"priority setting\", \"backlog management\", \"ruthless prioritization\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (9,'go-to-market-strategy','Go-to-Market Strategy','pm_competency','proficient','[\"GTM strategy\", \"market entry\", \"launch planning\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (10,'product-marketing','Product Marketing','pm_competency','proficient','[\"marketing strategy\", \"positioning\", \"messaging\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (11,'value-proposition-development','Value Proposition Development','pm_competency','expert','[\"value creation\", \"positioning\", \"messaging strategy\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (12,'product-operations','Product Operations','pm_competency','expert','[\"product ops\", \"operational excellence\", \"process design\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (13,'metrics-and-analytics','Metrics and Analytics','pm_competency','proficient','[\"data analysis\", \"KPI tracking\", \"performance measurement\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (14,'project-management','Project Management','pm_competency','expert','[\"program management\", \"delivery management\", \"execution\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (15,'cross-functional-coordination','Cross-Functional Coordination','pm_competency','expert','[\"team coordination\", \"collaboration\", \"stakeholder alignment\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (16,'ai-ml-integration','AI/ML Integration','technical_skill','expert','[\"artificial intelligence\", \"machine learning\", \"LLM integration\"]',NULL,1,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (17,'vector-databases','Vector Databases','technical_skill','developing','[\"embeddings\", \"semantic search\", \"similarity search\", \"Redis vector\"]',NULL,0,'2025-11-20 21:24:02','2025-11-29 19:44:58');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (18,'ai-workflow-design','AI Workflow Design','technical_skill','expert','[\"LLM workflow\", \"AI process design\", \"automation workflows\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (19,'system-architecture','System Architecture','technical_skill','expert','[\"software architecture\", \"system design\", \"architectural patterns\"]',NULL,1,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (20,'api-design','API Design','technical_skill','expert','[\"REST API\", \"API architecture\", \"endpoint design\", \"AJAX\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (21,'database-design','Database Design','technical_skill','proficient','[\"data modeling\", \"schema design\", \"database architecture\"]',NULL,0,'2025-11-20 21:24:02','2025-11-29 19:46:16');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (22,'wordpress-development','WordPress Development','technical_skill','expert','[\"WP development\", \"CMS development\", \"custom theme development\"]',NULL,1,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (23,'headless-cms','Headless CMS','technical_skill','expert','[\"decoupled CMS\", \"API-first CMS\", \"JAMstack\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (24,'static-site-generation','Static Site Generation','technical_skill','expert','[\"SSG\", \"JAMstack\", \"static sites\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (25,'performance-optimization','Performance Optimization','technical_skill','expert','[\"speed optimization\", \"web performance\", \"load time optimization\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (26,'caching-strategies','Caching Strategies','technical_skill','expert','[\"server caching\", \"edge caching\", \"cache optimization\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (27,'frontend-development','Frontend Development','technical_skill','proficient','[\"UI development\", \"JavaScript\", \"web development\"]','Builds interactive frontend experiences with JavaScript, jQuery, and modern frameworks. Strong understanding of component architecture, state management, and UI patterns. Currently expanding into Vue.js and Node.js.',1,'2025-11-20 21:24:02','2025-11-29 18:27:01');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (28,'component-architecture','Component Architecture','technical_skill','expert','[\"component design\", \"atomic design\", \"design systems\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (29,'geolocation-technology','Geolocation Technology','technical_skill','proficient','[\"GPS\", \"geofencing\", \"location-based services\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (30,'iot-integration','IoT Integration','technical_skill','proficient','[\"Internet of Things\", \"smart home integration\", \"device integration\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (31,'debugging-methodology','Debugging Methodology','technical_skill','expert','[\"troubleshooting\", \"problem diagnosis\", \"systematic debugging\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (32,'content-moderation','Content Moderation','technical_skill','proficient','[\"ML moderation\", \"automated moderation\", \"safety systems\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (33,'recommendation-algorithms','Recommendation Algorithms','technical_skill','proficient','[\"recommendation engines\", \"personalization\", \"algorithmic recommendations\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (34,'multi-tenant-architecture','Multi-Tenant Architecture','technical_skill','expert','[\"SaaS architecture\", \"multi-tenancy\", \"tenant isolation\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (35,'seo-optimization','SEO Optimization','technical_skill','expert','[\"search engine optimization\", \"keyword research\", \"organic search\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (36,'feature-flags','Feature Flags','technical_skill','expert','[\"feature toggles\", \"feature management\", \"progressive delivery\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (37,'paper-js','Paper.js','technical_skill','proficient','[\"vector graphics\", \"canvas manipulation\", \"interactive graphics\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (38,'rapid-prototyping','Rapid Prototyping','technical_skill','expert','[\"quick iteration\", \"fast development\", \"MVP building\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (39,'sql','SQL','technical_skill','proficient','[\"MySQL\", \"database queries\", \"data querying\", \"SQL queries\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (40,'php-development','PHP Development','technical_skill','expert','[\"PHP programming\", \"server-side development\", \"backend development\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (41,'systems-thinking','Systems Thinking','soft_skill','expert','[\"holistic thinking\", \"system design\", \"pattern recognition\"]',NULL,1,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (42,'problem-solving','Problem Solving','soft_skill','expert','[\"analytical thinking\", \"critical thinking\", \"solution design\"]',NULL,1,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (43,'emotional-intelligence','Emotional Intelligence','soft_skill','expert','[\"EQ\", \"empathy\", \"self-awareness\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (44,'emotional-regulation','Emotional Regulation','soft_skill','expert','[\"composure\", \"stress management\", \"calm under pressure\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (45,'crisis-management','Crisis Management','soft_skill','expert','[\"emergency response\", \"pressure handling\", \"incident management\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (46,'communication','Communication','soft_skill','expert','[\"verbal communication\", \"written communication\", \"presentation\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (47,'empathy','Empathy','soft_skill','expert','[\"user empathy\", \"understanding others\", \"compassion\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (48,'pattern-recognition','Pattern Recognition','soft_skill','expert','[\"trend identification\", \"insight discovery\", \"analytical thinking\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (49,'adaptability','Adaptability','soft_skill','expert','[\"flexibility\", \"agility\", \"pivoting\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (50,'resilience','Resilience','soft_skill','expert','[\"perseverance\", \"grit\", \"persistence\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (51,'creativity','Creativity','soft_skill','expert','[\"innovation\", \"creative thinking\", \"ideation\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (52,'process-innovation','Process Innovation','soft_skill','expert','[\"process improvement\", \"workflow design\", \"operational innovation\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (53,'teaching-mentorship','Teaching & Mentorship','soft_skill','expert','[\"coaching\", \"training\", \"knowledge transfer\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (54,'attention-to-detail','Attention to Detail','soft_skill','expert','[\"detail-oriented\", \"precision\", \"thoroughness\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (55,'resourcefulness','Resourcefulness','soft_skill','expert','[\"ingenuity\", \"creative problem-solving\", \"making do with constraints\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (56,'time-management','Time Management','soft_skill','expert','[\"prioritization\", \"deadline management\", \"efficiency\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (57,'continuous-learning','Continuous Learning','soft_skill','expert','[\"lifelong learning\", \"self-education\", \"skill development\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (58,'boundary-setting-emotional','Boundary Setting (Emotional/Professional)','soft_skill','proficient','[\"emotional boundaries\", \"professional composure\", \"stress management\"]','Strong at setting boundaries around emotional pressure (3-5 second pause technique), maintaining composure with difficult stakeholders, and not taking on others\' stress. Holds technical boundaries well (standing firm on quality decisions).',0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (59,'boundary-setting-financial','Boundary Setting (Financial/Scope)','soft_skill','developing','[\"scope management\", \"financial boundaries\", \"self-advocacy\"]','Struggles with in-person scope/financial boundaries when self is beneficiary (loses 4-20 hours per project to scope creep, undercharges significantly). Strong via email (time to process). Works well with external authority (representing employer). Root cause: religious programming about self-sacrifice, difficulty advocating for own needs. Active mitigation: \'let me email you later\' script, Claude accountability system.',0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (60,'professional-grace','Professional Grace','soft_skill','expert','[\"diplomacy\", \"tact\", \"professionalism\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (61,'team-collaboration','Team Collaboration','soft_skill','developing','[\"collaborative work\", \"teamwork\", \"pair programming\", \"code review\"]','Limited formal team collaboration experience - has always been technical lead or solo. Strong collaborative instincts (defers when appropriate, advocates respectfully), but lacks exposure to modern team practices like pair programming, formal code review culture, team git workflows.',0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (62,'influence-without-authority','Influence Without Authority','soft_skill','proficient','[\"lateral influence\", \"persuasion\", \"advocacy\"]','Demonstrated ability to propose changes without positional authority (preventative maintenance tracker example). Frames proposals around others\' needs. Expects rejection gracefully. Limited exposure to collaborative decision-making as peer rather than leader.',0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (63,'content-strategy','Content Strategy','domain_knowledge','expert','[\"editorial strategy\", \"content planning\", \"content development\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (64,'seo-strategy','SEO Strategy','domain_knowledge','expert','[\"search strategy\", \"organic growth\", \"keyword strategy\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (65,'ecommerce','E-Commerce','domain_knowledge','proficient','[\"online retail\", \"digital commerce\", \"web stores\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (66,'saas-platforms','SaaS Platforms','domain_knowledge','expert','[\"software as a service\", \"platform development\", \"cloud platforms\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (67,'social-platforms','Social Platforms','domain_knowledge','proficient','[\"social media\", \"community platforms\", \"user-generated content\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (68,'gaming-entertainment','Gaming & Entertainment','domain_knowledge','proficient','[\"casual gaming\", \"puzzle games\", \"entertainment products\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (69,'local-business-marketing','Local Business Marketing','domain_knowledge','expert','[\"local SEO\", \"small business marketing\", \"regional marketing\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (70,'b2b-marketing','B2B Marketing','domain_knowledge','proficient','[\"business-to-business\", \"enterprise marketing\", \"wholesale marketing\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (71,'demand-generation','Demand Generation','domain_knowledge','proficient','[\"lead generation\", \"demand creation\", \"pull marketing\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (72,'compliance-navigation','Compliance Navigation','domain_knowledge','proficient','[\"regulatory compliance\", \"legal requirements\", \"industry regulations\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (73,'user-experience-design','User Experience Design','domain_knowledge','expert','[\"UX design\", \"experience design\", \"interaction design\"]',NULL,1,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (74,'user-psychology','User Psychology','domain_knowledge','expert','[\"behavioral psychology\", \"user behavior\", \"cognitive psychology\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (75,'design-systems','Design Systems','domain_knowledge','expert','[\"component libraries\", \"design patterns\", \"UI systems\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (76,'platform-engineering','Platform Engineering','domain_knowledge','expert','[\"developer platforms\", \"infrastructure platforms\", \"platform development\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (77,'marketing-automation','Marketing Automation','domain_knowledge','proficient','[\"automated marketing\", \"marketing workflows\", \"campaign automation\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (78,'conversion-optimization','Conversion Optimization','domain_knowledge','proficient','[\"CRO\", \"funnel optimization\", \"conversion rate optimization\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (79,'roi-optimization','ROI Optimization','domain_knowledge','proficient','[\"return on investment\", \"value creation\", \"business outcomes\"]',NULL,0,'2025-11-20 21:24:02','2025-11-29 19:45:18');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (80,'constraint-driven-innovation','Constraint-Driven Innovation','domain_knowledge','expert','[\"working with constraints\", \"creative constraints\", \"limitation as opportunity\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (81,'technical-debt-management','Technical Debt Management','domain_knowledge','proficient','[\"code quality\", \"maintainability\", \"refactoring\"]',NULL,0,'2025-11-20 21:24:02','2025-11-29 19:45:18');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (82,'live-operations','Live Operations','domain_knowledge','proficient','[\"production support\", \"operational monitoring\", \"real-time fixes\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (83,'legacy-system-management','Legacy System Management','domain_knowledge','proficient','[\"legacy systems\", \"old system maintenance\", \"technical debt navigation\"]',NULL,0,'2025-11-20 21:24:02','2025-11-20 21:24:02');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (84,'nodejs','Node.js','technical_skill','developing','[\"node\", \"express\", \"express.js\", \"server-side javascript\", \"backend javascript\"]','Currently developing skills through building the Who Is Mike Dion portfolio platform - a full-stack application with Express API, MySQL database, and Claude AI integration.',0,'2025-11-29 02:55:12','2025-11-29 19:57:40');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (85,'vuejs','Vue.js','technical_skill','developing','[\"vue\", \"vuejs\", \"vue 3\", \"composition api\", \"frontend framework\"]','Currently developing skills through building the Who Is Mike Dion portfolio platform - a Vue 3 frontend with component architecture and state management.',0,'2025-11-29 02:55:12','2025-11-29 19:57:40');
INSERT INTO `skills` (`id`, `skill_id`, `canonical_name`, `category`, `proficiency`, `synonyms`, `notes`, `is_top_skill`, `created_at`, `updated_at`) VALUES (86,'javascript','JavaScript','technical_skill','proficient','[\"JS\", \"vanilla javascript\", \"ES6\", \"jQuery\", \"DOM manipulation\", \"AJAX\"]','Extensive experience with vanilla JavaScript and jQuery. Built numerous interactive features using REST API calls and AJAX for dynamic DOM updates and server communication in WordPress environments.',0,'2025-11-29 18:27:01','2025-11-29 18:27:01');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (1,'STORY-001','Restaurant Content Strategy - LLM-Assisted Workflow','Local bakery just getting started needed a website to demonstrate their value. Had a modest $4k budget where traditional copywriting was not feasible. Goal was to capture their authentic voice and community mission without producing generic AI slop content.','Limited budget, client couldn\'t articulate vision in writing, needed content that captured authentic voice AND deeper mission, typical web content would miss emotional/community aspect.','Built systematic LLM-assisted workflow designed to avoid generic AI content: (1) Deep discovery interview with client, (2) Industry research and target demographic research to build rich context, (3) Created template for preferred website section types, (4) Worked through content page by page, section by section with LLM doing heavy lifting while maintaining quality control. All context (research + interview transcript) fed into each generation step.','Client had emotional reaction (tears/goosebumps) to content. Delivered $15k+ value on $4k budget. Process efficient enough to be profitable. Content authentically captured voice and mission.','$15k value on $4k budget (375% multiplier), feedback cycle reduced from weeks to hours','Product strategy, systems thinking, AI workflow design, user research, process innovation, stakeholder management, value creation','2025-11-23 17:33:28','2025-11-29 01:33:01');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (2,'STORY-002','Luxury Home Builder SEO Strategy','Vermont luxury home builder getting <20 monthly visitors and 1-2 leads per YEAR. Small $1,500/month budget had to cover content creation AND promotion.','Competitive keywords, long sales cycles, limited budget split between content and promotion, needed qualified leads not just traffic in small local market.','Strategic budget allocation (50% content, 50% Facebook ads). Wrote content myself for quality control. Targeted achievable keywords with purchase intent. Monthly owner interviews to capture his processes, get subject matter expertise on areas homebuyers are often confused about, and ensure factual accuracy. Vermont-specific case studies.','Traffic increased 900%+ (20 to 200-300 monthly). Achieved #1 Google ranking for \"how to build a new home in Vermont\". Lead generation increased 1200% (2-3 qualified leads/month vs 1-2/year). Results maintained 6+ months AFTER campaign ended.','900%+ traffic increase, 1200%+ lead increase, #1 ranking maintained, sustainable results 6+ months post-campaign','Strategic thinking, market research, content strategy, stakeholder management, ROI focus, long-term planning, sustainable value creation','2025-11-23 17:33:28','2025-11-29 21:11:31');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (3,'STORY-003','Emergency E-Commerce Launch Recovery','A client launched a first-to-market product that customers were eager to buy, but their bloated WooCommerce site (housing two businesses on cheap GoDaddy hosting) crashed under the traffic. They had to pull back the launch entirely and came to us in a panic.','Weekend timeline to build and launch a completely new standalone e-commerce site. The failed launch was tracking toward $5-8k in sales, so every hour offline meant lost momentum and revenue. Had to ensure the new site could handle the traffic that killed the original.','Led a weekend blitz with my business partner and designer. I coordinated the team, created all tickets with assets, made architectural decisions, and built the technical components while also developing pages alongside the team. We built a dedicated single-product site with only what was necessary—moved to dedicated hosting with Cloudflare and caching, dramatically simplified the user journey, and significantly improved ADA compliance. Ensured FDA-compliant content for the kratom industry.','$6,000 in first-day sales on relaunch—right in the middle of their target range. Site stayed up under the same traffic that crashed the original. Clean user journey and vastly improved accessibility. Client had a stable platform to grow from.','One weekend timeline, $6k day-one revenue, 100% uptime vs complete failure on original launch, significant ADA compliance improvement','Crisis management, technical architecture, team coordination, e-commerce development, performance optimization, accessibility, rapid delivery under pressure','2025-11-23 17:33:28','2025-11-29 18:09:10');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (4,'STORY-004','Poodle Debugging - Pattern Recognition','Business partner stuck for hours getting garbage data from WordPress AJAX filters. Variable name was reserved word, but partner tested with another reserved word and assumed that wasn\'t the issue.','Partner tried \"category\" → \"tag\" (both reserved), assumed not reserved word problem. Getting increasingly frustrated. Time pressure - client work blocked.','Immediately suspected reserved word. Asked clarifying question: \"What other word did you try?\" Suggested testing with nonsense word: \"Let\'s call it poodle\" - eliminated variable as factor entirely. Problem solved immediately.','Hours of stuck time → minutes to solution. Partner learned debugging methodology (test with extremes). Strengthened pattern recognition reputation. Work could proceed.','Hours to minutes resolution time, taught reusable debugging methodology','Debugging methodology, pattern recognition, emotional regulation, teaching, communication, trust building, calm under pressure','2025-11-23 17:33:28','2025-11-23 17:33:28');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (5,'STORY-005','Business Partner Support System','Co-worker with ADHD struggled to identify all requirements from paragraphs of text, often shipping incomplete work. Company was financially tight and could not afford rework.','Client emails would contain mixed requirements like: \"please update X, and do Y, and then Z, and also do not forget about A, and here is some irrelevant data, and some other context that is kind of important, and also we should do P\" - resulting in only X and P getting completed while the rest got lost in translation.','Created a standardized process for communicating tasks in our project management system. Every ticket required: (1) All assets attached to the card, (2) Clear overview with relevant context, (3) Checklist of deliverables answering \"what does done look like?\" Made this process mandatory for all work.','Co-worker completed tasks correctly first time much more frequently. Reduced incomplete work and client comebacks. Requirements no longer lost in translation between client emails and task execution.','Significant quality improvement (mandatory across all work), reduced client comeback rate','Pattern recognition, systems thinking, empathy, process design, requirements translation, automation mindset, individual adaptation, leadership','2025-11-23 17:33:28','2025-11-29 01:40:15');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (6,'STORY-006','AI-Powered Social Polling Platform','Client building a standalone social polling platform. Requirements shifted constantly over nearly a year, starting simple (2-option polls, no accounts) and evolving dramatically. Communication was through the client\'s son (early 20s) who had limited technical understanding.','Requirements changed continuously - features built, launched, then disabled days later. Working through intermediary with limited technical background. Mockups delivered as Canva JPGs. What started as an MVP led to 3-6 months of continuous feature requests and pivots.','Built 32 custom database tables on WordPress foundation. Created significant custom APIs and JavaScript/jQuery for user interactions. Recognized pattern of pivots early - architected ALL features with toggle capability so nothing would break when disabled. Built: vector DB recommendations, AI bot personalities, ML content moderation, custom commenting system, user profiles, feed algorithms.','Built sophisticated AI/ML platform on rapid timelines. Feature toggle system prevented cascade failures. Delivered features in 1-3 day sprints consistently. Maintained code quality despite year of pivots. Professional relationship maintained despite difficult circumstances.','~1 year development, 15+ major features, 32 custom tables, 3 external APIs, 1-3 day sprint velocity, zero cascade failures','AI/ML integration, system architecture, API design, database design, feature flag patterns, dependency management, technical debt management, stakeholder management, rapid delivery, professional maturity','2025-11-23 17:33:28','2025-11-29 01:45:15');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (7,'STORY-007','Centralized CMS Platform - Static Site Network','Client managing dozen+ gaming sites, manually updating the same games across all sites with clunky page builders. Every game update required updating all sites individually.','Updating one game meant updating dozen+ sites manually. No single source of truth. Inconsistent implementations across sites. Time-consuming maintenance eating into resources.','Built centralized WordPress site that serves as the API and data hub for all game content. Connected to Cloudways API so client can create new sites directly from WordPress admin - it provisions the server, clones a static site builder template, and builds out the site based on data from the central hub. When content needs updating, the static site builder rebuilds with new data. Combined with server caching and Cloudflare edge caching for maximum performance.','One-to-many updates: add or update game once, propagates to all sites on rebuild. Centralized management for entire portfolio. 99 GTmetrix scores baseline. Sites use minimal resources even under high traffic loads thanks to static architecture and edge caching. Scalable to unlimited sites.','Dozen+ sites managed centrally, hours to minutes for portfolio updates, 99 GTmetrix scores, 100% consistency','Multi-tenant SaaS design, API-first architecture, static site generation, scalability planning, single source of truth, headless CMS, performance optimization','2025-11-23 17:33:28','2025-11-29 01:48:54');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (8,'STORY-008','Depixelit - Daily Image Puzzle Game (0-1 Product)','Client found Paper.js division raster demo and envisioned daily puzzle game - \"Wordle for images\" where users depixelate images to guess content.','The Perception Problem: Image starts as 1 rectangle, full reveal = 2,073,600 pixels. Early splits create huge visual changes but tiny mathematical progress. True percentage would show 0.0001% when user sees massive progress. What looks \"pretty much complete\" would show as tiny percentage.','Designed perceptual curve for progress display: weighted early rectangle splits more heavily, compressed later splits. Progress increases faster early (big visual changes), slower later (imperceptible changes). Display matched what user SEES, not mathematical truth.','Successfully launched 0-1 product. Progress display aligned with human perception. Users feel consistent advancement. No frustrating \"stuck at 0.01%\" experience. Daily puzzle game with archive system and hint/guess mechanics.','2,073,600 potential rectangles per image, daily puzzles + archive + hints + progress tracking','Product development (0-1), user experience design, perception vs reality problem-solving, algorithm design, user psychology, product sense, mathematical modeling','2025-11-23 17:33:28','2025-11-23 17:33:28');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (9,'STORY-009','Atomic Design System - Component Library','Client needed professionally designed pages initially, but wanted ability to add/remove components independently post-launch without developer intervention.','Balance flexibility with performance. Make intuitive for non-technical users. Build for extensibility. Avoid page builder bloat while maintaining user-friendliness.','Implemented atomic design: atoms (buttons, inputs) → molecules (button groups, form fields) → organisms (navigation, hero sections) → sections (complete blocks). Programmatic ACF definitions. Each component defined once, reused everywhere. Master features admin with drag-and-drop section arrangement.','Client manages pages independently post-launch. All green Lighthouse scores initially. Clean, maintainable codebase. Easy to extend with new components. Performance degradation came from client choices (FontAwesome, large images), not architecture.','All green Lighthouse scores, server + edge caching, client self-sufficiency post-launch','Platform engineering, atomic design patterns, component architecture, performance optimization, user empowerment, DRY principles, frontend architecture','2025-11-23 17:33:28','2025-11-23 17:33:28');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (10,'STORY-010','Birthday Scavenger Hunts - Technology as Magic','Annual tradition starting ~2012 - building custom web-based scavenger hunts for wife\'s birthdays. Started because they were broke - instead of expensive gifts, she\'d follow clues around region.','Zero budget, one night to build (April 6-7 overnight), make technology feel magical not mechanical, mobile browser constraints, rural Vermont GPS coverage, express care through custom experiences.','Greatest Showman: Curtain animation that rises to start music (turned audio requirement into theatrical experience). AOL Instant Messenger: Full interface recreation of their pre-dating story. Triwizard Tournament: Location-aware spells, IoT integration (Alohomora unlocked actual doors via Amazon Dots), multi-user wand system, geofencing.','Created unique experiences \"nobody else in the world would ever have\". Technology felt like actual magic (door unlock \"REALLY felt like magic\"). Best reaction: Triwizard Tournament. Learned ruthless prioritization under extreme constraints.','Built in single overnight sessions (5-6am bedtime), most complex: Triwizard with geolocation + IoT + multi-user','User experience design, emotional design, geolocation technology, IoT integration, rapid development, crisis management, product philosophy, user psychology','2025-11-23 17:33:28','2025-11-23 17:33:28');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (11,'STORY-011','Vermont Hardwoods GTM Strategy','Spec work for Vermont Hardwoods trying to break into metro frame shop markets. Shops stick with existing suppliers unless customers demand new products.','Traditional B2B push not working - shops resistant to being sold to. Switching suppliers is work with no incentive unless customer demand exists.','Dual-channel strategy: (1) Send shops framed Google reviews of their business as gifts (made from product - sample + appreciation + marketing), (2) Run consumer ads in shop areas: \"Ask for Vermont Hardwoods\". Create demand pull - shops hear from both supplier AND customers simultaneously.','Proposal not accepted due to budget (~$10k + materials + ad spend too high). Learned to present multiple pricing tiers instead of single option.','Projected: 50-200 shops targeted, thousands of consumer ad reach per metro','Strategic thinking, go-to-market innovation, demand creation, multi-channel marketing, systems thinking, audience segmentation, creative problem-solving','2025-11-23 17:33:28','2025-11-23 17:33:28');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (12,'STORY-012','Hospital Systems Management','Contracted through Indelible as technical support in hospital maintenance department. Managed door access control and badge management across two merged organizations with shared systems.','Very old door/badge system with parts that never worked (holiday schedules). Two merged companies using employee numbers as sole identifier - collision risk. Badge issues affected timeclock, creating HR problems that appeared as maintenance tickets.','Built custom PHP/MySQL/JavaScript tool suite for maintenance operations. Database detective work: When employees couldn\'t clock in (\"employee terminated\" error), systematically diagnosed database collision - system found old terminated record in Company 1 DB before checking Company 3\'s active record. Direct SQL troubleshooting for ongoing access issues.','Resolved 100% of badge/timeclock issues. Built functioning custom tools. Identified critical technical debt (employee numbering collision) before systemic failure. Zero security incidents managing door access across merged organizations.','Zero security incidents, 100% issue resolution, identified architectural flaw before systemic failure','Database design, SQL proficiency, full-stack development, technical debugging, systems thinking, cross-functional coordination, legacy system management, risk identification, stakeholder management','2025-11-23 17:33:28','2025-11-23 17:33:28');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `created_at`, `updated_at`) VALUES (13,'STORY-013','Who is Mike Dion - AI-Powered Portfolio Platform','Needed a way to showcase professional experience in an engaging, interactive format. Traditional resumes and portfolios don\'t convey the depth of skills and stories that demonstrate real capability.','How to build a system that captures the complexity of professional experience - stories, skills, work history - and makes it accessible through natural conversation? Needed to connect narrative examples to specific competencies while making exploration intuitive.','Built full-stack platform with Node.js/Express API backend, Vue.js frontend, and MySQL database. Designed relational schema with stories, skills, and work history connected through junction tables. Integrated Claude API for conversational interface that can surface relevant stories based on skill queries. Custom context builder assembles relevant data for each chat interaction.','Working portfolio platform with 12+ stories linked to 80+ skills across 4 categories. Chat interface powered by Claude understands natural queries and surfaces relevant experience. Architecture demonstrates exactly the skills it describes - a meta-proof of capability.','32 database tables, 80+ skills catalogued, 12+ stories with quantifiable impacts, real-time AI chat, full API documentation','AI/ML integration, API design, database design, system architecture, frontend development, 0-to-1 product development, rapid prototyping','2025-11-29 02:46:43','2025-11-29 02:46:43');
INSERT INTO `stories` (`id`, `story_id`, `title`, `context`, `challenge`, `solution`, `outcome`, `quantifiable_impact`, `skills_demonstrated`, `keywords`, `created_at`, `updated_at`) VALUES (16,'STORY-016','Citadel — Custom Project Management Platform','Built a custom project management platform from scratch to replace Notion for running agency operations across 40+ client sites at Indelible. Existing PM tools didn\'t fit the specific logic of managing dozens of simultaneous client relationships with different retainer models and project types.','Off-the-shelf PM tools show everything — actionable tasks, blocked items, future work — which trains people to stop looking at their dashboard. When something critical surfaces, they miss it. Needed a system that embedded operational knowledge directly into workflows rather than separate documentation, and produced honest time estimates instead of false precision.','Designed dashboard around a core insight: only show actionable tasks, hiding blocked items until unblocked. Built recipe system (project templates with variable components) reducing setup from 30-60 min to ~2 min. Embedded SOPs directly into tasks with deep descriptions and checklists so training lives inside the workflow. Created estimation system using energy levels and uncertainty multipliers for time ranges instead of fixed estimates. Built API layer connecting to AI agent (Bast) via Slack for context-aware daily planning, automatic task management, and intelligent work scheduling based on energy patterns.','Production system managing 40+ active client sites daily. Project setup reduced from 30-60 minutes to 2 minutes via recipes. Eliminated lost proposals through automated pipeline surfacing. AI integration enables phone-based daily planning without opening the app. Collapsing 5-6 separate tools (Proposify, Google Drive, QuickBooks, email) into one coherent platform. Roadmap includes client-facing Observatory dashboard for self-service project visibility.','93% reduction in project setup time (30-60 min → 2 min), 40+ client sites managed in single platform, 5-6 tools consolidated into one, AI-powered daily planning via Slack integration','Product strategy, systems thinking, AI/ML integration, AI workflow design, system architecture, API design, database design, user psychology, user experience design, problem solving, process innovation, product operations, project management, feature prioritization, rapid prototyping, constraint-driven innovation','["citadel", "project management", "pm tool", "agency", "operations", "recipes", "templates", "ai agent", "bast", "dashboard", "estimation", "pipeline", "sop"]','2026-02-25 00:00:00','2026-02-25 00:00:00');
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `story_skills`
--

LOCK TABLES `story_skills` WRITE;
/*!40000 ALTER TABLE `story_skills` DISABLE KEYS */;
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (1,1);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (1,2);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (1,41);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (1,52);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (2,1);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (2,63);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (3,14);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (3,45);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (4,48);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (5,1);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (5,41);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,2);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,4);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,16);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,19);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,20);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,21);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,22);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,27);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,36);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (6,49);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (7,19);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (7,20);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (7,25);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (8,1);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (8,74);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (9,25);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (9,28);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (9,76);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (10,1);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (10,30);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (10,74);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (11,9);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (12,21);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (12,39);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (12,41);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,7);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,16);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,19);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,20);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,21);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,27);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,38);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,84);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (13,85);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,1);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,8);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,12);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,14);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,16);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,18);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,19);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,20);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,21);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,38);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,41);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,42);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,52);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,73);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,74);
INSERT INTO `story_skills` (`story_id`, `skill_id`) VALUES (16,80);
/*!40000 ALTER TABLE `story_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `weaknesses`
--

LOCK TABLES `weaknesses` WRITE;
/*!40000 ALTER TABLE `weaknesses` DISABLE KEYS */;
/*!40000 ALTER TABLE `weaknesses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `work_history`
--

LOCK TABLES `work_history` WRITE;
/*!40000 ALTER TABLE `work_history` DISABLE KEYS */;
INSERT INTO `work_history` (`id`, `title`, `company`, `start_date`, `end_date`, `key_accomplishments`, `display_order`, `created_at`, `updated_at`) VALUES (1,'Independent Consultant','Independent Consulting','2022-01-01',NULL,'[\"Product strategy consulting for mission-driven organizations\", \"AI integration and systems design for social services\", \"Technical product management for vulnerable population support systems\", \"WordPress and web application development consulting\"]',1,'2025-11-25 01:22:47','2025-11-25 01:22:47');
INSERT INTO `work_history` (`id`, `title`, `company`, `start_date`, `end_date`, `key_accomplishments`, `display_order`, `created_at`, `updated_at`) VALUES (2,'Founder & Lead Developer','Indelible','2013-01-01',NULL,'[\n    \"Grew agency from $0 to $300k annual revenue; 98% annual client retention with average client tenure exceeding 5 years\",\n    \"Led technical transformation from live server coding to version-controlled CI/CD pipelines (GitHub → Bitbucket), establishing branching strategies and deployment processes\",\n    \"Managed distributed team of 4-12 contractors across development, design, writing, Salesforce engineering, and analytics\",\n    \"Architected complex multi-tenant WordPress systems including missionary database with security for closed countries, plant nursery calculator platform, and centralized camps management system\",\n    \"Pioneered all service offerings (web development, SEO, digital marketing) and served 100+ clients including an international organization (22 sites, 8 years) and Disney film director Ashley Avis\",\n    \"Developed ADHD-friendly project management standards and custom Notion workflow with algorithmic time estimation factoring energy drain and uncertainty\",\n    \"Bridged technical and non-technical communication as lead developer and primary client liaison, translating business requirements into technical architecture\"\n  ]',2,'2025-11-25 01:22:47','2025-11-29 20:49:01');
INSERT INTO `work_history` (`id`, `title`, `company`, `start_date`, `end_date`, `key_accomplishments`, `display_order`, `created_at`, `updated_at`) VALUES (3,'Special Projects','Executive Cellular Phones','2011-01-01','2014-12-31','[\"Created internal tools to streamline business operations\", \"Authored comprehensive training manuals for staff onboarding\", \"Processed and analyzed sales data to inform business decisions\", \"Developed systems for tracking and reporting key metrics\"]',3,'2025-11-25 01:22:47','2025-11-25 01:22:47');
/*!40000 ALTER TABLE `work_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `work_story_links`
--

LOCK TABLES `work_story_links` WRITE;
/*!40000 ALTER TABLE `work_story_links` DISABLE KEYS */;
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (1,6);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (1,7);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (1,8);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (1,9);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (1,13);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (2,1);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (2,2);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (2,3);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (2,4);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (2,5);
INSERT INTO `work_story_links` (`work_id`, `story_id`) VALUES (2,16);
/*!40000 ALTER TABLE `work_story_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `system_prompts`
--

LOCK TABLES `system_prompts` WRITE;
/*!40000 ALTER TABLE `system_prompts` DISABLE KEYS */;
INSERT INTO `system_prompts` (`id`, `prompt_key`, `prompt_text`, `description`, `is_active`) VALUES (1, 'chat_assistant', 'You are an AI assistant representing Mike Dion''s professional portfolio. Your role is to help potential employers and collaborators learn about Mike''s experience, skills, and fit for roles they''re considering. The user might ask you about mike, but also might refer to YOU AS MIKE. If the user says \"you\" or \"your\" they mean Mike Dion. Respond accordingly - if they ask about \"you\" or \"your\" you are to respond as Mike Dion. Otherwise, respond as an AI assistant representing Mike Dion.

## Your Personality
- Warm but professional
- Honest and direct—help people assess mutual fit, even if that means acknowledging limitations
- Knowledgeable about Mike''s background from the context provided
- Thoughtful and systems-oriented in explanations

## Core Principles
1. **Context-Aware Honesty**: Only make claims supported by the context provided. If asked about something not in your context, say you don''t have specific information about that. Encourage the user to reach out to the real Mike for more details.

2. **Mutual Fit Focus**: Help employers determine if Mike is right for their needs. It''s better to help someone realize Mike isn''t a fit than to oversell. Do this with extreme caution and tact, we also don''t want to turn away good opportunities because the context for a fit isn''t there. Be sure to word things carefully to reflect YOUR CONTEXT and not make assumptions about the employer''s needs beyond what they share with you, or Mike''s abilities beyond what is available from data in this project.

3. **Bridge-Building**: Mike''s core value is connecting communities and supporting vulnerable populations through technology. This should come through in how you discuss his work.

4. **Technical + Human**: Mike combines technical skills with human-centered design. Emphasize both aspects.

## Response Guidelines
- Reference specific stories and accomplishments from the context when relevant
- Be concise but thorough—respect the interviewer''s time
- If asked about weaknesses or gaps, be honest (Mike has provided that information)
- Don''t invent details not in the context
- When uncertain, acknowledge it
- If Mike doesn''t have experience in specific areas, identify that you don''t have an indication of that skill or experience, but try to find something similar from the context to highlight transferable skills or related experiences. Also, please identify that Mike is a lifelong learner and is always learning new skills and technologies.
- If a user asks how to get in touch with Mike, suggest they email him at mike@whoismikedion.com
- If a user asks for your name, tell them you an AI assistant representing Mike Dion and your friends call you Mikey Bob.

## What You Know
You have access to:
- Mike''s skills and proficiency levels
- Success stories with specific outcomes
- Work history and timeline
- Core values and motivations
- Areas for growth/weaknesses

## What to avoid
- Making up information not in the context
- Overpromising on skills or experiences
- Being overly verbose or technical without need
- Commenting on the session itself (e.g. \"This is a new session!\" - session data is for back end tracking only.)
- **EXTREMELY IMPORTANT: If STORIES FOUND is empty or 0**, do not reference any stories or accomplishments. If you have no other relevant context, politely indicate that you don''t have enough information to answer the question and suggest they ask it a different way.

## Formatting
- Format responses using simple HTML tags for better readability
- Allowed tags: <p>, <strong>, <em>, <ul>, <ol>, <li>, <code>, <pre>, <br>
- Use <p> tags to wrap paragraphs
- Use <strong> for emphasis on key points
- Use <ul>/<ol> with <li> for lists
- Use <code> for inline code, <pre><code> for code blocks
- Do NOT use markdown syntax (no asterisks, no backticks, no hash symbols)
- Always close your tags properly

Remember: You''re helping both Mike AND the employer find the right fit. Honesty serves everyone.', 'Main chat assistant system prompt', TRUE);
/*!40000 ALTER TABLE `system_prompts` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-29 22:20:54
