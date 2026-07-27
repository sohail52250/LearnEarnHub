#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Course Content Upgrade"
echo "======================================"

echo "1) Backup course API"
cp api/courses.js api/courses.backup.$(date +%Y%m%d-%H%M%S)

echo "2) Updating course API with content fields"

python - <<'PY'
p="api/courses.js"

s=open(p).read()

s=s.replace(
'title_en,',
'title_en,\n                                 content_en,\n                                 content_ur,'
)

s=s.replace(
'description_ur,\n                                 points',
'description_ur,\n                                 content_en,\n                                 content_ur,\n                                 points'
)

s=s.replace(
'description_ur,\n                           points',
'description_ur,\n                           content_en,\n                           content_ur,\n                           points'
)

open(p,"w").write(s)

PY


echo "3) Create sample lesson content"

cat > course-content.json <<'JSON'
{
"title_en":"Freelancing Introduction",
"title_ur":"فری لانسنگ کا تعارف",

"description_en":"Learn how to start earning online through freelancing.",
"description_ur":"فری لانسنگ کے ذریعے آن لائن کمائی شروع کرنا سیکھیں۔",

"content_en":"Lesson 1: What is freelancing?\n\nFreelancing means providing your skills online and earning money from clients.\n\nSkills include:\n- Graphic Design\n- Writing\n- Programming\n- Digital Marketing\n\nLesson 2: Create your profile.\n\nLesson 3: Find clients and complete projects.",

"content_ur":"سبق 1: فری لانسنگ کیا ہے؟\n\nفری لانسنگ میں آپ اپنی صلاحیتیں آن لائن استعمال کرکے کلائنٹس سے کمائی کرتے ہیں۔\n\nمہارتیں:\n- گرافک ڈیزائن\n- تحریر\n- پروگرامنگ\n- ڈیجیٹل مارکیٹنگ\n\nسبق 2: اپنا پروفائل بنائیں۔\n\nسبق 3: کلائنٹس تلاش کریں اور کام مکمل کریں۔",

"points":30
}
JSON


echo "4) Git save"

git add api/courses.js course-content.json

git commit -m "Add bilingual course content support" || true

git push


echo ""
echo "======================================"
echo " Check Deployment"
echo "======================================"

sleep 5

curl -s https://learn-earnhub.vercel.app/api/courses

echo ""
echo "DONE"

