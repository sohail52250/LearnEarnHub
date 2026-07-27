#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub Detailed Course Installer"
echo "======================================"

add_course(){
echo "Adding: $1"
curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$2"
echo ""
echo "--------------------------------------"
}


add_course "Web Development Complete Course" '{
"title_en":"Web Development Complete Course",
"title_ur":"مکمل ویب ڈویلپمنٹ کورس",
"description_en":"Learn HTML, CSS, JavaScript and modern web development step by step.",
"description_ur":"HTML، CSS، JavaScript اور جدید ویب ڈویلپمنٹ مرحلہ وار سیکھیں۔",
"content_en":"Module 1: Internet and website basics.\nModule 2: HTML structure and forms.\nModule 3: CSS design and responsive layouts.\nModule 4: JavaScript programming.\nModule 5: APIs and backend introduction.\nModule 6: Build and publish websites.",
"content_ur":"ماڈیول 1: انٹرنیٹ اور ویب سائٹ کی بنیادی معلومات۔\nماڈیول 2: HTML اسٹرکچر اور فارمز۔\nماڈیول 3: CSS ڈیزائن اور ریسپانسیو لے آؤٹ۔\nماڈیول 4: JavaScript پروگرامنگ۔\nماڈیول 5: API اور بیک اینڈ تعارف۔\nماڈیول 6: ویب سائٹ بنانا اور شائع کرنا۔",
"points":100
}'


add_course "Digital Marketing Mastery" '{
"title_en":"Digital Marketing Mastery",
"title_ur":"ڈیجیٹل مارکیٹنگ ماسٹری",
"description_en":"Learn SEO, social media marketing and online advertising.",
"description_ur":"SEO، سوشل میڈیا مارکیٹنگ اور آن لائن اشتہارات سیکھیں۔",
"content_en":"Lesson 1: Digital marketing overview.\nLesson 2: SEO basics.\nLesson 3: Facebook and Instagram marketing.\nLesson 4: Google Ads basics.\nLesson 5: Email marketing.\nLesson 6: Marketing analytics.",
"content_ur":"سبق 1: ڈیجیٹل مارکیٹنگ کا تعارف۔\nسبق 2: SEO بنیادی معلومات۔\nسبق 3: فیس بک اور انسٹاگرام مارکیٹنگ۔\nسبق 4: گوگل اشتہارات۔\nسبق 5: ای میل مارکیٹنگ۔\nسبق 6: مارکیٹنگ تجزیہ۔",
"points":90
}'


add_course "Graphic Design Professional" '{
"title_en":"Graphic Design Professional",
"title_ur":"پروفیشنل گرافک ڈیزائن",
"description_en":"Learn creative design skills using modern tools.",
"description_ur":"جدید ٹولز کے ذریعے تخلیقی ڈیزائن سیکھیں۔",
"content_en":"Lesson 1: Design principles.\nLesson 2: Colors and typography.\nLesson 3: Logo design.\nLesson 4: Social media graphics.\nLesson 5: Portfolio creation.",
"content_ur":"سبق 1: ڈیزائن اصول۔\nسبق 2: رنگ اور فونٹس۔\nسبق 3: لوگو ڈیزائن۔\nسبق 4: سوشل میڈیا گرافکس۔\nسبق 5: پورٹ فولیو بنانا۔",
"points":80
}'


add_course "Freelancing Complete Guide" '{
"title_en":"Freelancing Complete Guide",
"title_ur":"فری لانسنگ مکمل رہنمائی",
"description_en":"Learn how to start and grow freelancing career.",
"description_ur":"فری لانسنگ شروع کرنے اور بڑھانے کا مکمل طریقہ۔",
"content_en":"Lesson 1: Freelancing platforms.\nLesson 2: Profile building.\nLesson 3: Finding clients.\nLesson 4: Proposal writing.\nLesson 5: Payments and client management.",
"content_ur":"سبق 1: فری لانس پلیٹ فارمز۔\nسبق 2: پروفائل بنانا۔\nسبق 3: کلائنٹس تلاش کرنا۔\nسبق 4: پروپوزل لکھنا۔\nسبق 5: ادائیگی اور کلائنٹ مینجمنٹ۔",
"points":100
}'


add_course "Data Science Fundamentals" '{
"title_en":"Data Science Fundamentals",
"title_ur":"ڈیٹا سائنس بنیادی کورس",
"description_en":"Learn data analysis and practical data skills.",
"description_ur":"ڈیٹا تجزیہ اور عملی ڈیٹا مہارتیں سیکھیں۔",
"content_en":"Module 1: Data concepts.\nModule 2: Data cleaning.\nModule 3: Analysis methods.\nModule 4: Visualization.\nModule 5: Introduction to machine learning.",
"content_ur":"ماڈیول 1: ڈیٹا تصورات۔\nماڈیول 2: ڈیٹا صفائی۔\nماڈیول 3: تجزیاتی طریقے۔\nماڈیول 4: ڈیٹا ویژولائزیشن۔\nماڈیول 5: مشین لرننگ تعارف۔",
"points":120
}'


add_course "Cloud Computing Basics" '{
"title_en":"Cloud Computing Basics",
"title_ur":"کلاؤڈ کمپیوٹنگ بنیادی کورس",
"description_en":"Understand cloud services and deployment concepts.",
"description_ur":"کلاؤڈ سروسز اور ڈپلائمنٹ کے تصورات سیکھیں۔",
"content_en":"Lesson 1: Cloud introduction.\nLesson 2: Virtual servers.\nLesson 3: Storage services.\nLesson 4: Cloud security.\nLesson 5: Deployment basics.",
"content_ur":"سبق 1: کلاؤڈ تعارف۔\nسبق 2: ورچوئل سرورز۔\nسبق 3: اسٹوریج سروسز۔\nسبق 4: کلاؤڈ سیکیورٹی۔\nسبق 5: ڈپلائمنٹ۔",
"points":100
}'


add_course "Office Productivity Skills" '{
"title_en":"Office Productivity Skills",
"title_ur":"آفس پروڈکٹیوٹی مہارتیں",
"description_en":"Learn Word, Excel and PowerPoint professional skills.",
"description_ur":"Word، Excel اور PowerPoint کی پروفیشنل مہارتیں سیکھیں۔",
"content_en":"Lesson 1: Document creation.\nLesson 2: Spreadsheet formulas.\nLesson 3: Presentations.\nLesson 4: Office automation.",
"content_ur":"سبق 1: ڈاکومنٹ بنانا۔\nسبق 2: اسپریڈشیٹ فارمولے۔\nسبق 3: پریزنٹیشن۔\nسبق 4: آفس آٹومیشن۔",
"points":70
}'


add_course "Cyber Security Advanced" '{
"title_en":"Cyber Security Advanced",
"title_ur":"ایڈوانس سائبر سیکیورٹی",
"description_en":"Learn advanced protection techniques.",
"description_ur":"اعلیٰ سطح کی حفاظتی تکنیکیں سیکھیں۔",
"content_en":"Lesson 1: Network security.\nLesson 2: Password protection.\nLesson 3: Malware awareness.\nLesson 4: Security monitoring.",
"content_ur":"سبق 1: نیٹ ورک سیکیورٹی۔\nسبق 2: پاس ورڈ تحفظ۔\nسبق 3: میلویئر آگاہی۔\nسبق 4: سیکیورٹی مانیٹرنگ۔",
"points":110
}'


add_course "AI Productivity Skills" '{
"title_en":"AI Productivity Skills",
"title_ur":"AI پروڈکٹیوٹی مہارتیں",
"description_en":"Learn practical artificial intelligence tools.",
"description_ur":"مصنوعی ذہانت کے عملی ٹولز سیکھیں۔",
"content_en":"Lesson 1: AI assistants.\nLesson 2: Prompt writing.\nLesson 3: Automation workflows.\nLesson 4: AI business uses.",
"content_ur":"سبق 1: AI اسسٹنٹس۔\nسبق 2: پرامپٹ لکھنا۔\nسبق 3: آٹومیشن ورک فلو۔\nسبق 4: کاروباری AI استعمال۔",
"points":90
}'


echo "======================================"
echo "All courses added"
echo "======================================"

