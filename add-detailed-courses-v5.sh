#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub Professional Courses V5"
echo "======================================"

add_course(){

curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"

echo ""
echo "-----------------------------"
}


add_course '{
"title_en":"Artificial Intelligence for Business",
"title_ur":"کاروبار کے لئے مصنوعی ذہانت",
"description_en":"Learn how AI can improve business operations and productivity.",
"description_ur":"سیکھیں کہ AI کاروباری کاموں اور پیداواریت کو کیسے بہتر بناتا ہے۔",
"content_en":"Module 1: AI business overview.\nModule 2: Automation tools.\nModule 3: AI marketing.\nModule 4: Customer support automation.\nModule 5: Future business trends.",
"content_ur":"ماڈیول 1: AI کاروباری تعارف۔\nماڈیول 2: آٹومیشن ٹولز۔\nماڈیول 3: AI مارکیٹنگ۔\nماڈیول 4: کسٹمر سپورٹ آٹومیشن۔\nماڈیول 5: مستقبل کے کاروباری رجحانات۔",
"points":100
}'


add_course '{
"title_en":"Python Web Development",
"title_ur":"پائتھن ویب ڈویلپمنٹ",
"description_en":"Build websites and APIs using Python technologies.",
"description_ur":"پائتھن ٹیکنالوجی سے ویب سائٹس اور APIs بنانا سیکھیں۔",
"content_en":"Module 1: Python web basics.\nModule 2: Flask framework.\nModule 3: APIs.\nModule 4: Database connection.\nModule 5: Deployment.",
"content_ur":"ماڈیول 1: پائتھن ویب بنیادیات۔\nماڈیول 2: Flask فریم ورک۔\nماڈیول 3: APIs۔\nماڈیول 4: ڈیٹا بیس کنکشن۔\nماڈیول 5: آن لائن ڈپلائمنٹ۔",
"points":95
}'


add_course '{
"title_en":"Mobile Photography Skills",
"title_ur":"موبائل فوٹوگرافی مہارتیں",
"description_en":"Learn professional photography using smartphones.",
"description_ur":"اسمارٹ فون سے پروفیشنل فوٹوگرافی سیکھیں۔",
"content_en":"Lesson 1: Camera settings.\nLesson 2: Lighting.\nLesson 3: Composition.\nLesson 4: Photo editing.\nLesson 5: Social media photography.",
"content_ur":"سبق 1: کیمرہ سیٹنگز۔\nسبق 2: روشنی کا استعمال۔\nسبق 3: کمپوزیشن۔\nسبق 4: فوٹو ایڈیٹنگ۔\nسبق 5: سوشل میڈیا فوٹوگرافی۔",
"points":50
}'


add_course '{
"title_en":"Professional Email Writing",
"title_ur":"پروفیشنل ای میل رائٹنگ",
"description_en":"Learn professional business email communication.",
"description_ur":"پروفیشنل بزنس ای میل لکھنا سیکھیں۔",
"content_en":"Module 1: Email structure.\nModule 2: Formal writing.\nModule 3: Client emails.\nModule 4: Follow ups.\nModule 5: Business communication.",
"content_ur":"ماڈیول 1: ای میل ساخت۔\nماڈیول 2: رسمی تحریر۔\nماڈیول 3: کلائنٹ ای میلز۔\nماڈیول 4: فالو اپ۔\nماڈیول 5: کاروباری رابطہ۔",
"points":45
}'


add_course '{
"title_en":"Project Management Basics",
"title_ur":"پروجیکٹ مینجمنٹ بنیادیات",
"description_en":"Learn planning and managing projects.",
"description_ur":"پروجیکٹ پلاننگ اور مینجمنٹ سیکھیں۔",
"content_en":"Module 1: Project planning.\nModule 2: Team management.\nModule 3: Time management.\nModule 4: Risk control.\nModule 5: Project completion.",
"content_ur":"ماڈیول 1: منصوبہ بندی۔\nماڈیول 2: ٹیم مینجمنٹ۔\nماڈیول 3: وقت کا انتظام۔\nماڈیول 4: خطرات کا کنٹرول۔\nماڈیول 5: منصوبہ مکمل کرنا۔",
"points":75
}'


add_course '{
"title_en":"Accounting Fundamentals",
"title_ur":"اکاؤنٹنگ بنیادی کورس",
"description_en":"Learn basic accounting and financial records.",
"description_ur":"اکاؤنٹنگ اور مالی ریکارڈز کی بنیادی معلومات سیکھیں۔",
"content_en":"Lesson 1: Accounting concepts.\nLesson 2: Income and expenses.\nLesson 3: Financial reports.\nLesson 4: Business records.",
"content_ur":"سبق 1: اکاؤنٹنگ تصورات۔\nسبق 2: آمدنی اور اخراجات۔\nسبق 3: مالی رپورٹس۔\nسبق 4: کاروباری ریکارڈ۔",
"points":65
}'


add_course '{
"title_en":"Customer Service Excellence",
"title_ur":"بہترین کسٹمر سروس",
"description_en":"Develop customer handling and support skills.",
"description_ur":"کسٹمر سے بہترین رابطہ اور سپورٹ سیکھیں۔",
"content_en":"Module 1: Customer psychology.\nModule 2: Communication.\nModule 3: Complaint handling.\nModule 4: Customer satisfaction.",
"content_ur":"ماڈیول 1: کسٹمر نفسیات۔\nماڈیول 2: رابطہ کاری۔\nماڈیول 3: شکایات کا حل۔\nماڈیول 4: کسٹمر اطمینان۔",
"points":55
}'


add_course '{
"title_en":"Cloud Security",
"title_ur":"کلاؤڈ سیکیورٹی",
"description_en":"Learn protecting cloud systems and data.",
"description_ur":"کلاؤڈ سسٹمز اور ڈیٹا کا تحفظ سیکھیں۔",
"content_en":"Module 1: Cloud risks.\nModule 2: Access control.\nModule 3: Data protection.\nModule 4: Security monitoring.",
"content_ur":"ماڈیول 1: کلاؤڈ خطرات۔\nماڈیول 2: رسائی کنٹرول۔\nماڈیول 3: ڈیٹا تحفظ۔\nماڈیول 4: سیکیورٹی نگرانی۔",
"points":90
}'


add_course '{
"title_en":"Career Freelancing Roadmap",
"title_ur":"فری لانسنگ کیریئر روڈ میپ",
"description_en":"Complete roadmap for starting online freelance work.",
"description_ur":"آن لائن فری لانسنگ شروع کرنے کا مکمل راستہ۔",
"content_en":"Module 1: Choosing skills.\nModule 2: Building profile.\nModule 3: Finding clients.\nModule 4: Payments.\nModule 5: Career growth.",
"content_ur":"ماڈیول 1: مہارت کا انتخاب۔\nماڈیول 2: پروفائل بنانا۔\nماڈیول 3: کلائنٹس تلاش کرنا۔\nماڈیول 4: ادائیگیاں۔\nماڈیول 5: کیریئر ترقی۔",
"points":85
}'


echo "======================================"
echo "V5 Courses Added Successfully"
echo "======================================"

