#!/data/data/com.termux/files/usr/bin/bash

TARGET=$(grep -Rl "course.title" public/*.js | head -1)

if [ -z "$TARGET" ]; then
  echo "No course JS file found"
  exit 1
fi

echo "Updating: $TARGET"

cp "$TARGET" "$TARGET.backup"

cat >> "$TARGET" <<'JS'

// LearnEarnHub multilingual helper
function getCourseTitle(course, lang="en") {
  return lang === "ur"
    ? (course.title_ur || course.title_en)
    : course.title_en;
}

function getCourseDescription(course, lang="en") {
  return lang === "ur"
    ? (course.description_ur || course.description_en)
    : course.description_en;
}

JS

echo "Multilingual helper added successfully"
echo "Backup created: $TARGET.backup"

