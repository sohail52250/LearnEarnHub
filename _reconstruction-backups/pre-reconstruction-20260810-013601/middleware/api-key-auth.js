const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports = async function(req,res,next){

try{

const key =
req.headers["x-api-key"] ||
req.query.api_key;


if(!key){

return res.status(401).json({
error:"API key required"
});

}


const {data,error}=await db
.from("api_partner_keys")
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
.from("api_partner_keys")
.update({
last_used_at:new Date()
})
.eq("id",data.id);



req.apiPartner=data;

next();


}catch(e){

res.status(500).json({
error:e.message
});

}

};
