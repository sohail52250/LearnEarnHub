require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");
const fs=require("fs");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const sql=fs.readFileSync(
"database/create-learning-progress.sql",
"utf8"
);

const {error}=await db.rpc(
"exec_sql",
{sql}
);

console.log(error || "Learning progress table created");

})();
