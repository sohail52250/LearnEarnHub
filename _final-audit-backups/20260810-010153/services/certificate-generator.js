require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


async function generateCertificate(user_id,course_id){

const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course_id);


const {count:done}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true);



if(total && total===done){


const {data:existing}=await db
.from("certificates")
.select("*")
.eq("user_id",user_id)
.eq("course_id",course_id)
.limit(1);



if(existing && existing.length){

return existing[0];

}



const {data,error}=await db
.from("certificates")
.insert([{

user_id,
course_id,
certificate_code:
"LEH-"+Date.now(),
issued_at:new Date()

}])
.select();


return error || data[0];


}


return null;


}


module.exports={generateCertificate};

