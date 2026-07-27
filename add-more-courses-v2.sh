#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub More Courses Installer"
echo "======================================"

add_course(){
curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"
echo ""
echo "--------------------------------------"
}

add_course '{
"title_en":"Web Development Full Course",
"title_ur":"ویب ڈویلپمنٹ مکمل کورس",
"description_en":"Learn HTML, CSS, JavaScript and modern web development.",
"description_ur":"HTML، CSS، JavaScript اور جدید ویب ڈویلپمنٹ سیکھیں۔",
"content_en":"Module 1: Internet and websites.\nModule 2: HTML structure.\nModule 3: CSS design.\nModule 4: JavaScript programming.\nModule 5: Responsive websites.\nModule 6: Deploying websites online.",
"content_ur":"ماڈیول 1: انٹرنیٹ اور ویب سائٹس۔\nماڈیول 2: HTML اسٹرکچر۔\nماڈیول 3: CSS ڈیزائن۔\nماڈیول 4: JavaScript پروگرامنگ۔\nماڈیول 5: ریسپانسیو ویب سائٹس۔\nماڈیول 6: ویب سائٹ آن لائن شائع کرنا۔",
"points":80
}'


add_course '{
"title_en":"Digital Marketing Mastery",
"title_ur":"ڈیجیٹل مارکیٹنگ ماسٹری",
"description_en":"Learn SEO, social media marketing and online advertising.",
"description_ur":"SEO، سوشل میڈیا مارکیٹنگ اور آن لائن اشتہارات سیکھیں۔",
"content_en":"Module 1: Digital marketing basics.\nModule 2: SEO.\nModule 3: Social media strategy.\nModule 4: Content marketing.\nModule 5: Google Ads basics.",
"content_ur":"ماڈیول 1: ڈیجیٹل مارکیٹنگ بنیادیات۔\nماڈیول 2: SEO۔\nماڈیول 3: سوشل میڈیا حکمت عملی۔\nماڈیول 4: مواد کی مارکیٹنگ۔\nماڈیول 5: گوگل اشتہارات۔",
"points":70
}'


add_course '{
"title_en":"Graphic Design Basics",
"title_ur":"گرافک ڈیزائن بنیادی کورس",
"description_en":"Learn professional graphic design concepts.",
"description_ur":"پروفیشنل گرافک ڈیزائن کے اصول سیکھیں۔",
"content_en":"Lesson 1: Design principles.\nLesson 2: Colors and typography.\nLesson 3: Logo design.\nLesson 4: Social media graphics.",
"content_ur":"سبق 1: ڈیزائن اصول۔\nسبق 2: رنگ اور فونٹس۔\nسبق 3: لوگو ڈیزائن۔\nسبق 4: سوشل میڈیا گرافکس۔",
"points":50
}'


add_course '{
"title_en":"Data Science Introduction",
"title_ur":"ڈیٹا سائنس کا تعارف",
"description_en":"Learn data analysis and basic data science.",
"description_ur":"ڈیٹا اینالیسس اور ڈیٹا سائنس کی بنیادی معلومات۔",
"content_en":"Lesson 1: Data concepts.\nLesson 2: Data collection.\nLesson 3: Data visualization.\nLesson 4: Basic analytics.",
"content_ur":"سبق 1: ڈیٹا تصورات۔\nسبق 2: ڈیٹا جمع کرنا۔\nسبق 3: ڈیٹا ویژولائزیشن۔\nسبق 4: بنیادی اینالیسس۔",
"points":65
}'


add_course '{
"title_en":"Cloud Computing Basics",
"title_ur":"کلاؤڈ کمپیوٹنگ بنیادیات",
"description_en":"Understand cloud services and online infrastructure.",
"description_ur":"کلاؤڈ سروسز اور آن لائن انفراسٹرکچر سمجھیں۔",
"content_en":"Lesson 1: Cloud concepts.\nLesson 2: Cloud storage.\nLesson 3: Cloud security.\nLesson 4: Cloud platforms.",
"content_ur":"سبق 1: کلاؤڈ تصورات۔\nسبق 2: کلاؤڈ اسٹوریج۔\nسبق 3: کلاؤڈ سیکیورٹی۔\nسبق 4: کلاؤڈ پلیٹ فارم۔",
"points":60
}'


add_course '{
"title_en":"Office Productivity Skills",
"title_ur":"آفس پروڈکٹیوٹی مہارتیں",
"description_en":"Learn Word, Excel and PowerPoint skills.",
"description_ur":"ورڈ، ایکسل اور پاورپوائنٹ کی مہارتیں سیکھیں۔",
"content_en":"Lesson 1: Documents.\nLesson 2: Spreadsheets.\nLesson 3: Presentations.\nLesson 4: Office automation.",
"content_ur":"سبق 1: ڈاکومنٹس۔\nسبق 2: اسپریڈ شیٹس۔\nسبق 3: پریزنٹیشنز۔\nسبق 4: آفس آٹومیشن۔",
"points":45
}'


add_course '{
"title_en":"E-Commerce Business",
"title_ur":"ای کامرس کاروبار",
"description_en":"Learn how to start and manage online stores.",
"description_ur":"آن لائن اسٹور شروع اور چلانا سیکھیں۔",
"content_en":"Lesson 1: E-commerce models.\nLesson 2: Product listing.\nLesson 3: Customer management.\nLesson 4: Online payments.",
"content_ur":"سبق 1: ای کامرس ماڈلز۔\nسبق 2: مصنوعات کی لسٹنگ۔\nسبق 3: کسٹمر مینجمنٹ۔\nسبق 4: آن لائن ادائیگیاں۔",
"points":60
}'


echo ""
echo "======================================"
echo " Courses Added Successfully"
echo "======================================"

echo "Checking courses..."
curl -s $URL

