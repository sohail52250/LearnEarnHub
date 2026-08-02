require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

console.log("=== NEXT SYSTEM AUDIT ===\n");

// Check users structure
const {data:users}=await db
.from("users")
.select("*")
.limit(1);

console.log("Users sample:");
console.log(users);


// Check course columns
const {data:courses}=await db
.from("courses")
.select("*")
.limit(1);

console.log("\nCourse columns:");
console.log(Object.keys(courses[0]||{}));


// Check lesson columns
const {data:lessons}=await db
.from("course_lessons")
.select("*")
.limit(1);

console.log("\nLesson columns:");
console.log(Object.keys(lessons[0]||{}));


// Check certificates columns
const {data:cert}=await db
.from("certificates")
.select("*")
.limit(1);

console.log("\nCertificate columns:");
console.log(Object.keys(cert[0]||{}));


console.log("\nAUDIT COMPLETE ✅");

})();
