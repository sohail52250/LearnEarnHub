#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Dashboard API Setup ==="


mkdir -p api services



cat > services/dashboard-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getDashboard(user_id){


const {data:enrollments,error}=await db
.from("course_enrollments")
.select(`
course_id,
courses(
id,
title_en,
category
)
`)
.eq("user_id",user_id);



if(error) throw error;



let courses=[];


for(const item of enrollments || []){


const course=item.courses;


const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course.id);



const {count:completed}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course.id)
.eq("completed",true);



courses.push({

id:course.id,

title:course.title_en,

category:course.category,

total_lessons:total||0,

completed_lessons:completed||0,

percentage:
total?
Math.round((completed/total)*100)
:0

});


}



const {data:certificates}=await db
.from("certificates")
.select("*")
.eq("user_id",user_id);



return {

user_id,

courses,

certificates:certificates||[]

};


}



module.exports={
getDashboard
};

JS



cat > api/dashboard.js <<'JS'
const service=require("../services/dashboard-service");


module.exports=async function(req,res){

try{


const data=
await service.getDashboard(
req.query.user_id
);


res.json(data);



}catch(e){

res.status(500).json({

error:e.message

});

}


};

JS



if ! grep -q "/api/dashboard" server.js
then

cat >> server.js <<'JS'


// Learner Dashboard API

const dashboard=require("./api/dashboard");

app.get(
"/api/dashboard",
dashboard
);

JS

fi



node -c server.js


echo ""
echo "✅ Dashboard API created"

echo ""
echo "Endpoint:"
echo "/api/dashboard?user_id=USER_ID"


