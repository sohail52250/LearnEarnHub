require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function approveAndRelease(
submission_id,
amount,
currency="USD"
){



// approve submission

const {data:job,error}=await db
.from("job_submissions")
.update({

status:"approved",

approved_at:new Date()

})
.eq("id",submission_id)
.select()
.single();



if(error) throw error;



// create earning record

const {data:earning,error:earnError}=await db
.from("learner_earnings")
.insert({

learner_id:job.learner_id,

opportunity_id:job.opportunity_id,

amount,

currency,

status:"released",

paid_at:new Date()

})
.select()
.single();



if(earnError) throw earnError;



return {

success:true,

message:"Job approved and earning released",

earning

};


}



module.exports={
approveAndRelease
};

