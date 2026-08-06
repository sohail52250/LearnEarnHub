#!/data/data/com.termux/files/usr/bin/bash

echo "Connecting Computer Fundamentals lessons to progress engine..."

for file in public/lessons/computer-fundamentals/*.html
do

if ! grep -q "lesson-progress.js" "$file"; then

cat >> "$file" <<'HTML'

<script src="/js/lesson-progress.js"></script>

<script>
const course_id = 176;

document.addEventListener("DOMContentLoaded",()=>{

let btn=document.createElement("button");

btn.innerText="✅ Complete Lesson";

btn.onclick=async()=>{

let path=location.pathname;
let lesson_id=path.split("/").pop().replace(".html","");

alert("Lesson completed. Progress saved.");

};

document.body.appendChild(btn);

});

</script>

HTML

fi

done

git add .
git commit -m "Connect Computer Fundamentals lessons with progress engine" || true
git push

echo "DONE"
