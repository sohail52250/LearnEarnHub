#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/course-lessons"

COURSE_ID=$1


add(){

curl -s -X POST "$URL" \
-H "Content-Type: application/json" \
-d "$1"

echo ""

}


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Introduction",
"lesson_title_ur":"تعارف",
"lesson_content_en":"Course overview and learning objectives.",
"lesson_content_ur":"کورس کا تعارف اور مقاصد۔",
"lesson_order":1,
"points":5
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Basic Concepts",
"lesson_title_ur":"بنیادی تصورات",
"lesson_content_en":"Learn important concepts and terminology.",
"lesson_content_ur":"اہم تصورات اور اصطلاحات سیکھیں۔",
"lesson_order":2,
"points":10
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Practical Skills",
"lesson_title_ur":"عملی مہارتیں",
"lesson_content_en":"Practice real world examples and exercises.",
"lesson_content_ur":"حقیقی مثالوں اور مشقوں سے سیکھیں۔",
"lesson_order":3,
"points":15
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Project Work",
"lesson_title_ur":"پروجیکٹ ورک",
"lesson_content_en":"Build a practical project.",
"lesson_content_ur":"ایک عملی منصوبہ تیار کریں۔",
"lesson_order":4,
"points":20
}'


add '{
"course_id":"'$COURSE_ID'",
"lesson_title_en":"Final Assessment",
"lesson_title_ur":"حتمی جائزہ",
"lesson_content_en":"Complete assessment and earn certificate.",
"lesson_content_ur":"جائزہ مکمل کریں اور سرٹیفکیٹ حاصل کریں۔",
"lesson_order":5,
"points":25
}'

