// routes/profile.js - Profile API endpoint
// Handles all routes under /api/profile

const express = require ('express');
const router = express.Router();

const db = require('../db/connection');

// ============================================
// GET /api/profile
// ============================================
// Returns profile info + top skills + values

router.get('/', async (req, res) => {
    try {
        // ========================================
        // QUERY 1: Get profile information
        // ========================================
        // Should be only 1 row in profile table

        const [profileRows] = await db.query('SELECT * FROM profile LIMIT 1');

        if(profileRows.length === 0) {
            return res.status(404).json({
                error: 'Profile not found',
                message: 'No profile data in database. Run database-schema.sql to create it.'
            });
        }

        // Get the profile row
        const profile = profileRows[0];

        // ========================================
        // QUERY 2: Get top skills
        // ========================================
        // Only skills marked as "top skills" (is_top_skill = TRUE)
        // Ordered by proficiency (expert first) then alphabetically

        const [skillRows] = await db.query(`
            SELECT
                skill_id,
                canonical_name,
                proficiency,
                category
            FROM skills
            WHERE is_top_skill = TRUE
            ORDER BY display_order ASC, canonical_name ASC
        `);

        // ========================================
        // QUERY 3: Get core values
        // ========================================
        // All values in display order

        const [valueRows] = await db.query(`
            SELECT
                id,
                value_text,
                description
            FROM core_values
            ORDER BY display_order ASC
        `);

        // ========================================
        // BUILD RESPONSE
        // ========================================
        // Structure the JSON response

        res.json({
            //Profile info
            name: profile.name,
            tagline: profile.tagline,
            photo_url: profile.photo_url,

            // Top skills
            top_skills: skillRows.map(skill => ({
                skill_id: skill.skill_id,
                name: skill.canonical_name,
                proficiency: skill.proficiency,
                category: skill.category
            })),

            // Core values
            core_values: valueRows.map(value => ({
                value_text: value.value_text,
                description: value.description
            }))
        });
    } catch (error) {

        console.error('Error fetching profile:', error);

        res.status(500).json({
            error: 'Failed to fetch profile, yo',
            message: error.message
        });
    }
});

module.exports = router;