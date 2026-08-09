require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function enroll(user_id,course_id){

const {data,error}=await db
.from("course_enrollments")
.upsert({

user_id,
course_id

},{
onConflict:"user_id,course_id"
})
.select()
.single();


if(error) throw error;


return data;

}



async function myCourses(user_id){

const {data,error}=await db
.from("course_enrollments")
.select(`
course_id,
courses(
id,
title_en,
category
)
`)
.eq("user_id",user_id);



if(error) throw error;


return data || [];

}



module.exports={
enroll,
myCourses
};

