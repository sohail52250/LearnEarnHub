const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async function(req,res,next){


try{


const key=req.headers["x-api-key"];


if(!key){

return res.status(401).json({

error:"Missing API Key"

});

}



const result=await db

.from("api_partner_keys")

.select("*")

.eq("api_key",key)

.single();



if(result.error || !result.data){

return res.status(401).json({

error:"Invalid API Key"

});

}



const api=result.data;



if(api.blocked || api.status!=="active"){

return res.status(403).json({

error:"API Key Disabled"

});

}



await db

.from("api_partner_keys")

.update({

last_used_at:new Date()

})

.eq("id",api.id);



next();



}catch(e){

res.status(500).json({

error:e.message

});

}


};
