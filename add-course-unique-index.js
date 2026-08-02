require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const sql=`
CREATE UNIQUE INDEX IF NOT EXISTS courses_title_unique
ON courses (LOWER(TRIM(title_en)));
`;

const {error}=await db.rpc("exec_sql",{sql});

console.log(error || "Unique index created");

})();
