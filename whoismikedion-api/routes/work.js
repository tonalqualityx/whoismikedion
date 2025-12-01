const express = require('express');
const router = express.Router();
const db = require('../db/connection');
const { formatEmploymentRange } = require('../utils/formatters');


//============================================
// GET /api/work - Retrieve all work experiences
//============================================

router.get('/', async (req, res) => {
    try {
        console.log('=== Work History Endpoint Called ===');

        const [workRows] = await db.query(`
            SELECT
                wh.id,
                wh.title,
                wh.company,
                wh.start_date,
                wh.end_date,
                wh.key_accomplishments,
                wh.display_order,
                TIMESTAMPDIFF(MONTH, wh.start_date, COALESCE(wh.end_date, CURDATE())) AS duration_months,
                COUNT(DISTINCT wsl.story_id) as story_count
            FROM work_history wh
            LEFT JOIN work_story_links wsl ON wh.id = wsl.work_id
            GROUP BY wh.id, wh.title, wh.company, wh.start_date, wh.end_date, wh.key_accomplishments, wh.display_order
            ORDER BY (wh.end_date IS NULL) DESC, wh.start_date DESC
        `);

        console.log(`Found ${workRows.length} work positions`);

        // ========================================
        // For each work position, fetch associated stories
        // ========================================
        const jobs = [];

        for (const work of workRows) {
            const [storyRows] = await db.query(`
                SELECT
                    s.story_id,
                    s.title
                FROM stories s
                INNER JOIN work_story_links wsl ON s.id = wsl.story_id
                WHERE wsl.work_id = ?
                ORDER BY s.created_at DESC
                `, [work.id]);

            let accomplishments = [];
            if (work.key_accomplishments) {
                try {
                    accomplishments = JSON.parse(work.key_accomplishments); // If stored as JSON array
                } catch (err) {
                    accomplishments = work.key_accomplishments.split('\n').filter(a => a.trim()); // If stored as newline-separated string
                }
            }

            const dates = formatEmploymentRange(work.start_date, work.end_date);

            jobs.push({
                id: work.id,
                title: work.title,
                company: work.company,
                start_date: work.start_date,
                end_date: work.end_date,
                dates: dates,
                duration_months: work.duration_months,
                is_current: work.end_date === null,
                key_accomplishments: accomplishments,
                story_count: work.story_count,
                stories: storyRows
            });
        }

        res.json({
            jobs: jobs,
            total: jobs.length
        });

    } catch (error) {
        console.error('Error fetching work history:', error);
        res.status(500).json({
            error: 'Failed to fetch work history',
            message: error.message
        });
    }

});

module.exports = router;