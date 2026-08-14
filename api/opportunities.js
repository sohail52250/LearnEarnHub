'use strict';

const express = require('express');
const router = express.Router();

const matchingService = require('../services/skill-matching-service');
const businessService = require('../services/business-service');

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

/*
 * Canonical learner opportunity matching.
 *
 * GET /api/opportunities/matches?user_id=<uuid>&limit=50
 */
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
        console.error(
            'OPPORTUNITY MATCHING API ERROR:',
            error
        );

        return res.status(500).json({
            success: false,
            error:
                error?.message ||
                'Unable to retrieve opportunity matches.'
        });
    }
});

/*
 * Canonical opportunity detail.
 *
 * GET /api/opportunities/:reference
 *
 * Only:
 *   open task
 *   public business
 *   approved business
 *   active business
 *
 * are exposed.
 */
router.get('/:reference', async (req, res) => {
    try {
        const reference = String(
            req.params?.reference || ''
        ).trim();

        if (!reference) {
            return res.status(400).json({
                success: false,
                error: 'Opportunity reference is required.'
            });
        }

        const opportunity =
            await businessService.getOpportunity(reference);

        if (!opportunity) {
            return res.status(404).json({
                success: false,
                error: 'Opportunity not found.'
            });
        }

        return res.status(200).json({
            success: true,
            opportunity
        });
    } catch (error) {
        console.error(
            'OPPORTUNITY DETAIL API ERROR:',
            error
        );

        return res.status(500).json({
            success: false,
            error:
                error?.message ||
                'Unable to retrieve opportunity.'
        });
    }
});

module.exports = router;