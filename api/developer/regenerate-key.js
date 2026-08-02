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



const old =
await db
.from("api_partner_keys")
.select("*")
.eq("id",id)
.single();



if(old.error){

throw old.error;

}



const newKey =
"LEH_"+crypto.randomBytes(16).toString("hex").toUpperCase();



await db
.from("api_partner_keys")
.update({

status:"revoked",

blocked:true,

updated_at:new Date()

})
.eq("id",id);



await db
.from("api_partner_keys")
.insert({

partner_id:old.data.partner_id,

api_key:newKey,

key_name:"Regenerated API Key",

status:"active",

request_limit:5000,

monthly_limit:100000,

blocked:false

});



await db
.from("api_key_actions")
.insert({

partner_id:old.data.partner_id,

api_key_id:id,

action:"REGENERATED",

old_key:old.data.api_key,

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
