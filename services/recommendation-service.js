require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function calculateScore(skill,jobSkill,location,jobLocation){


let score=0;



if(skill && jobSkill){

if(
skill.toLowerCase()
.includes(
jobSkill.toLowerCase()
)
){

score+=60;

}

}



if(location && jobLocation){

if(location===jobLocation){

score+=20;

}

}



score+=20;


return score;

}



async function generate(user_id){



const {data:profile}=await db
.from("learner_profiles")
.select("*")
.eq("user_id",user_id)
.single();



const {data:skills}=await db
.from("learner_skills")
.select("skill_name")
.eq("user_id",user_id);



const {data:jobs}=await db
.from("external_opportunities")
.select("*");



let output=[];



for(const job of jobs || []){


let best=0;



for(const s of skills || []){


let score=
calculateScore(

s.skill_name,

job.required_skill,

profile?.location,

job.country

);



if(score>best)
best=score;


}



if(best>0){


const {data}=await db
.from("opportunity_recommendations")
.upsert({

user_id,

opportunity_id:job.id,

skill_score:best,

final_score:best

})
.select();



output.push(data);


}

}



return output;

}



async function get(user_id){


const {data,error}=await db
.from("opportunity_recommendations")
.select(`
*,
external_opportunities(*)
`)
.eq("user_id",user_id)
.order(
"final_score",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={generate,get};

