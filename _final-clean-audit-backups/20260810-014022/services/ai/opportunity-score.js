function scoreMatch(userSkills, opportunitySkills){

if(!userSkills || !opportunitySkills) return 0;

const user=userSkills.toLowerCase().split(",");

const opp=opportunitySkills.toLowerCase().split(",");

let score=0;

for(const s of user){
 if(opp.includes(s.trim())) score+=20;
}

if(score>100) score=100;

return score;
}

module.exports={scoreMatch};
