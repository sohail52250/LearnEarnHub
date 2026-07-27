#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub Batch Course Installer"
echo "======================================"

add_course(){
curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"
echo ""
echo "-----------------------------"
}


add_course '{
"title_en":"SEO Fundamentals",
"title_ur":"SEO بنیادی کورس",
"description_en":"Learn search engine optimization and website ranking.",
"description_ur":"سرچ انجن آپٹیمائزیشن اور ویب سائٹ رینکنگ سیکھیں۔",
"content_en":"Lesson 1: What is SEO?\nLesson 2: Keywords research.\nLesson 3: On-page SEO.\nLesson 4: Link building.\nLesson 5: SEO tools.",
"content_ur":"سبق 1: SEO کیا ہے؟\nسبق 2: کی ورڈ تحقیق۔\nسبق 3: آن پیج SEO۔\nسبق 4: لنک بلڈنگ۔\nسبق 5: SEO ٹولز۔",
"points":45
}'


add_course '{
"title_en":"UI UX Design",
"title_ur":"UI UX ڈیزائن",
"description_en":"Learn user interface and user experience design.",
"description_ur":"یوزر انٹرفیس اور یوزر ایکسپیرینس ڈیزائن سیکھیں۔",
"content_en":"Lesson 1: Design thinking.\nLesson 2: Wireframes.\nLesson 3: Prototypes.\nLesson 4: User testing.",
"content_ur":"سبق 1: ڈیزائن سوچ۔\nسبق 2: وائر فریم۔\nسبق 3: پروٹو ٹائپ۔\nسبق 4: یوزر ٹیسٹنگ۔",
"points":50
}'


add_course '{
"title_en":"Cloud Computing Basics",
"title_ur":"کلاؤڈ کمپیوٹنگ بنیادی معلومات",
"description_en":"Understand cloud services and online infrastructure.",
"description_ur":"کلاؤڈ سروسز اور آن لائن انفراسٹرکچر سمجھیں۔",
"content_en":"Lesson 1: Cloud concepts.\nLesson 2: Cloud storage.\nLesson 3: Cloud security.",
"content_ur":"سبق 1: کلاؤڈ تصورات۔\nسبق 2: کلاؤڈ اسٹوریج۔\nسبق 3: کلاؤڈ سیکیورٹی۔",
"points":50
}'


add_course '{
"title_en":"Data Analysis Basics",
"title_ur":"ڈیٹا اینالیسس بنیادی کورس",
"description_en":"Learn data handling and analysis skills.",
"description_ur":"ڈیٹا کو سمجھنا اور تجزیہ کرنا سیکھیں۔",
"content_en":"Lesson 1: Data concepts.\nLesson 2: Excel analysis.\nLesson 3: Charts and reports.",
"content_ur":"سبق 1: ڈیٹا تصورات۔\nسبق 2: Excel تجزیہ۔\nسبق 3: چارٹس اور رپورٹس۔",
"points":55
}'


add_course '{
"title_en":"Digital Entrepreneurship",
"title_ur":"ڈیجیٹل کاروباری مہارتیں",
"description_en":"Learn building online businesses.",
"description_ur":"آن لائن کاروبار بنانا سیکھیں۔",
"content_en":"Lesson 1: Business ideas.\nLesson 2: Online platforms.\nLesson 3: Customer growth.",
"content_ur":"سبق 1: کاروباری خیالات۔\nسبق 2: آن لائن پلیٹ فارم۔\nسبق 3: صارفین میں اضافہ۔",
"points":50
}'


add_course '{
"title_en":"Email Marketing",
"title_ur":"ای میل مارکیٹنگ",
"description_en":"Learn professional email campaigns.",
"description_ur":"پروفیشنل ای میل مہمات بنانا سیکھیں۔",
"content_en":"Lesson 1: Email lists.\nLesson 2: Campaign design.\nLesson 3: Analytics.",
"content_ur":"سبق 1: ای میل لسٹس۔\nسبق 2: مہم ڈیزائن۔\nسبق 3: نتائج کا تجزیہ۔",
"points":35
}'


add_course '{
"title_en":"Blockchain Introduction",
"title_ur":"بلاک چین کا تعارف",
"description_en":"Learn blockchain concepts and applications.",
"description_ur":"بلاک چین کے تصورات اور استعمال سیکھیں۔",
"content_en":"Lesson 1: Blockchain basics.\nLesson 2: Distributed systems.\nLesson 3: Real applications.",
"content_ur":"سبق 1: بلاک چین بنیادی معلومات۔\nسبق 2: تقسیم شدہ نظام۔\nسبق 3: عملی استعمال۔",
"points":45
}'


add_course '{
"title_en":"Project Management",
"title_ur":"پروجیکٹ مینجمنٹ",
"description_en":"Learn planning and managing projects.",
"description_ur":"منصوبہ بندی اور پروجیکٹ مینجمنٹ سیکھیں۔",
"content_en":"Lesson 1: Project planning.\nLesson 2: Team management.\nLesson 3: Delivery methods.",
"content_ur":"سبق 1: منصوبہ بندی۔\nسبق 2: ٹیم مینجمنٹ۔\nسبق 3: کام مکمل کرنے کے طریقے۔",
"points":45
}'


add_course '{
"title_en":"Customer Service Skills",
"title_ur":"کسٹمر سروس مہارتیں",
"description_en":"Improve customer communication.",
"description_ur":"صارفین سے بہتر رابطہ سیکھیں۔",
"content_en":"Lesson 1: Customer handling.\nLesson 2: Problem solving.\nLesson 3: Professional attitude.",
"content_ur":"سبق 1: صارفین سے رابطہ۔\nسبق 2: مسائل حل کرنا۔\nسبق 3: پروفیشنل رویہ۔",
"points":30
}'


add_course '{
"title_en":"Typing Skills",
"title_ur":"ٹائپنگ مہارتیں",
"description_en":"Improve typing speed and accuracy.",
"description_ur":"ٹائپنگ رفتار اور درستگی بہتر کریں۔",
"content_en":"Lesson 1: Keyboard basics.\nLesson 2: Speed practice.\nLesson 3: Accuracy improvement.",
"content_ur":"سبق 1: کی بورڈ معلومات۔\nسبق 2: رفتار کی مشق۔\nسبق 3: درستگی بہتر کرنا۔",
"points":25
}'


echo ""
echo "Checking API..."

curl -s "$URL"

echo ""
echo "======================================"
echo " New Courses Added Successfully"
echo "======================================"

