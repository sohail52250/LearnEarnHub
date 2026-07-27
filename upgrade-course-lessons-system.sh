#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Course Lesson Upgrade"
echo "======================================"

mkdir -p public/lessons

echo "1) Creating database SQL..."

cat > course-lessons-upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS course_lessons (
id BIGSERIAL PRIMARY KEY,
course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
title_en TEXT NOT NULL,
title_ur TEXT NOT NULL,
content_en TEXT,
content_ur TEXT,
lesson_order INTEGER DEFAULT 1,
points INTEGER DEFAULT 10,
created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read lessons"
ON course_lessons
FOR SELECT
USING (true);

SQL


echo "SQL created:"
echo "course-lessons-upgrade.sql"

echo ""
echo "2) Creating lesson API..."

cat > api/lessons.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const {course_id}=req.query;

let query=db
.from("course_lessons")
.select("*")
.order("lesson_order");

if(course_id){
query=query.eq("course_id",course_id);
}

const {data,error}=await query;

return res.json({
data,
error
});

}


if(req.method==="POST"){

const {
course_id,
title_en,
title_ur,
content_en,
content_ur,
lesson_order,
points
}=req.body;


const {data,error}=await db
.from("course_lessons")
.insert([{
course_id,
title_en,
title_ur,
content_en,
content_ur,
lesson_order,
points
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


echo "3) Creating lesson viewer..."

cat > public/lesson-viewer.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Lesson</title>
<meta charset="UTF-8">
</head>

<body>

<h1>Lesson Viewer</h1>

<div id="lesson">
Loading lesson...
</div>


<script>

const params=new URLSearchParams(location.search);
const course=params.get("course_id");


fetch("/api/lessons?course_id="+course)
.then(r=>r.json())
.then(x=>{

let html="";

x.data.forEach(l=>{

html+=`
<h2>${l.title_en}</h2>
<h3>${l.title_ur}</h3>

<p>${l.content_en}</p>

<p>${l.content_ur}</p>

<hr>
`;

});

document.getElementById("lesson").innerHTML=html;

});

</script>

</body>
</html>
HTML


echo "4) Creating sample lesson installer..."

cat > add-sample-lessons.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/lessons"

COURSE="9340f8f3-8d69-4881-8585-42f1af2f77c4"


curl -s -X POST $URL \
-H "Content-Type: application/json" \
-d "{
\"course_id\":\"$COURSE\",
\"title_en\":\"Introduction Lesson\",
\"title_ur\":\"تعارفی سبق\",
\"content_en\":\"Learn course basics, goals and practical skills.\",
\"content_ur\":\"کورس کے بنیادی اصول، مقاصد اور عملی مہارتیں سیکھیں۔\",
\"lesson_order\":1,
\"points\":10
}"


curl -s -X POST $URL \
-H "Content-Type: application/json" \
-d "{
\"course_id\":\"$COURSE\",
\"title_en\":\"Practical Exercise\",
\"title_ur\":\"عملی مشق\",
\"content_en\":\"Complete exercises and build your skills.\",
\"content_ur\":\"مشقیں مکمل کریں اور اپنی مہارت بہتر کریں۔\",
\"lesson_order\":2,
\"points\":20
}"

echo
echo "Lessons added"
SH


chmod +x add-sample-lessons.sh


echo "5) Git save"

git add .
git commit -m "Add complete course lesson system" || true
git push


echo ""
echo "======================================"
echo "DONE"
echo "======================================"

