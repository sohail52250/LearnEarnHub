#!/data/data/com.termux/files/usr/bin/bash

INPUT="clean-course-titles.txt"
OUTPUT="courses_final_import.sql"

echo "INSERT INTO courses (title,title_en,title_ur,description,description_en,description_ur,category,language_group) VALUES" > "$OUTPUT"

FIRST=1

while IFS= read -r line
do
TITLE=$(echo "$line" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]*//')

[ -z "$TITLE" ] && continue

ESC=$(echo "$TITLE" | sed "s/'/''/g")

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g;s/^-|-$//g')

if [ $FIRST -eq 0 ]; then
echo "," >> "$OUTPUT"
fi

FIRST=0

cat >> "$OUTPUT" <<SQL
(
'$ESC',
'$ESC',
'',
'Learn $ESC skills.',
'Learn $ESC skills.',
'',
'General Skills',
'$SLUG'
)
SQL

done < "$INPUT"

echo ";" >> "$OUTPUT"

echo "Final SQL generated"
