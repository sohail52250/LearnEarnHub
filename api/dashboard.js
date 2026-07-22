const { createClient } = require("@supabase/supabase-js");

module.exports = async function(req,res){

try {

const supabase = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

const user_id = req.query.user_id;

if(!user_id){
 return res.status(400).json({
  success:false,
  error:"user_id required"
 });
}


const userResult = await supabase
.from("users")
.select("id,name,email,language,points,created_at,phone")
.eq("id", user_id)
.maybeSingle();


if(userResult.error){
 return res.json({
  success:false,
  step:"users",
  error:userResult.error
 });
}


const progressResult = await supabase
.from("user_progress")
.select("id,name,email,language,points,created_at,phone")
.eq("user_id", user_id);


if(progressResult.error){
 return res.json({
  success:false,
  step:"progress",
  error:progressResult.error
 });
}


return res.json({
 success:true,
 user:userResult.data,
 progress:progressResult.data
});


}catch(err){

return res.status(500).json({
 success:false,
 message:err.message
});

}

}
