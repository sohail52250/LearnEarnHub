require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const {data:courses}=await db
.from("courses")
.select("id,title_en");

let weak=[];

for(const c of courses){

const {data:lessons}=await db
.from("course_lessons")
.select("title_en,content_en")
.eq("course_id",c.id);

if(!lessons || lessons.length===0) continue;

let generic=lessons.filter(l =>
(l.title_en||"").includes("Lesson") ||
(l.content_en||"").length < 100
);

if(generic.length>5){
weak.push({
id:c.id,
title:c.title_en,
weak_lessons:generic.length
});
}

}

console.log("Weak courses:",weak.length);
console.log(weak);

})();
