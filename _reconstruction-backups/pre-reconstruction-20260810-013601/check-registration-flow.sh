#!/data/data/com.termux/files/usr/bin/bash

echo "Checking registration and enrollment code..."

grep -R "registration_requests\|profiles\|course_enrollments\|enrollments\|lesson_progress" . \
--exclude-dir=node_modules \
--exclude-dir=.git \
--exclude="*.log" | head -120

echo "DONE"
