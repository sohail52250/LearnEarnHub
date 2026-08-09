require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getAvailableJobs(user_id){


const {data:skills}=await db
.from("learner_skills")
.select("skill_name")
.eq("user_id",user_id)
.eq("verified",true);



if(!skills || !skills.length)
return [];



const names=
skills.map(s=>s.skill_name);



const {data,error}=await db
.from("marketplace_opportunities")
.select("*")
.in("required_skill",names);



if(error) throw error;


return data || [];

}



async function applyJob(user_id,opportunity_id){


const {data,error}=await db
.from("learner_applications")
.insert({

user_id,

opportunity_id

})
.select()
.single();



if(error) throw error;


return data;

}



module.exports={
getAvailableJobs,
applyJob
};

