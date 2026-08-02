const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async function(req,res){

try{

const keys=await db
.from("api_key_dashboard")
.select("*");


const events=await db
.from("api_dashboard_logs")
.select("*",{count:"exact"});


res.json({

success:true,

api_keys:keys.data || [],

total_events:events.count || 0

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
