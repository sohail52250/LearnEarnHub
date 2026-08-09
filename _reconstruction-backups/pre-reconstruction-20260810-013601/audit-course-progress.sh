#!/data/data/com.termux/files/usr/bin/bash

echo "=== Checking Computer Fundamentals progress integration ==="

grep -R "course_enrollments\|enrollments\|lesson_progress\|course_id" public \
--include="*.js" \
| grep -E "176|course_id|lesson_progress|enroll" \
| head -80

echo ""
echo "=== Checking course page scripts ==="

grep -R "computer-fundamentals" public \
--include="*.js" \
--include="*.html" \
| head -50

echo ""
echo "DONE"
