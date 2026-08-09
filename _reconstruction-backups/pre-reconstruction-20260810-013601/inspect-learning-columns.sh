#!/data/data/com.termux/files/usr/bin/bash

echo "Searching table definitions..."

grep -R "CREATE TABLE.*course_enrollments\|CREATE TABLE.*enrollments\|CREATE TABLE.*lesson_progress\|CREATE TABLE.*course_catalog\|CREATE TABLE.*lessons" database supabase \
--include="*.sql" | head -80

echo ""
echo "Finding column definitions..."

grep -R "course_id\|lesson_id\|user_id\|student_id\|enrollment_id" database supabase \
--include="*.sql" | head -120

echo "DONE"
