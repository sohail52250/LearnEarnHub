#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Enrollment System Setup ==="

mkdir -p api services public/js



cat > services/enrollment-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function enroll(user_id,course_id){

const {data,error}=await db
.from("course_enrollments")
.upsert({

user_id,
course_id

},{
onConflict:"user_id,course_id"
})
.select()
.single();


if(error) throw error;


return data;

}



async function myCourses(user_id){

const {data,error}=await db
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


return data || [];

}



module.exports={
enroll,
myCourses
};

JS



cat > api/enrollment.js <<'JS'
const service=require("../services/enrollment-service");


module.exports=async function(req,res){

try{


if(req.body.action==="enroll"){


return res.json(
await service.enroll(
req.body.user_id,
req.body.course_id
)
);


}



if(req.body.action==="list"){


return res.json(
await service.myCourses(
req.body.user_id
)
);


}


res.status(400).json({
error:"Invalid action"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "api/enrollment" server.js
then

cat >> server.js <<'JS'


// Course Enrollment API

const enrollment=require("./api/enrollment");

app.post(
"/api/enrollment",
enrollment
);

JS

fi



cat > public/js/enrollment.js <<'JS'

async function enrollCourse(course_id,user_id){


const res=await fetch(
"/api/enrollment",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"enroll",

course_id,

user_id

})

});


const data=await res.json();


alert(
data.course_id
?
"Course enrolled ✅"
:
"Enrollment failed"
);


location.reload();


}


window.enrollCourse=enrollCourse;

JS



node -c server.js


echo ""
echo "✅ Enrollment system created"
echo ""
echo "API:"
echo "POST /api/enrollment"
echo ""
echo "JS:"
echo "public/js/enrollment.js"


