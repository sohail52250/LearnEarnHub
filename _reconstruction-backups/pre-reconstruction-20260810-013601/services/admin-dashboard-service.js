require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function stats(){


const tables=[

"profiles",

"courses",

"certificates",

"business_opportunities",

"job_submissions",

"notifications"

];


let result={};



for(const table of tables){


const {count,error}=await db
.from(table)
.select("*",{count:"exact",head:true});


result[table]=error ? 0 : count || 0;


}



return result;


}



module.exports={
stats
};

