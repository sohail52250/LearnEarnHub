#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub Detailed Courses V6"
echo "======================================"

add_course(){
curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"
echo ""
echo "Added"
echo "----------------------------"
}


add_course '{
"title_en":"Digital Marketing Masterclass",
"title_ur":"ڈیجیٹل مارکیٹنگ ماسٹر کلاس",
"description_en":"Learn modern digital marketing strategies.",
"description_ur":"جدید ڈیجیٹل مارکیٹنگ کی حکمت عملی سیکھیں۔",
"content_en":"Module 1: Digital marketing basics.\nModule 2: SEO.\nModule 3: Social media marketing.\nModule 4: Google advertising.\nModule 5: Marketing analytics.",
"content_ur":"ماڈیول 1: ڈیجیٹل مارکیٹنگ بنیادیات۔\nماڈیول 2: SEO۔\nماڈیول 3: سوشل میڈیا مارکیٹنگ۔\nماڈیول 4: گوگل اشتہارات۔\nماڈیول 5: مارکیٹنگ اینالیٹکس۔",
"points":100
}'


add_course '{
"title_en":"Graphic Design Fundamentals",
"title_ur":"گرافک ڈیزائن بنیادی کورس",
"description_en":"Learn creative graphic design skills.",
"description_ur":"تخلیقی گرافک ڈیزائن مہارتیں سیکھیں۔",
"content_en":"Lesson 1: Design principles.\nLesson 2: Colors and typography.\nLesson 3: Logo design.\nLesson 4: Social media graphics.\nLesson 5: Portfolio creation.",
"content_ur":"سبق 1: ڈیزائن اصول۔\nسبق 2: رنگ اور ٹائپوگرافی۔\nسبق 3: لوگو ڈیزائن۔\nسبق 4: سوشل میڈیا گرافکس۔\nسبق 5: پورٹ فولیو بنانا۔",
"points":80
}'


add_course '{
"title_en":"WordPress Website Development",
"title_ur":"ورڈپریس ویب سائٹ ڈویلپمنٹ",
"description_en":"Create professional websites using WordPress.",
"description_ur":"ورڈپریس سے پروفیشنل ویب سائٹس بنانا سیکھیں۔",
"content_en":"Module 1: WordPress setup.\nModule 2: Themes.\nModule 3: Plugins.\nModule 4: Website security.\nModule 5: Publishing website.",
"content_ur":"ماڈیول 1: ورڈپریس انسٹالیشن۔\nماڈیول 2: تھیمز۔\nماڈیول 3: پلگ انز۔\nماڈیول 4: ویب سائٹ سیکیورٹی۔\nماڈیول 5: ویب سائٹ شائع کرنا۔",
"points":85
}'


add_course '{
"title_en":"Data Analysis with Excel",
"title_ur":"ایکسل سے ڈیٹا اینالیسس",
"description_en":"Learn data analysis using Microsoft Excel.",
"description_ur":"مائیکروسافٹ ایکسل سے ڈیٹا تجزیہ سیکھیں۔",
"content_en":"Lesson 1: Excel basics.\nLesson 2: Formulas.\nLesson 3: Charts.\nLesson 4: Pivot tables.\nLesson 5: Reports.",
"content_ur":"سبق 1: ایکسل بنیادیات۔\nسبق 2: فارمولے۔\nسبق 3: چارٹس۔\nسبق 4: پائیوٹ ٹیبلز۔\nسبق 5: رپورٹس۔",
"points":70
}'


add_course '{
"title_en":"Social Media Management",
"title_ur":"سوشل میڈیا مینجمنٹ",
"description_en":"Learn managing professional social media accounts.",
"description_ur":"پروفیشنل سوشل میڈیا اکاؤنٹس چلانا سیکھیں۔",
"content_en":"Module 1: Content planning.\nModule 2: Audience growth.\nModule 3: Analytics.\nModule 4: Brand management.",
"content_ur":"ماڈیول 1: مواد کی منصوبہ بندی۔\nماڈیول 2: صارفین میں اضافہ۔\nماڈیول 3: اینالیٹکس۔\nماڈیول 4: برانڈ مینجمنٹ۔",
"points":65
}'


add_course '{
"title_en":"E-Commerce Business",
"title_ur":"ای کامرس بزنس",
"description_en":"Learn how to start an online store.",
"description_ur":"آن لائن اسٹور شروع کرنا سیکھیں۔",
"content_en":"Module 1: E-commerce basics.\nModule 2: Product listing.\nModule 3: Customer management.\nModule 4: Online payments.\nModule 5: Store growth.",
"content_ur":"ماڈیول 1: ای کامرس بنیادیات۔\nماڈیول 2: مصنوعات لسٹنگ۔\nماڈیول 3: کسٹمر مینجمنٹ۔\nماڈیول 4: آن لائن ادائیگیاں۔\nماڈیول 5: اسٹور ترقی۔",
"points":90
}'


add_course '{
"title_en":"UI UX Design",
"title_ur":"UI UX ڈیزائن",
"description_en":"Learn user interface and experience design.",
"description_ur":"یوزر انٹرفیس اور تجربہ ڈیزائن سیکھیں۔",
"content_en":"Lesson 1: UX research.\nLesson 2: Wireframes.\nLesson 3: UI design.\nLesson 4: Prototypes.\nLesson 5: Testing.",
"content_ur":"سبق 1: UX تحقیق۔\nسبق 2: وائر فریم۔\nسبق 3: UI ڈیزائن۔\nسبق 4: پروٹو ٹائپس۔\nسبق 5: ٹیسٹنگ۔",
"points":95
}'


add_course '{
"title_en":"Linux Administration",
"title_ur":"لینکس ایڈمنسٹریشن",
"description_en":"Learn Linux operating system management.",
"description_ur":"لینکس آپریٹنگ سسٹم مینجمنٹ سیکھیں۔",
"content_en":"Module 1: Linux commands.\nModule 2: File systems.\nModule 3: User management.\nModule 4: Server basics.",
"content_ur":"ماڈیول 1: لینکس کمانڈز۔\nماڈیول 2: فائل سسٹم۔\nماڈیول 3: یوزر مینجمنٹ۔\nماڈیول 4: سرور بنیادیات۔",
"points":90
}'


add_course '{
"title_en":"Communication Skills",
"title_ur":"رابطہ کاری کی مہارتیں",
"description_en":"Improve professional communication.",
"description_ur":"پروفیشنل رابطہ کاری بہتر بنائیں۔",
"content_en":"Lesson 1: Speaking skills.\nLesson 2: Listening.\nLesson 3: Negotiation.\nLesson 4: Presentation skills.",
"content_ur":"سبق 1: بولنے کی مہارت۔\nسبق 2: سننے کی صلاحیت۔\nسبق 3: مذاکرات۔\nسبق 4: پریزنٹیشن مہارت۔",
"points":50
}'


add_course '{
"title_en":"Online Safety and Privacy",
"title_ur":"آن لائن سیفٹی اور پرائیویسی",
"description_en":"Learn protecting personal information online.",
"description_ur":"آن لائن ذاتی معلومات کا تحفظ سیکھیں۔",
"content_en":"Module 1: Internet risks.\nModule 2: Password security.\nModule 3: Privacy settings.\nModule 4: Safe browsing.",
"content_ur":"ماڈیول 1: انٹرنیٹ خطرات۔\nماڈیول 2: پاس ورڈ سیکیورٹی۔\nماڈیول 3: پرائیویسی سیٹنگز۔\nماڈیول 4: محفوظ براؤزنگ۔",
"points":60
}'


echo "======================================"
echo "Courses V6 Added"
echo "======================================"

