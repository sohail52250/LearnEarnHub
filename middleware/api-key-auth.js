
const crypto=require("crypto");

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async function(req,res,next){


const key=req.headers["x-api-key"];



if(!key){

return res.status(401).json({

error:"API key required"

});

}



const {data,error}=await db

.from("api_partners")

.select("*")

.eq("api_key",key)

.eq("status","active")

.single();



if(error || !data){

return res.status(403).json({

error:"Invalid API key"

});

}



await db

.from("api_request_logs")

.insert({

partner_id:data.id,

endpoint:req.path,

method:req.method

});



req.partner=data;


next();


};

