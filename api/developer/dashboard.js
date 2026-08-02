
const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(

process.env.SUPABASE_URL,

process.env.SUPABASE_SERVICE_KEY

);



module.exports=async(req,res)=>{


try{


let keys=await db

.from("api_partner_keys")

.select(
"id,partner_id,status,request_limit,last_used_at"
);



let docs=await db

.from("api_documentation_views")

.select("*",{count:"exact"});


res.json({

api_keys:
keys.data || [],

documentation_views:
docs.count || 0

});


}catch(e){

res.status(500)
.json({

error:e.message

});

}


};

