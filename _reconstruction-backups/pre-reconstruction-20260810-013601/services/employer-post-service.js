require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createJob(data){


const {data:job,error}=await db
.from("employer_jobs")
.insert({

...data,

status:"pending"

})
.select()
.single();



if(error) throw error;


return job;

}



async function listJobs(){


const {data,error}=await db
.from("employer_jobs")
.select("*")
.eq(
"status",
"approved"
)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={

createJob,

listJobs

};

