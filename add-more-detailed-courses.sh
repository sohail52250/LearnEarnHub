#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub Detailed Course Seeder"
echo "======================================"

add_course(){

curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"

echo ""
echo "Added course"
echo "--------------------------------------"

}


add_course '{
"title_en":"Web Development Master Course",
"title_ur":"ویب ڈویلپمنٹ ماسٹر کورس",
"description_en":"Complete web development training covering HTML, CSS, JavaScript, frontend and backend basics.",
"description_ur":"HTML، CSS، JavaScript، فرنٹ اینڈ اور بیک اینڈ کی مکمل تربیت۔",
"content_en":"Module 1: Internet and websites.\nModule 2: HTML page structure.\nModule 3: CSS design.\nModule 4: JavaScript programming.\nModule 5: APIs and backend concepts.\nModule 6: Build a complete website project.",
"content_ur":"ماڈیول 1: انٹرنیٹ اور ویب سائٹس۔\nماڈیول 2: HTML اسٹرکچر۔\nماڈیول 3: CSS ڈیزائن۔\nماڈیول 4: JavaScript پروگرامنگ۔\nماڈیول 5: APIs اور بیک اینڈ۔\nماڈیول 6: مکمل ویب سائٹ پروجیکٹ۔",
"points":100
}'


add_course '{
"title_en":"Digital Marketing Professional",
"title_ur":"ڈیجیٹل مارکیٹنگ پروفیشنل",
"description_en":"Learn SEO, social media marketing, advertising and online branding.",
"description_ur":"SEO، سوشل میڈیا مارکیٹنگ، اشتہارات اور آن لائن برانڈنگ سیکھیں۔",
"content_en":"Lesson 1: Digital marketing overview.\nLesson 2: SEO fundamentals.\nLesson 3: Social media strategy.\nLesson 4: Google advertising basics.\nLesson 5: Content marketing.\nLesson 6: Analytics and reporting.",
"content_ur":"سبق 1: ڈیجیٹل مارکیٹنگ تعارف۔\nسبق 2: SEO بنیادی معلومات۔\nسبق 3: سوشل میڈیا حکمت عملی۔\nسبق 4: گوگل اشتہارات۔\nسبق 5: مواد کی مارکیٹنگ۔\nسبق 6: تجزیہ اور رپورٹنگ۔",
"points":90
}'


add_course '{
"title_en":"Graphic Design Fundamentals",
"title_ur":"گرافک ڈیزائن بنیادی کورس",
"description_en":"Learn design principles, branding and creative tools.",
"description_ur":"ڈیزائن اصول، برانڈنگ اور تخلیقی ٹولز سیکھیں۔",
"content_en":"Lesson 1: Design principles.\nLesson 2: Colors and typography.\nLesson 3: Logo design.\nLesson 4: Social media graphics.\nLesson 5: Portfolio creation.",
"content_ur":"سبق 1: ڈیزائن اصول۔\nسبق 2: رنگ اور فونٹس۔\nسبق 3: لوگو ڈیزائن۔\nسبق 4: سوشل میڈیا گرافکس۔\nسبق 5: پورٹ فولیو۔",
"points":80
}'


add_course '{
"title_en":"Data Science Introduction",
"title_ur":"ڈیٹا سائنس کا تعارف",
"description_en":"Learn data analysis, statistics and visualization basics.",
"description_ur":"ڈیٹا اینالیسس، شماریات اور ویژولائزیشن سیکھیں۔",
"content_en":"Module 1: Data concepts.\nModule 2: Data cleaning.\nModule 3: Analysis methods.\nModule 4: Visualization.\nModule 5: Practical projects.",
"content_ur":"ماڈیول 1: ڈیٹا تصورات۔\nماڈیول 2: ڈیٹا صفائی۔\nماڈیول 3: تجزیہ طریقے۔\nماڈیول 4: ویژولائزیشن۔\nماڈیول 5: عملی منصوبے۔",
"points":100
}'


add_course '{
"title_en":"Cloud Computing Basics",
"title_ur":"کلاؤڈ کمپیوٹنگ بنیادی کورس",
"description_en":"Understand cloud services, storage and deployment.",
"description_ur":"کلاؤڈ سروسز، اسٹوریج اور ڈپلائمنٹ سیکھیں۔",
"content_en":"Lesson 1: Cloud concepts.\nLesson 2: Cloud storage.\nLesson 3: Virtual servers.\nLesson 4: Deployment basics.",
"content_ur":"سبق 1: کلاؤڈ تصورات۔\nسبق 2: کلاؤڈ اسٹوریج۔\nسبق 3: ورچوئل سرورز۔\nسبق 4: ڈپلائمنٹ۔",
"points":75
}'


add_course '{
"title_en":"E-Commerce Business",
"title_ur":"ای کامرس کاروبار",
"description_en":"Learn how to create and manage an online store.",
"description_ur":"آن لائن اسٹور بنانا اور چلانا سیکھیں۔",
"content_en":"Lesson 1: E-commerce models.\nLesson 2: Product listing.\nLesson 3: Customer management.\nLesson 4: Online payments.\nLesson 5: Marketing.",
"content_ur":"سبق 1: ای کامرس ماڈلز۔\nسبق 2: پروڈکٹ لسٹنگ۔\nسبق 3: کسٹمر مینجمنٹ۔\nسبق 4: آن لائن ادائیگی۔\nسبق 5: مارکیٹنگ۔",
"points":85
}'


add_course '{
"title_en":"Computer Networking",
"title_ur":"کمپیوٹر نیٹ ورکنگ",
"description_en":"Learn networking concepts and internet infrastructure.",
"description_ur":"نیٹ ورکنگ اور انٹرنیٹ انفراسٹرکچر سیکھیں۔",
"content_en":"Lesson 1: Network basics.\nLesson 2: IP addresses.\nLesson 3: Routers and switches.\nLesson 4: Network security.",
"content_ur":"سبق 1: نیٹ ورک بنیادیات۔\nسبق 2: IP ایڈریس۔\nسبق 3: روٹرز اور سوئچز۔\nسبق 4: نیٹ ورک سیکیورٹی۔",
"points":80
}'


add_course '{
"title_en":"Artificial Intelligence Career",
"title_ur":"مصنوعی ذہانت کیریئر کورس",
"description_en":"Learn AI concepts and career opportunities.",
"description_ur":"AI تصورات اور کیریئر مواقع سیکھیں۔",
"content_en":"Lesson 1: AI introduction.\nLesson 2: Machine learning basics.\nLesson 3: AI tools.\nLesson 4: AI career roadmap.",
"content_ur":"سبق 1: AI تعارف۔\nسبق 2: مشین لرننگ۔\nسبق 3: AI ٹولز۔\nسبق 4: AI کیریئر روڈ میپ۔",
"points":100
}'


echo "======================================"
echo "Courses Added Successfully"
echo "======================================"

