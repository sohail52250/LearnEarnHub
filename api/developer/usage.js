
const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async(req,res)=>{


try{


const data=await db

.from("api_usage_dashboard")

.select("*");



res.json({

success:true,

usage:data.data || []

});


}

catch(e){

res.status(500).json({

error:e.message

});

}


};

