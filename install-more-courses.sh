#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/courses"

add(){

curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"

echo
echo "----------------------"

}


add '{
"title_en":"Web Development Complete Course",
"title_ur":"مکمل ویب ڈویلپمنٹ کورس",
"description_en":"Learn HTML CSS JavaScript and website development.",
"description_ur":"HTML CSS JavaScript اور ویب سائٹ بنانا سیکھیں۔",
"content_en":"Module 1: Internet and websites.\nModule 2: HTML structure.\nModule 3: CSS design.\nModule 4: JavaScript programming.\nModule 5: Responsive websites.\nModule 6: Deploying websites.",
"content_ur":"ماڈیول 1: انٹرنیٹ اور ویب سائٹس۔\nماڈیول 2: HTML اسٹرکچر۔\nماڈیول 3: CSS ڈیزائن۔\nماڈیول 4: JavaScript پروگرامنگ۔\nماڈیول 5: ریسپانسیو ویب سائٹس۔\nماڈیول 6: ویب سائٹ آن لائن کرنا۔",
"points":80
}'


add '{
"title_en":"Digital Marketing Masterclass",
"title_ur":"ڈیجیٹل مارکیٹنگ ماسٹر کلاس",
"description_en":"Learn SEO social media and online marketing.",
"description_ur":"SEO سوشل میڈیا اور آن لائن مارکیٹنگ سیکھیں۔",
"content_en":"Module 1: Digital marketing basics.\nModule 2: SEO.\nModule 3: Social media marketing.\nModule 4: Content strategy.\nModule 5: Analytics.",
"content_ur":"ماڈیول 1: ڈیجیٹل مارکیٹنگ بنیادیات۔\nماڈیول 2: SEO۔\nماڈیول 3: سوشل میڈیا مارکیٹنگ۔\nماڈیول 4: مواد کی حکمت عملی۔\nماڈیول 5: اینالیٹکس۔",
"points":70
}'


add '{
"title_en":"Graphic Design Basics",
"title_ur":"گرافک ڈیزائن بنیادی کورس",
"description_en":"Learn creative design principles.",
"description_ur":"تخلیقی ڈیزائن کے اصول سیکھیں۔",
"content_en":"Lesson 1: Design principles.\nLesson 2: Colors.\nLesson 3: Typography.\nLesson 4: Social media designs.",
"content_ur":"سبق 1: ڈیزائن اصول۔\nسبق 2: رنگوں کا استعمال۔\nسبق 3: تحریری انداز۔\nسبق 4: سوشل میڈیا ڈیزائن۔",
"points":50
}'


add '{
"title_en":"Cyber Security Professional",
"title_ur":"پروفیشنل سائبر سیکیورٹی",
"description_en":"Learn cybersecurity protection skills.",
"description_ur":"سائبر تحفظ کی پروفیشنل مہارتیں سیکھیں۔",
"content_en":"Module 1: Security concepts.\nModule 2: Password security.\nModule 3: Network safety.\nModule 4: Threat awareness.",
"content_ur":"ماڈیول 1: سیکیورٹی تصورات۔\nماڈیول 2: پاس ورڈ تحفظ۔\nماڈیول 3: نیٹ ورک حفاظت۔\nماڈیول 4: خطرات کی پہچان۔",
"points":75
}'


add '{
"title_en":"Freelancing Advanced",
"title_ur":"ایڈوانس فری لانسنگ",
"description_en":"Build a successful freelancing career.",
"description_ur":"کامیاب فری لانسنگ کیریئر بنائیں۔",
"content_en":"Lesson 1: Finding clients.\nLesson 2: Proposal writing.\nLesson 3: Portfolio building.\nLesson 4: Client management.\nLesson 5: Increasing income.",
"content_ur":"سبق 1: کلائنٹس تلاش کرنا۔\nسبق 2: پروپوزل لکھنا۔\nسبق 3: پورٹ فولیو بنانا۔\nسبق 4: کلائنٹ مینجمنٹ۔\nسبق 5: آمدنی بڑھانا۔",
"points":90
}'


echo "Courses installed"


curl -s "$URL"

