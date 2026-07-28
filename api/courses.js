require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

module.exports = async (req,res)=>{

 const {data,error}=await supabase
 .from("courses")
 .select("id,title_en,title_ur,points,description_en,description_ur")
 .order("created_at",{ascending:false});

 if(error){
   return res.status(500).json({
     error:error.message
   });
 }

 res.setHeader("Content-Type","application/json");
 res.status(200).json(data);

};
