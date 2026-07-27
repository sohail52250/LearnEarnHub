#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

add_course(){
echo "Adding: $1"
curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$2"
echo
echo "------------------------------"
}

add_course "Web Development Full Course" '{
"title_en":"Web Development Full Course",
"title_ur":"مکمل ویب ڈویلپمنٹ کورس",
"description_en":"Learn HTML, CSS, JavaScript, frontend and backend development with practical projects.",
"description_ur":"HTML، CSS، JavaScript، فرنٹ اینڈ اور بیک اینڈ ڈویلپمنٹ عملی منصوبوں کے ساتھ سیکھیں۔",
"content_en":"Module 1: Internet and Web Basics.\nModule 2: HTML structure and semantic pages.\nModule 3: CSS styling and responsive design.\nModule 4: JavaScript programming.\nModule 5: APIs and backend basics.\nModule 6: Database connection.\nModule 7: Build a complete website project.",
"content_ur":"ماڈیول 1: انٹرنیٹ اور ویب کی بنیادی معلومات۔\nماڈیول 2: HTML صفحات بنانا۔\nماڈیول 3: CSS ڈیزائن اور ریسپانسیو ویب۔\nماڈیول 4: JavaScript پروگرامنگ۔\nماڈیول 5: API اور بیک اینڈ۔\nماڈیول 6: ڈیٹا بیس کنکشن۔\nماڈیول 7: مکمل ویب سائٹ منصوبہ۔",
"points":100
}'


add_course "Digital Marketing Professional" '{
"title_en":"Digital Marketing Professional",
"title_ur":"ڈیجیٹل مارکیٹنگ پروفیشنل کورس",
"description_en":"Learn SEO, social media marketing, advertising and online business growth.",
"description_ur":"SEO، سوشل میڈیا مارکیٹنگ، اشتہارات اور آن لائن کاروباری ترقی سیکھیں۔",
"content_en":"Module 1: Digital marketing overview.\nModule 2: SEO fundamentals.\nModule 3: Social media strategy.\nModule 4: Google advertising basics.\nModule 5: Content marketing.\nModule 6: Analytics and reporting.",
"content_ur":"ماڈیول 1: ڈیجیٹل مارکیٹنگ کا تعارف۔\nماڈیول 2: SEO بنیادی اصول۔\nماڈیول 3: سوشل میڈیا حکمت عملی۔\nماڈیول 4: گوگل اشتہارات۔\nماڈیول 5: مواد کی مارکیٹنگ۔\nماڈیول 6: تجزیہ اور رپورٹنگ۔",
"points":90
}'


add_course "Graphic Design Complete Course" '{
"title_en":"Graphic Design Complete Course",
"title_ur":"مکمل گرافک ڈیزائن کورس",
"description_en":"Learn design principles, branding, posters and professional graphics.",
"description_ur":"ڈیزائن اصول، برانڈنگ، پوسٹرز اور پروفیشنل گرافکس سیکھیں۔",
"content_en":"Module 1: Design principles.\nModule 2: Colors and typography.\nModule 3: Logo design.\nModule 4: Social media graphics.\nModule 5: Portfolio creation.",
"content_ur":"ماڈیول 1: ڈیزائن اصول۔\nماڈیول 2: رنگ اور فونٹس۔\nماڈیول 3: لوگو ڈیزائن۔\nماڈیول 4: سوشل میڈیا گرافکس۔\nماڈیول 5: پورٹ فولیو بنانا۔",
"points":80
}'


add_course "Freelancing Masterclass" '{
"title_en":"Freelancing Masterclass",
"title_ur":"فری لانسنگ ماسٹر کلاس",
"description_en":"Learn freelancing platforms, client management and earning strategies.",
"description_ur":"فری لانس پلیٹ فارمز، کلائنٹ مینجمنٹ اور کمائی کی حکمت عملی سیکھیں۔",
"content_en":"Module 1: Freelancing introduction.\nModule 2: Profile creation.\nModule 3: Finding clients.\nModule 4: Writing proposals.\nModule 5: Managing payments.\nModule 6: Building long term career.",
"content_ur":"ماڈیول 1: فری لانسنگ تعارف۔\nماڈیول 2: پروفائل بنانا۔\nماڈیول 3: کلائنٹس تلاش کرنا۔\nماڈیول 4: پروپوزل لکھنا۔\nماڈیول 5: ادائیگی کا انتظام۔\nماڈیول 6: مستقل کیریئر بنانا۔",
"points":100
}'


add_course "Data Science Fundamentals" '{
"title_en":"Data Science Fundamentals",
"title_ur":"ڈیٹا سائنس بنیادی کورس",
"description_en":"Learn data analysis, Python, statistics and visualization.",
"description_ur":"ڈیٹا اینالیسس، پائتھن، شماریات اور ویژولائزیشن سیکھیں۔",
"content_en":"Module 1: Data science introduction.\nModule 2: Data collection.\nModule 3: Python for data.\nModule 4: Data visualization.\nModule 5: Machine learning introduction.",
"content_ur":"ماڈیول 1: ڈیٹا سائنس تعارف۔\nماڈیول 2: ڈیٹا جمع کرنا۔\nماڈیول 3: ڈیٹا کے لئے پائتھن۔\nماڈیول 4: ڈیٹا ویژولائزیشن۔\nماڈیول 5: مشین لرننگ تعارف۔",
"points":120
}'


echo "ALL COURSES ADDED"
