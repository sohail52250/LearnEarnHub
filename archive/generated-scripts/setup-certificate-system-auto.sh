#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Certificate System Setup ==="

mkdir -p services routes

cat > services/certificate-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);


async function checkCourseCompletion(user_id,course_id){

 const {count:total}=await db
 .from("course_lessons")
 .select("*",{count:"exact",head:true})
 .eq("course_id",course_id);


 const {count:done}=await db
 .from("learning_progress")
 .select("*",{count:"exact",head:true})
 .eq("user_id",user_id)
 .eq("course_id",course_id)
 .eq("completed",true);


 if(total && total===done){

   const {data,error}=await db
   .from("course_completion")
   .upsert({
      user_id,
      course_id,
      completed_at:new Date()
   })
   .select();


   return {
     completed:true,
     certificate_ready:true,
     data,
     error
   };

 }


 return {
   completed:false,
   total_lessons:total||0,
   completed_lessons:done||0
 };

}


module.exports={checkCourseCompletion};
JS


cat > routes/certificates.js <<'JS'
const express=require("express");
const router=express.Router();

const {checkCourseCompletion}=require("../services/certificate-service");


router.get("/:user_id/:course_id",async(req,res)=>{

 const result=await checkCourseCompletion(
   req.params.user_id,
   req.params.course_id
 );

 res.json(result);

});


module.exports=router;
JS


echo "Checking server.js..."

if grep -q "routes/certificates" server.js
then
 echo "✅ Certificate route already exists"
else

cp server.js server.js.backup-certificates

sed -i '/express.static("public")/a\
const certificateRoutes = require("./routes/certificates");\
app.use("/api/certificates", certificateRoutes);' server.js

echo "✅ Certificate route added"

fi


echo ""
echo "=== Certificate System Ready ✅ ==="
echo "API: /api/certificates/:user_id/:course_id"

