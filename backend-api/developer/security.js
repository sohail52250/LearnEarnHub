const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async(req,res)=>{

try{

const result =
await db
.from("api_security_analytics")
.select("*");


res.json({

success:true,

security: result.data || []

});


}

catch(e){

res.status(500).json({

error:e.message

});

}

};
