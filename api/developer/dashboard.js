const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async(req,res)=>{

try{


const keys =
await db
.from("api_partner_keys")
.select(
"partner_id,status,request_limit,last_used_at"
);



const logs =
await db
.from("api_dashboard_logs")
.select("*",{count:"exact"});



res.json({

success:true,

keys:
keys.data || [],

events:
logs.count || 0

});


}

catch(e){

res.status(500)
.json({

error:e.message

});

}

};
