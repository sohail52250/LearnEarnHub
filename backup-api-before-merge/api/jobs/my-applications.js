const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res)=>{

try{

const user_id=req.query.user_id;

if(!user_id){
 return res.status(400).json({
  error:"Missing user id"
 });
}


const {data,error}=await db
.from("job_applications")
.select("*")
.eq("user_id",user_id)
.order("created_at",{ascending:false});


if(error) throw error;


res.json({
 success:true,
 applications:data||[]
});


}catch(e){

res.status(500).json({
 error:e.message
});

}

};
