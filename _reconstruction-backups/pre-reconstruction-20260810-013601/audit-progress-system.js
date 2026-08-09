require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

console.log("Checking learning_progress...");

const {data:progress,error:pError}=await db
.from("learning_progress")
.select("*")
.limit(5);

console.log(
pError ? "❌ learning_progress: "+pError.message :
"✅ learning_progress working. Sample:"
);

console.log(progress);


console.log("\nChecking lesson relation...");

const {data:lesson,error:lError}=await db
.from("course_lessons")
.select("id,course_id,title_en")
.limit(1);

console.log(
lError ? "❌ lessons: "+lError.message :
"✅ lessons linked"
);

console.log(lesson);


console.log("\nChecking certificates...");

const {error:cError}=await db
.from("certificates")
.select("*")
.limit(1);

console.log(
cError ? "❌ certificates: "+cError.message :
"✅ certificates table working"
);

})();
