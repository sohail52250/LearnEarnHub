#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Course Content Activation"
echo "======================================"

echo ""
echo "1) Backup current files"

cp api/courses.js api/courses.backup.$(date +%Y%m%d-%H%M%S)


echo ""
echo "2) Create bilingual course content file"

cat > course-content-data.json <<'JSON'
{
  "title_en": "Freelancing Introduction",
  "title_ur": "فری لانسنگ کا تعارف",
  "description_en": "Learn how to start earning online through freelancing.",
  "description_ur": "فری لانسنگ کے ذریعے آن لائن کمائی شروع کرنا سیکھیں۔",
  "content_en": "Welcome to Freelancing Introduction.\n\nLesson 1: Understand freelancing.\nLesson 2: Build your profile.\nLesson 3: Find clients and deliver projects.\n\nSkills: Writing, Design, Programming, Marketing.",
  "content_ur": "فری لانسنگ کے تعارفی کورس میں خوش آمدید۔\n\nسبق 1: فری لانسنگ کو سمجھیں۔\nسبق 2: اپنا پروفائل بنائیں۔\nسبق 3: کلائنٹس تلاش کریں اور پراجیکٹس مکمل کریں۔\n\nمہارتیں: رائٹنگ، ڈیزائن، پروگرامنگ، مارکیٹنگ۔",
  "points": 30
}
JSON


echo ""
echo "3) Check current course API"

sed -n '1,220p' api/courses.js


echo ""
echo "4) Save changes"

git add course-content-data.json

git commit -m "Add bilingual course content data" || true

git push


echo ""
echo "5) Live check"

sleep 5

curl -s https://learn-earnhub.vercel.app/api/courses


echo ""
echo ""
echo "======================================"
echo " COURSE CONTENT ACTIVATION READY"
echo "======================================"

