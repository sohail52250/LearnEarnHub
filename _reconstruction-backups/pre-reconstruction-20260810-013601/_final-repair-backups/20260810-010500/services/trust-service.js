require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function generateReference(){

return "LEH-REF-" + Date.now();

}



function calculateTrust(data){


let points=0;


points += data.completed_jobs * 10;

points += data.verified_skills * 20;


if(data.rating_score>=80)
points += 30;


if(points>=150)
return "TRUSTED";


if(points>=80)
return "VERIFIED";


return "NEW";

}



async function createVerification(data){


const {data:result,error}=await db
.from("verification_records")
.insert({

user_id:data.user_id,

reference_code:generateReference(),

verification_type:data.type,

classification:data.classification || "VERIFIED"

})
.select()
.single();



if(error) throw error;


return result;

}



async function updateReputation(user_id,data){


const level=
calculateTrust(data);



const {data:result,error}=await db
.from("reputation_scores")
.upsert({

user_id,

...data,

trust_level:level,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return result;

}



module.exports={

createVerification,

updateReputation

};

