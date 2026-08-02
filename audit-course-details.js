require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const {data:courses}=await db
.from("courses")
.select("id,title_en,category");

let report=[];

for(const c of courses){

 const {count:lessons}=await db
 .from("course_lessons")
 .select("*",{count:"exact",head:true})
 .eq("course_id",c.id);

 report.push({
  id:c.id,
  title:c.title_en,
  category:c.category,
  lessons:lessons
 });

}

console.table(report);

})();
