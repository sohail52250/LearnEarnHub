const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async(req,res)=>{

try{


const keys = await db
.from("api_partner_keys")
.select(
"id,partner_id,status,request_limit,last_used_at"
);



const events = await db
.from("api_dashboard_logs")
.select(
"id,action,created_at",
{
count:"exact"
}
);



res.json({

success:true,

api_keys:
keys.data || [],

total_events:
events.count || 0

});


}

catch(error){

res.status(500).json({

error:error.message

});

}


};
