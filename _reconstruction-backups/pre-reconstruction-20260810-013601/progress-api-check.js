require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const {data,error}=await db
.from("learning_progress")
.select("*")
.limit(1);

console.log(
error ? error.message : "✅ learning_progress connected"
);

})();
