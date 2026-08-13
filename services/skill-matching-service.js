'use strict';

const db = require('../database');

function normalizeSkill(value) {
  return String(value || '').trim().toLowerCase();
}

function normalizeSkills(skills) {
  if (!Array.isArray(skills)) return [];
  return [...new Set(skills.map(normalizeSkill).filter(Boolean))];
}

function scoreSkills(learnerSkills, requiredSkills) {
  const learner = new Set(normalizeSkills(learnerSkills));
  const required = normalizeSkills(requiredSkills);
  if (!required.length) return { score: 0, matchedSkills: [] };
  const matchedSkills = required.filter(skill => learner.has(skill));
  return {
    score: Math.round((matchedSkills.length / required.length) * 100),
    matchedSkills
  };
}

async function getLearnerSkills(userId) {
  const result = await db.query(
    'SELECT skill_name FROM learner_skills WHERE user_id = $1',
    [userId]
  );
  return result.rows.map(row => row.skill_name);
}

async function matchOpportunity(userId, opportunity) {
  const learnerSkills = await getLearnerSkills(userId);
  const result = scoreSkills(learnerSkills, opportunity.required_skills);
  return {
    user_id: userId,
    opportunity_id: opportunity.id,
    match_score: result.score,
    matched_skills: result.matchedSkills
  };
}

module.exports = {
  normalizeSkills,
  scoreSkills,
  getLearnerSkills,
  matchOpportunity
};
