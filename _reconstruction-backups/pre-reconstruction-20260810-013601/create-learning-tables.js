require("dotenv").config();
const axios=require("axios");
const fs=require("fs");

(async()=>{

const sql=fs.readFileSync(
"supabase/migrations/create_learning_system.sql",
"utf8"
);

console.log("SQL loaded...");

const url=`https://api.supabase.com/v1/projects/srarnaqyoiqotdntzsyc/database/query`;

try{

const res=await axios.post(
url,
{query:sql},
{
headers:{
Authorization:`Bearer ${process.env.SUPABASE_SERVICE_KEY}`,
apikey:process.env.SUPABASE_SERVICE_KEY
}
}
);

console.log("✅ SQL executed");
console.log(res.data);

}catch(e){

console.log("❌ Failed");
console.log(
e.response?.data || e.message
);

}

})();
