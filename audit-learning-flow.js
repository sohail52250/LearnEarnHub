require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

console.log("=== LEARNEARNHUB SYSTEM AUDIT ===\n");

const checks=[
 "users",
 "courses",
 "course_lessons",
 "certificates"
];

for(const t of checks){
 const {count,error}=await db
 .from(t)
 .select("*",{count:"exact",head:true});

 console.log(
 t,
 error ? "❌ "+error.message : "✅ "+count+" records"
 );
}


console.log("\n=== COURSE SAMPLE ===");

const {data:courses}=await db
.from("courses")
.select("id,title_en")
.limit(5);

console.table(courses);


console.log("\n=== LESSON SAMPLE ===");

const {data:lessons}=await db
.from("course_lessons")
.select("course_id,lesson_order,title_en")
.limit(5);

console.table(lessons);


console.log("\n=== CATEGORY SUMMARY ===");

const {data:cats}=await db
.from("courses")
.select("category");

let map={};

cats.forEach(c=>{
 map[c.category]=(map[c.category]||0)+1;
});

console.table(map);

console.log("\nAUDIT COMPLETE ✅");

})();
