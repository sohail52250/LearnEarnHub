'use strict';

const db = require('../database');

function normalizeSkill(value) {
    return String(value || '').trim().toLowerCase();
}

function normalizeSkills(skills) {
    if (!Array.isArray(skills)) return [];

    return [...new Set(
        skills
            .map(normalizeSkill)
            .filter(Boolean)
    )];
}

function scoreSkills(learnerSkills, requiredSkills) {
    const learner = new Set(normalizeSkills(learnerSkills));
    const required = normalizeSkills(requiredSkills);

    if (!required.length) {
        return {
            score: 0,
            matchedSkills: []
        };
    }

    const matchedSkills = required.filter(
        skill => learner.has(skill)
    );

    return {
        score: Math.round(
            (matchedSkills.length / required.length) * 100
        ),
        matchedSkills
    };
}

async function getLearnerSkills(userId) {
    const { data, error } = await db
        .from('learner_skills')
        .select('skill')
        .eq('user_id', String(userId));

    if (error) throw error;

    return (data || []).map(row => row.skill);
}

async function matchOpportunity(userId, opportunity) {
    const learnerSkills = await getLearnerSkills(userId);

    const result = scoreSkills(
        learnerSkills,
        opportunity.required_skills
    );

    return {
        user_id: String(userId),
        opportunity_id: opportunity.id,
        match_score: result.score,
        matched_skills: result.matchedSkills
    };
}

async function getMatches(userId, options = {}) {
    const requestedLimit = Number(options.limit || 50);

    const limit = Math.min(
        Math.max(requestedLimit, 1),
        100
    );

    const learnerSkills = await getLearnerSkills(userId);

    const { data, error } = await db
        .from('business_tasks')
        .select(`
            id,
            reference_id,
            task_description,
            payment_amount,
            payment_currency,
            frequency,
            time_required_minutes,
            deadline,
            required_skills,
            created_at,
            businesses!inner(
                reference_id,
                business_name,
                visibility,
                verification_status,
                status
            )
        `)
        .eq('status', 'open')
        .eq('businesses.visibility', 'public')
        .eq('businesses.verification_status', 'approved')
        .eq('businesses.status', 'active')
        .order('created_at', { ascending: false })
        .limit(limit);

    if (error) throw error;

    return (data || [])
        .map(opportunity => {
            const result = scoreSkills(
                learnerSkills,
                opportunity.required_skills
            );

            return {
                ...opportunity,
                business_reference:
                    opportunity.businesses?.reference_id || null,
                business_name:
                    opportunity.businesses?.business_name || null,
                match_score: result.score,
                matched_skills: result.matchedSkills
            };
        })
        .filter(
            opportunity =>
                Array.isArray(opportunity.required_skills) &&
                opportunity.required_skills.length > 0 &&
                opportunity.match_score > 0
        )
        .sort(
            (a, b) =>
                b.match_score - a.match_score ||
                new Date(b.created_at) -
                new Date(a.created_at)
        );
}

module.exports = {
    normalizeSkills,
    scoreSkills,
    getLearnerSkills,
    matchOpportunity,
    getMatches
};
