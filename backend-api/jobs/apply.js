const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res)=>{

try{

if(req.method!=="POST"){
 return res.status(405).json({
  error:"Method not allowed"
 });
}

const {
 job_title,
 source,
 apply_url,
 user_id
}=req.body;


const {data,error}=await db
.from("job_applications")
.insert({
 job_title,
 source,
 apply_url,
 user_id,
 status:"saved"
})
.select()
.single();


if(error) throw error;


res.json({
 success:true,
 application:data
});


}catch(e){

res.status(500).json({
 error:e.message
});

}

};
