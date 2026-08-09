require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createCertificate(user_id,course_id){


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



if(total!==done){

return {
success:false,
message:"Course not completed"
};

}



const code=
"LEH-"+Date.now();



const {data,error}=await db
.from("certificates")
.upsert({

user_id,

course_id,

certificate_code:code,

issued_at:new Date()

},{
onConflict:"user_id,course_id"
})
.select()
.single();



if(error) throw error;



return {

success:true,

certificate:data

};


}



async function getCertificate(user_id){


const {data,error}=await db
.from("certificates")
.select(`
*,
courses(title_en)
`)
.eq("user_id",user_id);



if(error) throw error;


return data||[];

}



module.exports={
createCertificate,
getCertificate
};

