#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub More Courses Installer"
echo "======================================"

add_course(){
echo "Adding: $1"

curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$2"

echo
echo "--------------------------------------"
}

add_course "Web Development Full Course" '{
"title_en":"Web Development Full Course",
"title_ur":"مکمل ویب ڈویلپمنٹ کورس",
"description_en":"Learn HTML CSS JavaScript and modern web development.",
"description_ur":"HTML CSS JavaScript اور جدید ویب ڈویلپمنٹ سیکھیں۔",
"content_en":"Module 1: Internet and websites.\nModule 2: HTML structure.\nModule 3: CSS styling.\nModule 4: JavaScript programming.\nModule 5: Responsive websites.\nModule 6: Deploying websites online.",
"content_ur":"ماڈیول 1: انٹرنیٹ اور ویب سائٹس۔\nماڈیول 2: HTML اسٹرکچر۔\nماڈیول 3: CSS ڈیزائن۔\nماڈیول 4: JavaScript پروگرامنگ۔\nماڈیول 5: ریسپانسیو ویب سائٹس۔\nماڈیول 6: ویب سائٹ آن لائن چلانا۔",
"points":80
}'

add_course "Graphic Design Professional" '{
"title_en":"Graphic Design Professional",
"title_ur":"پروفیشنل گرافک ڈیزائن",
"description_en":"Learn creative design skills for online earning.",
"description_ur":"آن لائن کمائی کے لئے تخلیقی ڈیزائن سیکھیں۔",
"content_en":"Lesson 1: Design principles.\nLesson 2: Colors and typography.\nLesson 3: Logo design.\nLesson 4: Social media graphics.\nLesson 5: Client projects.",
"content_ur":"سبق 1: ڈیزائن اصول۔\nسبق 2: رنگ اور فونٹس۔\nسبق 3: لوگو ڈیزائن۔\nسبق 4: سوشل میڈیا گرافکس۔\nسبق 5: کلائنٹ پراجیکٹس۔",
"points":60
}'

add_course "Digital Marketing Mastery" '{
"title_en":"Digital Marketing Mastery",
"title_ur":"ڈیجیٹل مارکیٹنگ ماسٹری",
"description_en":"Learn SEO social media and online marketing.",
"description_ur":"SEO سوشل میڈیا اور آن لائن مارکیٹنگ سیکھیں۔",
"content_en":"Module 1: Marketing basics.\nModule 2: SEO.\nModule 3: Social media marketing.\nModule 4: Content strategy.\nModule 5: Analytics.",
"content_ur":"ماڈیول 1: مارکیٹنگ بنیادیات۔\nماڈیول 2: SEO۔\nماڈیول 3: سوشل میڈیا مارکیٹنگ۔\nماڈیول 4: مواد کی حکمت عملی۔\nماڈیول 5: تجزیات۔",
"points":70
}'

add_course "Data Analysis With Excel" '{
"title_en":"Data Analysis With Excel",
"title_ur":"Excel کے ساتھ ڈیٹا تجزیہ",
"description_en":"Learn spreadsheets formulas charts and reports.",
"description_ur":"اسپریڈشیٹس فارمولے چارٹس اور رپورٹس سیکھیں۔",
"content_en":"Lesson 1: Excel interface.\nLesson 2: Formulas.\nLesson 3: Data cleaning.\nLesson 4: Charts.\nLesson 5: Business reports.",
"content_ur":"سبق 1: Excel انٹرفیس۔\nسبق 2: فارمولے۔\nسبق 3: ڈیٹا صفائی۔\nسبق 4: چارٹس۔\nسبق 5: کاروباری رپورٹس۔",
"points":55
}'

add_course "Cloud Computing Basics" '{
"title_en":"Cloud Computing Basics",
"title_ur":"کلاؤڈ کمپیوٹنگ بنیادی کورس",
"description_en":"Understand cloud services and online infrastructure.",
"description_ur":"کلاؤڈ سروسز اور آن لائن انفراسٹرکچر سمجھیں۔",
"content_en":"Lesson 1: Cloud concepts.\nLesson 2: Cloud platforms.\nLesson 3: Storage.\nLesson 4: Security.",
"content_ur":"سبق 1: کلاؤڈ تصورات۔\nسبق 2: کلاؤڈ پلیٹ فارم۔\nسبق 3: اسٹوریج۔\nسبق 4: سیکیورٹی۔",
"points":60
}'

add_course "Freelancing Complete Roadmap" '{
"title_en":"Freelancing Complete Roadmap",
"title_ur":"فری لانسنگ مکمل روڈ میپ",
"description_en":"Start your online earning journey step by step.",
"description_ur":"آن لائن کمائی کا سفر مرحلہ وار شروع کریں۔",
"content_en":"Step 1: Select skill.\nStep 2: Build portfolio.\nStep 3: Find clients.\nStep 4: Deliver projects.\nStep 5: Grow income.",
"content_ur":"مرحلہ 1: مہارت منتخب کریں۔\nمرحلہ 2: پورٹ فولیو بنائیں۔\nمرحلہ 3: کلائنٹس تلاش کریں۔\nمرحلہ 4: کام مکمل کریں۔\nمرحلہ 5: آمدنی بڑھائیں۔",
"points":75
}'

echo
echo "======================================"
echo " Courses Added Successfully"
echo "======================================"

curl -s "$URL"

