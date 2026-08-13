'use strict';

const express = require('express');
const router = express.Router();

const matchingService = require('../services/skill-matching-service');

function parseLimit(value) {
    if (value === undefined || value === null || value === '') {
        return 50;
    }

    const parsed = Number(value);

    if (!Number.isInteger(parsed) || parsed < 1) {
        return null;
    }

    return Math.min(parsed, 100);
}

router.get('/matches', async (req, res) => {
    try {
        const userId = String(
            req.query?.user_id ||
            req.query?.userId ||
            ''
        ).trim();

        if (!userId) {
            return res.status(400).json({
                success: false,
                error: 'user_id is required.'
            });
        }

        const limit = parseLimit(req.query?.limit);

        if (limit === null) {
            return res.status(400).json({
                success: false,
                error: 'limit must be an integer between 1 and 100.'
            });
        }

        const matches = await matchingService.getMatches(
            userId,
            { limit }
        );

        return res.status(200).json({
            success: true,
            user_id: userId,
            count: matches.length,
            matches
        });
    } catch (error) {
        console.error('OPPORTUNITY MATCHING API ERROR:', error);

        return res.status(500).json({
            success: false,
            error: error?.message ||
                'Unable to retrieve opportunity matches.'
        });
    }
});

module.exports = router;