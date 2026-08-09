require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function searchCandidates(skill){


let query=
db
.from("learner_profiles")
.select(`
*,
learner_skills(*)
`);



if(skill){

query=query.ilike(
"learner_skills.skill_name",
"%"+skill+"%"
);

}



const {data,error}=await query;



if(error) throw error;


return data || [];

}



async function viewCandidate(data){


const {data:result,error}=await db
.from("candidate_views")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



module.exports={

searchCandidates,

viewCandidate

};

