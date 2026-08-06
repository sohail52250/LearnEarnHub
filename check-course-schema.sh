#!/data/data/com.termux/files/usr/bin/bash

echo "Checking project database references..."

grep -R "course_catalog\|lesson_progress\|course_enrollments\|lessons" . \
--exclude-dir=node_modules \
--exclude-dir=.git \
| head -100

echo "Done"
