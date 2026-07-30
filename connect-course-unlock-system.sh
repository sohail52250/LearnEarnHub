#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Course Unlock Integration ==="

FILE="public/course-complete.js"

if [ ! -f "$FILE" ]; then
    echo "❌ $FILE not found"
    exit 1
fi


# Create unlock engine if missing

if [ ! -f "public/course-unlock-engine.js" ]; then

cat > public/course-unlock-engine.js <<'JS'
async function unlockNextCourse(userId, completedCourseId){

try{

const response = await fetch(
"/api/course/unlock-next",
{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({
user_id:userId,
completed_course_id:completedCourseId
})
}
);

return await response.json();

}
catch(error){

console.error(
"Course unlock error:",
error
);

}

}
JS

echo "✅ Created course-unlock-engine.js"

else

echo "✅ Unlock engine already exists"

fi



# Add script reference if HTML contains course complete page

for page in public/*.html
do

if grep -q "course-complete.js" "$page"; then

if ! grep -q "course-unlock-engine.js" "$page"; then

sed -i 's#</body>#<script src="/course-unlock-engine.js"></script>\n</body>#' "$page"

echo "✅ Added unlock engine to $page"

fi

fi

done



# Add unlock call after completion message

if ! grep -q "unlockNextCourse" "$FILE"; then

cat >> "$FILE" <<'JS'


// Learning Path Unlock Hook
if(typeof unlockNextCourse === "function"){

unlockNextCourse(
localStorage.getItem("user_id"),
courseId
);

}

JS

echo "✅ Connected unlock trigger"

else

echo "✅ Unlock trigger already connected"

fi


echo
echo "=== Verification ==="

grep -Rni "unlockNextCourse\|course-unlock-engine" public | head -20


echo
echo "=== Complete ==="

