#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Course Lessons Upgrade"
echo "======================================"

mkdir -p database

cat > database/course_lessons_upgrade.sql <<'SQL'
CREATE TABLE IF NOT EXISTS course_lessons (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
lesson_title_en text NOT NULL,
lesson_title_ur text,
lesson_content_en text,
lesson_content_ur text,
video_url text,
lesson_order integer DEFAULT 1,
points integer DEFAULT 5,
created_at timestamp DEFAULT now()
);

ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;
SQL


echo "Creating lessons API..."

cat > api/course-lessons.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const course_id=req.query.course_id;

const {data,error}=await db
.from("course_lessons")
.select("*")
.eq("course_id",course_id)
.order("lesson_order");

return res.json({
data,
error
});

}


if(req.method==="POST"){

const lesson=req.body;

const {data,error}=await db
.from("course_lessons")
.insert([lesson])
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


echo "Creating lesson seed script..."

cat > add-course-lessons.sh <<'SEED'
#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/course-lessons"

COURSE_ID=$1


add(){

curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"

echo ""

}


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Introduction",
"lesson_title_ur":"تعارف",
"lesson_content_en":"Course overview and learning objectives.",
"lesson_content_ur":"کورس کا تعارف اور مقاصد۔",
"lesson_order":1,
"points":5
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Basic Concepts",
"lesson_title_ur":"بنیادی تصورات",
"lesson_content_en":"Learn important concepts and terminology.",
"lesson_content_ur":"اہم تصورات اور اصطلاحات سیکھیں۔",
"lesson_order":2,
"points":10
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Practical Skills",
"lesson_title_ur":"عملی مہارتیں",
"lesson_content_en":"Practice real world examples and exercises.",
"lesson_content_ur":"حقیقی مثالوں اور مشقوں سے سیکھیں۔",
"lesson_order":3,
"points":15
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Project Work",
"lesson_title_ur":"پروجیکٹ ورک",
"lesson_content_en":"Build a practical project.",
"lesson_content_ur":"ایک عملی منصوبہ تیار کریں۔",
"lesson_order":4,
"points":20
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Final Assessment",
"lesson_title_ur":"حتمی جائزہ",
"lesson_content_en":"Complete assessment and earn certificate.",
"lesson_content_ur":"جائزہ مکمل کریں اور سرٹیفکیٹ حاصل کریں۔",
"lesson_order":5,
"points":25
}'

SEED


chmod +x add-course-lessons.sh


git add database/course_lessons_upgrade.sql api/course-lessons.js add-course-lessons.sh

git commit -m "Add course lessons learning system" || true

git push


echo ""
echo "======================================"
echo " Course Lessons System Added"
echo "======================================"

echo "Next:"
echo "1. Run SQL in Supabase:"
echo "database/course_lessons_upgrade.sql"
echo ""
echo "2. Add lessons using:"
echo "./add-course-lessons.sh COURSE_ID"

