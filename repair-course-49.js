require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const courseId=49;
const title="Data Analysis With Excel";

const lessons=[];

for(let i=1;i<=30;i++){

lessons.push({
course_id: courseId,
lesson_number:i,
title:`Lesson ${i}: ${title}`,
content:`Learn practical ${title} skills. This lesson covers concepts, examples and exercises.`
});

}

const {error}=await db
.from("course_lessons")
.insert(lessons);

console.log(error || "Added 30 lessons to course 49");

})();
