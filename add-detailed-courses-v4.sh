#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

echo "======================================"
echo " LearnEarnHub Course Expansion V4"
echo "======================================"

add_course(){
curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"
echo
echo "Added"
echo "--------------------------------------"
}


add_course '{
"title_en":"SEO Complete Training",
"title_ur":"SEO مکمل تربیت",
"description_en":"Learn search engine optimization from beginner to advanced level.",
"description_ur":"سرچ انجن آپٹیمائزیشن بنیادی سے ایڈوانس لیول تک سیکھیں۔",
"content_en":"Module 1: SEO introduction.\nModule 2: Keyword research.\nModule 3: On page SEO.\nModule 4: Off page SEO.\nModule 5: Website ranking strategies.",
"content_ur":"ماڈیول 1: SEO کا تعارف۔\nماڈیول 2: کی ورڈ تحقیق۔\nماڈیول 3: آن پیج SEO۔\nماڈیول 4: آف پیج SEO۔\nماڈیول 5: ویب سائٹ رینکنگ حکمت عملی۔",
"points":80
}'


add_course '{
"title_en":"Content Writing Professional",
"title_ur":"پروفیشنل کانٹینٹ رائٹنگ",
"description_en":"Learn article writing, blogs and marketing content.",
"description_ur":"آرٹیکل، بلاگ اور مارکیٹنگ مواد لکھنا سیکھیں۔",
"content_en":"Lesson 1: Writing basics.\nLesson 2: Research skills.\nLesson 3: Blog structure.\nLesson 4: Copywriting.\nLesson 5: AI writing assistance.",
"content_ur":"سبق 1: لکھنے کی بنیادیات۔\nسبق 2: تحقیق کی مہارت۔\nسبق 3: بلاگ ساخت۔\nسبق 4: کاپی رائٹنگ۔\nسبق 5: AI تحریری مدد۔",
"points":70
}'


add_course '{
"title_en":"E-Commerce Store Management",
"title_ur":"ای کامرس اسٹور مینجمنٹ",
"description_en":"Learn building and managing online stores.",
"description_ur":"آن لائن اسٹور بنانا اور چلانا سیکھیں۔",
"content_en":"Module 1: Store setup.\nModule 2: Product management.\nModule 3: Customer support.\nModule 4: Marketing.\nModule 5: Sales growth.",
"content_ur":"ماڈیول 1: اسٹور سیٹ اپ۔\nماڈیول 2: پروڈکٹ مینجمنٹ۔\nماڈیول 3: کسٹمر سپورٹ۔\nماڈیول 4: مارکیٹنگ۔\nماڈیول 5: سیلز ترقی۔",
"points":85
}'


add_course '{
"title_en":"Linux Administration Basics",
"title_ur":"لینکس ایڈمنسٹریشن بنیادیات",
"description_en":"Learn Linux operating system and server management.",
"description_ur":"لینکس آپریٹنگ سسٹم اور سرور مینجمنٹ سیکھیں۔",
"content_en":"Module 1: Linux introduction.\nModule 2: Commands.\nModule 3: File management.\nModule 4: Users and permissions.\nModule 5: Server basics.",
"content_ur":"ماڈیول 1: لینکس تعارف۔\nماڈیول 2: کمانڈز۔\nماڈیول 3: فائل مینجمنٹ۔\nماڈیول 4: یوزرز اور اجازتیں۔\nماڈیول 5: سرور بنیادیات۔",
"points":90
}'


add_course '{
"title_en":"Network Fundamentals",
"title_ur":"نیٹ ورک بنیادی کورس",
"description_en":"Understand computer networks and internet communication.",
"description_ur":"کمپیوٹر نیٹ ورک اور انٹرنیٹ رابطہ کاری سمجھیں۔",
"content_en":"Module 1: Network concepts.\nModule 2: IP addresses.\nModule 3: Routers and switches.\nModule 4: Network security.",
"content_ur":"ماڈیول 1: نیٹ ورک تصورات۔\nماڈیول 2: IP ایڈریس۔\nماڈیول 3: روٹر اور سوئچ۔\nماڈیول 4: نیٹ ورک سیکیورٹی۔",
"points":75
}'


add_course '{
"title_en":"Virtual Assistant Skills",
"title_ur":"ورچوئل اسسٹنٹ مہارتیں",
"description_en":"Learn online assistant work and client management.",
"description_ur":"آن لائن اسسٹنٹ کام اور کلائنٹ مینجمنٹ سیکھیں۔",
"content_en":"Lesson 1: Assistant responsibilities.\nLesson 2: Email handling.\nLesson 3: Scheduling.\nLesson 4: Customer communication.",
"content_ur":"سبق 1: اسسٹنٹ ذمہ داریاں۔\nسبق 2: ای میل ہینڈلنگ۔\nسبق 3: شیڈولنگ۔\nسبق 4: کسٹمر رابطہ۔",
"points":60
}'


add_course '{
"title_en":"Microsoft Excel Advanced",
"title_ur":"مائیکروسافٹ ایکسل ایڈوانس",
"description_en":"Learn spreadsheets, formulas and data analysis.",
"description_ur":"اسپریڈ شیٹس، فارمولے اور ڈیٹا اینالیسس سیکھیں۔",
"content_en":"Module 1: Advanced formulas.\nModule 2: Charts.\nModule 3: Data filtering.\nModule 4: Reports and dashboards.",
"content_ur":"ماڈیول 1: ایڈوانس فارمولے۔\nماڈیول 2: چارٹس۔\nماڈیول 3: ڈیٹا فلٹرنگ۔\nماڈیول 4: رپورٹس اور ڈیش بورڈز۔",
"points":65
}'


add_course '{
"title_en":"Blockchain Technology",
"title_ur":"بلاک چین ٹیکنالوجی",
"description_en":"Understand blockchain concepts and applications.",
"description_ur":"بلاک چین کے تصورات اور استعمال سیکھیں۔",
"content_en":"Module 1: Blockchain basics.\nModule 2: Distributed systems.\nModule 3: Smart concepts.\nModule 4: Real world applications.",
"content_ur":"ماڈیول 1: بلاک چین بنیادیات۔\nماڈیول 2: تقسیم شدہ نظام۔\nماڈیول 3: اسمارٹ تصورات۔\nماڈیول 4: عملی استعمال۔",
"points":70
}'


add_course '{
"title_en":"Digital Forensics Basics",
"title_ur":"ڈیجیٹل فرانزکس بنیادیات",
"description_en":"Learn digital evidence and investigation concepts.",
"description_ur":"ڈیجیٹل شواہد اور تحقیقات کے اصول سیکھیں۔",
"content_en":"Module 1: Digital evidence.\nModule 2: Data recovery concepts.\nModule 3: Investigation process.\nModule 4: Reporting.",
"content_ur":"ماڈیول 1: ڈیجیٹل شواہد۔\nماڈیول 2: ڈیٹا ریکوری تصورات۔\nماڈیول 3: تحقیقاتی عمل۔\nماڈیول 4: رپورٹنگ۔",
"points":95
}'


echo "======================================"
echo "Course expansion complete"
echo "======================================"

