const CAREER_MAP = {
  excel: [
    "Data Entry",
    "Virtual Assistant",
    "Office Assistant"
  ],
  typing: [
    "Data Entry",
    "Content Upload Assistant"
  ],
  internet: [
    "Virtual Assistant",
    "Customer Support"
  ],
  marketing: [
    "Social Media Assistant",
    "Digital Marketing Freelancer"
  ],
  freelancing: [
    "Freelancer",
    "Project Assistant"
  ]
};

function getRecommendations(skills){
  const scores = {};

  skills.forEach(skill=>{
    (CAREER_MAP[skill] || []).forEach(job=>{
      scores[job] = (scores[job] || 0) + 1;
    });
  });

  return Object.entries(scores)
    .sort((a,b)=>b[1]-a[1])
    .map(x=>x[0]);
}

window.getRecommendations = getRecommendations;
