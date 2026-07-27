#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub Detailed Course Installer"
echo "======================================"

add_course(){

echo "Adding course..."

curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"

echo
echo "--------------------------------------"
}


add_course '{
"title_en":"Artificial Intelligence Complete Guide",
"title_ur":"مصنوعی ذہانت مکمل گائیڈ",
"description_en":"Learn AI concepts, tools and practical applications.",
"description_ur":"AI کے تصورات، ٹولز اور عملی استعمال سیکھیں۔",
"content_en":"Module 1: Introduction to Artificial Intelligence.\nModule 2: Machine Learning basics.\nModule 3: AI productivity tools.\nModule 4: AI content creation.\nModule 5: AI business applications.",
"content_ur":"ماڈیول 1: مصنوعی ذہانت کا تعارف۔\nماڈیول 2: مشین لرننگ بنیادیات۔\nماڈیول 3: AI پیداواری ٹولز۔\nماڈیول 4: AI مواد تخلیق۔\nماڈیول 5: کاروبار میں AI استعمال۔",
"points":100
}'


add_course '{
"title_en":"Python Programming Advanced",
"title_ur":"ایڈوانس پائتھن پروگرامنگ",
"description_en":"Learn Python from basics to automation projects.",
"description_ur":"پائتھن بنیادیات سے آٹومیشن منصوبوں تک سیکھیں۔",
"content_en":"Module 1: Python syntax.\nModule 2: Data structures.\nModule 3: Functions and modules.\nModule 4: File handling.\nModule 5: Automation projects.",
"content_ur":"ماڈیول 1: پائتھن سنٹیکس۔\nماڈیول 2: ڈیٹا اسٹرکچر۔\nماڈیول 3: فنکشنز اور ماڈیولز۔\nماڈیول 4: فائل ہینڈلنگ۔\nماڈیول 5: آٹومیشن منصوبے۔",
"points":90
}'


add_course '{
"title_en":"Database Management Professional",
"title_ur":"پروفیشنل ڈیٹا بیس مینجمنٹ",
"description_en":"Learn SQL databases and data management.",
"description_ur":"SQL، ڈیٹا بیس اور ڈیٹا مینجمنٹ سیکھیں۔",
"content_en":"Module 1: Database concepts.\nModule 2: SQL queries.\nModule 3: Database design.\nModule 4: Security.\nModule 5: Backup management.",
"content_ur":"ماڈیول 1: ڈیٹا بیس تصورات۔\nماڈیول 2: SQL کمانڈز۔\nماڈیول 3: ڈیٹا بیس ڈیزائن۔\nماڈیول 4: سیکیورٹی۔\nماڈیول 5: بیک اپ مینجمنٹ۔",
"points":85
}'


add_course '{
"title_en":"Video Editing Professional",
"title_ur":"پروفیشنل ویڈیو ایڈیٹنگ",
"description_en":"Learn video editing for freelancing and business.",
"description_ur":"فری لانسنگ اور کاروبار کے لئے ویڈیو ایڈیٹنگ سیکھیں۔",
"content_en":"Module 1: Video fundamentals.\nModule 2: Editing software.\nModule 3: Effects and transitions.\nModule 4: Audio editing.\nModule 5: Publishing videos.",
"content_ur":"ماڈیول 1: ویڈیو بنیادیات۔\nماڈیول 2: ایڈیٹنگ سافٹ ویئر۔\nماڈیول 3: ایفیکٹس۔\nماڈیول 4: آڈیو ایڈیٹنگ۔\nماڈیول 5: ویڈیو شائع کرنا۔",
"points":70
}'


add_course '{
"title_en":"Communication Skills",
"title_ur":"رابطہ کاری کی مہارتیں",
"description_en":"Improve professional communication skills.",
"description_ur":"پروفیشنل رابطہ کاری کی صلاحیت بہتر کریں۔",
"content_en":"Lesson 1: Speaking skills.\nLesson 2: Writing skills.\nLesson 3: Email communication.\nLesson 4: Interview preparation.",
"content_ur":"سبق 1: بولنے کی مہارت۔\nسبق 2: لکھنے کی مہارت۔\nسبق 3: ای میل رابطہ۔\nسبق 4: انٹرویو تیاری۔",
"points":50
}'


add_course '{
"title_en":"Online Business Startup",
"title_ur":"آن لائن کاروبار اسٹارٹ اپ",
"description_en":"Learn how to create an online business.",
"description_ur":"آن لائن کاروبار شروع کرنا سیکھیں۔",
"content_en":"Module 1: Business ideas.\nModule 2: Market research.\nModule 3: Customer handling.\nModule 4: Digital payments.\nModule 5: Business growth.",
"content_ur":"ماڈیول 1: کاروباری خیالات۔\nماڈیول 2: مارکیٹ تحقیق۔\nماڈیول 3: کسٹمر مینجمنٹ۔\nماڈیول 4: ڈیجیٹل ادائیگیاں۔\nماڈیول 5: کاروباری ترقی۔",
"points":80
}'


add_course '{
"title_en":"Graphic Design Advanced",
"title_ur":"ایڈوانس گرافک ڈیزائن",
"description_en":"Master creative design techniques.",
"description_ur":"تخلیقی ڈیزائن کی جدید تکنیکیں سیکھیں۔",
"content_en":"Module 1: Design theory.\nModule 2: Branding.\nModule 3: Logo systems.\nModule 4: Marketing graphics.\nModule 5: Client projects.",
"content_ur":"ماڈیول 1: ڈیزائن تھیوری۔\nماڈیول 2: برانڈنگ۔\nماڈیول 3: لوگو سسٹم۔\nماڈیول 4: مارکیٹنگ گرافکس۔\nماڈیول 5: کلائنٹ منصوبے۔",
"points":75
}'


add_course '{
"title_en":"Mobile App Development Basics",
"title_ur":"موبائل ایپ ڈویلپمنٹ بنیادیات",
"description_en":"Learn mobile application development concepts.",
"description_ur":"موبائل ایپ بنانے کے بنیادی اصول سیکھیں۔",
"content_en":"Module 1: Mobile platforms.\nModule 2: UI design.\nModule 3: App development tools.\nModule 4: Testing applications.",
"content_ur":"ماڈیول 1: موبائل پلیٹ فارم۔\nماڈیول 2: UI ڈیزائن۔\nماڈیول 3: ایپ ٹولز۔\nماڈیول 4: ایپ ٹیسٹنگ۔",
"points":85
}'


add_course '{
"title_en":"Career Development Skills",
"title_ur":"کیریئر ڈویلپمنٹ مہارتیں",
"description_en":"Learn skills for career growth.",
"description_ur":"کیریئر ترقی کے لئے ضروری مہارتیں سیکھیں۔",
"content_en":"Lesson 1: Career planning.\nLesson 2: Resume building.\nLesson 3: Interview skills.\nLesson 4: Professional growth.",
"content_ur":"سبق 1: کیریئر منصوبہ بندی۔\nسبق 2: ریزیومے بنانا۔\nسبق 3: انٹرویو مہارت۔\nسبق 4: پروفیشنل ترقی۔",
"points":60
}'


echo "======================================"
echo " All Courses Added"
echo "======================================"

curl -s "$URL"

