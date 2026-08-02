require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getDashboard(user_id){


const {data:enrollments,error}=await db
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



let courses=[];


for(const item of enrollments || []){


const course=item.courses;


const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course.id);



const {count:completed}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course.id)
.eq("completed",true);



courses.push({

id:course.id,

title:course.title_en,

category:course.category,

total_lessons:total||0,

completed_lessons:completed||0,

percentage:
total?
Math.round((completed/total)*100)
:0

});


}



const {data:certificates}=await db
.from("certificates")
.select("*")
.eq("user_id",user_id);



return {

user_id,

courses,

certificates:certificates||[]

};


}



module.exports={
getDashboard
};

