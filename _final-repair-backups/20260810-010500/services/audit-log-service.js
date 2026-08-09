require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function logAction(data){


const {error}=await db
.from("audit_logs")
.insert(data);



if(error) throw error;


return true;


}



module.exports={
logAction
};

