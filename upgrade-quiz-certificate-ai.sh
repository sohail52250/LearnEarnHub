#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Quiz + Certificate Upgrade"
echo "======================================"

mkdir -p database


cat > database/quiz_certificate_ai_upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS quizzes (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
question_en text,
question_ur text,
option_a text,
option_b text,
option_c text,
option_d text,
correct_answer text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS quiz_results (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
score integer DEFAULT 0,
passed boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_course_reviews (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
review_text text,
rating integer DEFAULT 5,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS certificates (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
certificate_code text UNIQUE,
certificate_title text,
issued_at timestamp DEFAULT now()
);

SQL


echo "Creating quiz API..."

cat > api/quiz.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const course_id=req.query.course_id;

const {data,error}=await db
.from("quizzes")
.select("*")
.eq("course_id",course_id);

return res.json({
data,
error
});

}


if(req.method==="POST"){

const quiz=req.body;

const {data,error}=await db
.from("quiz_results")
.insert([quiz])
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



echo "Creating certificate API..."

cat > api/generate-certificate.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {
user_id,
course_id
}=req.body;


const code="LEH-"+Date.now();


const {data,error}=await db
.from("certificates")
.insert([{
user_id,
course_id,
certificate_code:code,
certificate_title:"LearnEarnHub Course Certificate"
}])
.select();


return res.json({
success:!error,
certificate:data,
error
});

};
JS



echo "Creating AI review API..."

cat > api/ai-course-review.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {
course_id,
review_text,
rating
}=req.body;


const {data,error}=await db
.from("ai_course_reviews")
.insert([{
course_id,
review_text,
rating
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



git add database/quiz_certificate_ai_upgrade.sql api/quiz.js api/generate-certificate.js api/ai-course-review.js

git commit -m "Add quiz certificate and AI review system" || true

git push


echo "======================================"
echo " Quiz + Certificate Upgrade Complete"
echo "======================================"

echo "Next:"
echo "Run SQL file in Supabase:"
echo "database/quiz_certificate_ai_upgrade.sql"

