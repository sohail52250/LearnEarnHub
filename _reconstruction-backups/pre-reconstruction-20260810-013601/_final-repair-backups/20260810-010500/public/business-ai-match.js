async function calculateAIMatch(userId, requiredSkills=[]){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

let score=0;

const {data:skills}=await client
.from("learner_skills")
.select("*")
.eq("user_id",userId);

const {data:certs}=await client
.from("certificates")
.select("*")
.eq("user_id",userId);

const {data:badges}=await client
.from("learner_badges")
.select("*")
.eq("user_id",userId);

const {data:achievements}=await client
.from("achievements")
.select("*")
.eq("user_id",userId);

const learnerSkills=(skills||[])
.map(s=>(s.skill_name||s.skill||"").toLowerCase());

let matched=0;

for(const skill of requiredSkills){
if(
learnerSkills.includes(
skill.toLowerCase()
)
){
matched++;
}
}

if(requiredSkills.length){
score += Math.round(
(matched/requiredSkills.length)*50
);
}

score += Math.min(
(certs?.length||0)*5,
20
);

score += Math.min(
(badges?.length||0)*3,
15
);

score += Math.min(
(achievements?.length||0)*3,
15
);

return {
score:Math.min(score,100),
certificates:certs?.length||0,
badges:badges?.length||0,
achievements:achievements?.length||0,
matchedSkills:matched
};

}

window.calculateAIMatch=
calculateAIMatch;
