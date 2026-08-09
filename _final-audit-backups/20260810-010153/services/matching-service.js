require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function calculateScore(userSkills,jobSkill){


if(!jobSkill)
return 0;


let score=0;


userSkills.forEach(skill=>{


if(
skill.toLowerCase()
.includes(
jobSkill.toLowerCase()
)
||
jobSkill.toLowerCase()
.includes(
skill.toLowerCase()
)
)

{

score=100;

}


});


return score;

}



async function matchUser(user_id){


const {data:skills}=await db
.from("learner_skills")
.select("skill_name")
.eq("user_id",user_id)
.eq("verified",true);



const {data:jobs}=await db
.from("external_opportunities")
.select("*");



let results=[];



for(const job of jobs || []){


let score=
calculateScore(
skills.map(s=>s.skill_name),
job.required_skill
);



if(score>0){


const {data}=await db
.from("skill_matches")
.upsert({

user_id,

opportunity_id:job.id,

matched_skill:job.required_skill,

match_score:score

})
.select();



results.push(data);

}


}



return results;

}



async function getMatches(user_id){


const {data,error}=await db
.from("skill_matches")
.select(`
*,
external_opportunities(*)
`)
.eq("user_id",user_id)
.order(
"match_score",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={

matchUser,

getMatches

};

