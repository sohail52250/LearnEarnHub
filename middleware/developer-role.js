const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res,next)=>{

try{

const token=req.headers.authorization?.replace("Bearer ","");

if(!token){
 return res.status(401).json({
  error:"Missing session"
 });
}


const {data:userData,error:userError}=await db.auth.getUser(token);

if(userError || !userData.user){
 return res.status(401).json({
  error:"Invalid session"
 });
}


const {data:role,error:roleError}=await db
.from("user_roles")
.select("*")
.eq("user_id",userData.user.id)
.eq("role","developer")
.maybeSingle();


if(roleError) throw roleError;


if(!role){

 return res.status(403).json({
  error:"Developer role required"
 });

}


req.user=userData.user;

next();


}catch(e){

res.status(500).json({
 error:e.message
});

}

};
