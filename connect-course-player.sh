#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Course Player Upgrade"
echo "======================================"

echo ""
echo "1) Backup files"

cp api/courses.js api/courses.before-player.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
cp public/course-player.html public/course-player.before.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true


echo ""
echo "2) Replace course API with content support"

cat > api/courses.js <<'JS'
const db = require("../database");

module.exports = async (req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("courses")
.select(`
id,
title_en,
title_ur,
description_en,
description_ur,
content_en,
content_ur,
points,
created_at
`)
.order("created_at",{ascending:false});

return res.json({
data,
error
});

}


if(req.method==="POST"){

const {
title_en,
title_ur,
description_en,
description_ur,
content_en,
content_ur,
points
}=req.body;


const {data,error}=await db
.from("courses")
.insert([{
title_en,
title_ur,
description_en,
description_ur,
content_en,
content_ur,
points:points || 10
}])
.select();


return res.json({
success:!error,
data,
error
});

}


return res.status(405).json({
error:"Method not allowed"
});

};
JS


echo ""
echo "3) Create course player"

cat > public/course-player.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LearnEarnHub Course Player</title>
</head>

<body>

<h1 id="title">Loading course...</h1>

<h3 id="description"></h3>

<div id="content">
Loading lesson content...
</div>

<button onclick="completeCourse()">
Complete Course / کورس مکمل کریں
</button>

<script>

const API="/api/courses";

let course=null;

async function loadCourse(){

let res=await fetch(API);
let json=await res.json();

course=json.data[0];

document.getElementById("title").innerText=
course.title_en+" / "+course.title_ur;

document.getElementById("description").innerText=
course.description_en;

document.getElementById("content").innerText=
course.content_en || "Content coming soon";

}


async function completeCourse(){

alert("Course completion uses existing API");

}


loadCourse();

</script>

</body>
</html>
HTML


echo ""
echo "4) Git save"

git add api/courses.js public/course-player.html

git commit -m "Connect bilingual course player with course content" || true

git push


echo ""
echo "5) Live test"

sleep 5

echo "COURSES API:"
curl -s https://learn-earnhub.vercel.app/api/courses

echo ""

echo "PLAYER PAGE:"
curl -I -s https://learn-earnhub.vercel.app/course-player.html | head -1


echo ""
echo "======================================"
echo " COURSE PLAYER UPGRADE COMPLETE"
echo "======================================"

