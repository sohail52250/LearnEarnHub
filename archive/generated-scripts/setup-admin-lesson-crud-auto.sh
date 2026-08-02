#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Admin Lesson Manager Setup ==="

mkdir -p services api public/admin



cat > services/admin-lesson-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createLesson(lesson){

const {data,error}=await db
.from("course_lessons")
.insert(lesson)
.select()
.single();

if(error) throw error;

return data;

}



async function updateLesson(id,lesson){

const {data,error}=await db
.from("course_lessons")
.update(lesson)
.eq("id",id)
.select()
.single();

if(error) throw error;

return data;

}



async function deleteLesson(id){

const {error}=await db
.from("course_lessons")
.delete()
.eq("id",id);


if(error) throw error;


return {
success:true
};

}



async function listLessons(course_id){

const {data,error}=await db
.from("course_lessons")
.select("*")
.eq("course_id",course_id)
.order("lesson_order");


if(error) throw error;


return data;

}



module.exports={
createLesson,
updateLesson,
deleteLesson,
listLessons
};

JS



cat > api/admin-lesson.js <<'JS'
const service=require("../services/admin-lesson-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createLesson(
req.body.lesson
)
);

}



if(req.body.action==="update"){

return res.json(
await service.updateLesson(
req.body.id,
req.body.lesson
)
);

}



if(req.body.action==="delete"){

return res.json(
await service.deleteLesson(
req.body.id
)
);

}



if(req.query.course_id){

return res.json(
await service.listLessons(
req.query.course_id
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



if ! grep -q "/api/admin-lesson" server.js
then

cat >> server.js <<'JS'


// Admin Lesson CRUD API

const adminLesson=require("./api/admin-lesson");

app.post(
"/api/admin-lesson",
adminLesson
);

app.get(
"/api/admin-lesson",
adminLesson
);

JS

fi



cat > public/admin/lesson-manager.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Lesson Manager</title>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.box{
background:white;
padding:20px;
border-radius:12px;
}

input,textarea,button{
width:100%;
padding:10px;
margin:5px;
}

button{
background:#1565c0;
color:white;
border:0;
}

</style>

</head>


<body>


<div class="box">


<h1>📖 Manage Lessons</h1>


<input id="course_id" placeholder="Course ID">


<input id="title" placeholder="Lesson Title">


<input id="order" placeholder="Lesson Order">


<textarea id="content" placeholder="Lesson Content"></textarea>


<button onclick="createLesson()">
Create Lesson
</button>


<p id="msg"></p>


</div>



<script>


async function createLesson(){


let res=await fetch(
"/api/admin-lesson",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"create",

lesson:{

course_id:Number(course_id.value),

lesson_order:Number(order.value),

title_en:title.value,

content_en:content.value

}

})

});


let data=await res.json();


msg.innerText=
data.error || "Lesson created ✅";


}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Admin Lesson Manager created"

echo ""
echo "Page:"
echo "/admin/lesson-manager.html"


