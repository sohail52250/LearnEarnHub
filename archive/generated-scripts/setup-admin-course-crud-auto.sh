#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Admin Course CRUD Setup ==="

mkdir -p api services public/admin



cat > services/admin-course-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createCourse(course){

const {data,error}=await db
.from("courses")
.insert(course)
.select()
.single();

if(error) throw error;

return data;

}



async function updateCourse(id,course){

const {data,error}=await db
.from("courses")
.update(course)
.eq("id",id)
.select()
.single();

if(error) throw error;

return data;

}



async function deleteCourse(id){

const {error}=await db
.from("courses")
.delete()
.eq("id",id);


if(error) throw error;


return {
success:true
};

}



module.exports={
createCourse,
updateCourse,
deleteCourse
};

JS



cat > api/admin-course.js <<'JS'
const service=require("../services/admin-course-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createCourse(
req.body.course
)
);

}



if(req.body.action==="update"){

return res.json(
await service.updateCourse(
req.body.id,
req.body.course
)
);

}



if(req.body.action==="delete"){

return res.json(
await service.deleteCourse(
req.body.id
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



if ! grep -q "/api/admin-course" server.js
then

cat >> server.js <<'JS'


// Admin Course CRUD API

const adminCourse=require("./api/admin-course");

app.post(
"/api/admin-course",
adminCourse
);

JS

fi



cat > public/admin/course-manager.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Course Manager</title>

<style>

body{
font-family:Arial;
padding:20px;
background:#f5f7fb;
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

.box{
background:white;
padding:20px;
border-radius:10px;
}

</style>

</head>


<body>


<div class="box">


<h1>📚 Manage Courses</h1>


<input id="title" placeholder="Course title">


<input id="category" placeholder="Category">


<textarea id="description" placeholder="Description"></textarea>


<button onclick="createCourse()">
Create Course
</button>


<p id="msg"></p>


</div>



<script>


async function createCourse(){


let res=await fetch(
"/api/admin-course",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"create",

course:{

title_en:title.value,

category:category.value,

description_en:description.value

}

})

});


let data=await res.json();


msg.innerText=
data.error || "Course created ✅";


}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Admin Course CRUD created"

echo ""
echo "Page:"
echo "/admin/course-manager.html"


