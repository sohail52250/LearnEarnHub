#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Dashboard API Setup ==="

mkdir -p api


cat > api/dashboard.js <<'JS'
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async function(req,res){

const user_id=req.query.user_id || req.params.user_id;


if(!user_id){

return res.status(400).json({
error:"User ID required"
});

}


const {data:courses}=await db
.from("courses")
.select("id,title_en");


let result=[];


for(const c of courses){

const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",c.id);


const {count:completed}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",c.id)
.eq("completed",true);


const percentage=total
? Math.round((completed/total)*100)
:0;


if(completed>0){

result.push({

course_id:c.id,
title:c.title_en,
total_lessons:total,
completed_lessons:completed,
percentage

});

}


}


res.json({

user_id,
courses:result

});


};
JS



cat > api/certificate.js <<'JS'
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async function(req,res){

const {
user_id,
course_id
}=req.body;


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



if(total===done && total>0){

const {data}=await db
.from("certificates")
.insert([{
user_id,
course_id,
completed_at:new Date()
}])
.select();


return res.json({
success:true,
certificate:data
});

}


res.json({
success:false,
message:"Course not completed"
});


};
JS



echo "✅ Dashboard API created"
echo "✅ Certificate generator created"

