const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const crypto=require("crypto");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async(req,res)=>{

try{

const id=req.body.id;

if(!id){

return res.status(400).json({
error:"Missing key id"
});

}



const {data:old,error:findError}=await db
.from("developer_keys")
.select("*")
.eq("id",id)
.limit(1)
.maybeSingle();



if(findError){

throw findError;

}


if(!old){

return res.status(404).json({
error:"API key not found"
});

}



const newKey =
"LEH_"+crypto.randomBytes(16)
.toString("hex")
.toUpperCase();



await db
.from("developer_keys")
.update({

status:"revoked",

blocked:true,

updated_at:new Date()

})
.eq("id",id);



const {data:newKeyRow,error:newError}=await db
.from("developer_keys")
.insert({

partner_id:old.partner_id,

api_key:newKey,

name:old.name || "Regenerated Developer Key",
key_name:"Regenerated API Key",

status:"active",

request_limit:5000,

monthly_limit:100000,

blocked:false

})
.select()
.limit(1)
.maybeSingle();



if(newError){

throw newError;

}



await db
.from("api_key_actions")
.insert({

partner_id:old.partner_id,

api_key_id:newKeyRow.id,

action:"REGENERATED",

old_key:old.api_key,

new_key:newKey

});



res.json({

success:true,

new_api_key:newKey

});


}

catch(e){

res.status(500).json({

error:e.message

});

}

};
