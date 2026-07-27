#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app/api/lessons"

COURSE="9340f8f3-8d69-4881-8585-42f1af2f77c4"


curl -s -X POST $URL \
-H "Content-Type: application/json" \
-d "{
\"course_id\":\"$COURSE\",
\"title_en\":\"Introduction Lesson\",
\"title_ur\":\"تعارفی سبق\",
\"content_en\":\"Learn course basics, goals and practical skills.\",
\"content_ur\":\"کورس کے بنیادی اصول، مقاصد اور عملی مہارتیں سیکھیں۔\",
\"lesson_order\":1,
\"points\":10
}"


curl -s -X POST $URL \
-H "Content-Type: application/json" \
-d "{
\"course_id\":\"$COURSE\",
\"title_en\":\"Practical Exercise\",
\"title_ur\":\"عملی مشق\",
\"content_en\":\"Complete exercises and build your skills.\",
\"content_ur\":\"مشقیں مکمل کریں اور اپنی مہارت بہتر کریں۔\",
\"lesson_order\":2,
\"points\":20
}"

echo
echo "Lessons added"
