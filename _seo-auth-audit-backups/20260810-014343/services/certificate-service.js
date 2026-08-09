require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function checkAndCreateCertificate(
user_id,
course_id
){

const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course_id);



const {count:completed}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true);



if(!total || completed !== total){

return {

completed:false,

message:"Course not completed"

};

}



const {data:certificate,error}=await db
.from("certificates")
.upsert({

user_id,

course_id,

issued_at:new Date(),

status:"completed"

},
{
onConflict:"user_id,course_id"
})
.select()
.single();



if(error) throw error;



return {

completed:true,

certificate

};


}



module.exports={
checkAndCreateCertificate
};

