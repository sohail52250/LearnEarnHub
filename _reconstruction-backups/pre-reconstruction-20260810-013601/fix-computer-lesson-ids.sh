#!/data/data/com.termux/files/usr/bin/bash

echo "Fixing Computer Fundamentals lesson IDs..."

declare -A lessons

lessons["what-is-computer.html"]=2792
lessons["computer-parts.html"]=2799
lessons["start-shutdown.html"]=2793
lessons["keyboard-mouse.html"]=2791
lessons["windows-basics.html"]=2798
lessons["files-folders.html"]=2797
lessons["internet-basics.html"]=2794
lessons["email-basics.html"]=2796
lessons["online-safety.html"]=2795

for file in public/lessons/computer-fundamentals/*.html
do

name=$(basename "$file")
id=${lessons[$name]}

if [ ! -z "$id" ]; then

sed -i "s/let lesson_id=.*/let lesson_id=$id;/" "$file"

echo "Fixed $name -> $id"

fi

done

git add .
git commit -m "Fix Computer Fundamentals lesson database IDs" || true
git push

echo "DONE"
