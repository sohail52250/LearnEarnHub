require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createOpportunity(data){


const {result,error}=await db
.from("business_opportunities")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function listOpportunities(){


const {data,error}=await db
.from("business_opportunities")
.select("*")
.eq("status","open");


if(error) throw error;


return data || [];

}



async function hireLearner(opportunity_id,learner_id){


const {data,error}=await db
.from("job_hires")
.insert({

opportunity_id,

learner_id

})
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

createOpportunity,

listOpportunities,

hireLearner

};

