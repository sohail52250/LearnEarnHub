require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_SERVICE_KEY ?
process.env.SUPABASE_URL : "",
process.env.SUPABASE_SERVICE_KEY
);



async function submitJob(data){


const {data:result,error}=await db
.from("job_submissions")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function approveJob(id){


const {data:submission,error}=await db
.from("job_submissions")
.update({

status:"approved",

approved_at:new Date()

})
.eq("id",id)
.select()
.single();



if(error) throw error;



return submission;

}



async function rejectJob(id){


const {data,error}=await db
.from("job_submissions")
.update({

status:"rejected"

})
.eq("id",id)
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

submitJob,

approveJob,

rejectJob

};

