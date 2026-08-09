require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function importJobs(jobs,source_id){


let saved=[];


for(const job of jobs){


const {data,error}=await db
.from("imported_jobs")
.upsert({

...job,

source_id

})
.select()
.single();



if(!error){

saved.push(data);

}


}



return saved;

}



module.exports={
importJobs
};

