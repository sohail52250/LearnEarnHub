require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async function(req,res){

try{

const user_id=req.query.user_id;


if(!user_id){

return res.status(400).json({
error:"user_id required"
});

}



const {data:progress}=await db
.from("learning_progress")
.select("*")
.eq("user_id",user_id);



const {data:certificates}=await db
.from("certificates")
.select("*")
.eq("user_id",user_id);



res.json({

progress:progress || [],

certificates:certificates || []

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

