#!/data/data/com.termux/files/usr/bin/bash

INPUT="clean-course-titles.txt"
OUTPUT="courses_multilingual_import.sql"

echo "INSERT INTO courses (title,title_en,title_ur,description,description_en,description_ur,category,language_group) VALUES" > "$OUTPUT"

FIRST=1

while IFS= read -r line
do
    TITLE=$(echo "$line" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]*//')

    if [ -n "$TITLE" ]; then

        ESCAPED=$(echo "$TITLE" | sed "s/'/''/g")

        if [ $FIRST -eq 0 ]; then
            echo "," >> "$OUTPUT"
        fi

        FIRST=0

        SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g;s/^-|-$//g')

        cat >> "$OUTPUT" <<SQL
(
'$ESCAPED',
'$ESCAPED',
'',
'Learn $ESCAPED skills.',
'Learn $ESCAPED skills.',
'',
'General Skills',
'$SLUG'
)
SQL

    fi

done < "$INPUT"

echo ";" >> "$OUTPUT"

echo "Clean SQL generated"
