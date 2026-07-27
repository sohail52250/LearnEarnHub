#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Learning Progress Upgrade"
echo "======================================"

mkdir -p database

cat > database/learning_progress_upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS lesson_progress (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
lesson_id uuid REFERENCES course_lessons(id) ON DELETE CASCADE,
completed boolean DEFAULT false,
score integer DEFAULT 0,
completed_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS certificates (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
certificate_code text UNIQUE,
issued_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS badges (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
badge_name text,
created_at timestamp DEFAULT now()
);

SQL


cat > api/complete-lesson.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method!=="POST"){
return res.status(405).json({
error:"POST only"
});
}


const {
user_id,
lesson_id,
score
}=req.body;


const {data,error}=await db
.from("lesson_progress")
.insert([{
user_id,
lesson_id,
completed:true,
score:score || 0
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS


git add database/learning_progress_upgrade.sql api/complete-lesson.js

git commit -m "Add lesson progress and certificate foundation" || true

git push


echo "======================================"
echo " Progress System Ready"
echo "======================================"

