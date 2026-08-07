function calculateOpportunityScore(skills){
  return Math.min(skills.length * 20, 100);
}

window.calculateOpportunityScore = calculateOpportunityScore;
