#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub SQL Preparation ==="

mkdir -p database

cat > database/learning-system-final.sql <<'SQL'
CREATE TABLE IF NOT EXISTS learning_progress (
 id BIGSERIAL PRIMARY KEY,
 user_id UUID NOT NULL,
 course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,
 lesson_id BIGINT REFERENCES course_lessons(id) ON DELETE CASCADE,
 completed BOOLEAN DEFAULT false,
 completed_at TIMESTAMP DEFAULT NULL,
 created_at TIMESTAMP DEFAULT NOW(),
 UNIQUE(user_id,lesson_id)
);

CREATE TABLE IF NOT EXISTS course_completion (
 id BIGSERIAL PRIMARY KEY,
 user_id UUID NOT NULL,
 course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,
 completed_at TIMESTAMP DEFAULT NOW(),
 UNIQUE(user_id,course_id)
);

CREATE INDEX IF NOT EXISTS learning_progress_user_idx
ON learning_progress(user_id);

CREATE INDEX IF NOT EXISTS learning_progress_course_idx
ON learning_progress(course_id);
SQL

echo ""
echo "✅ SQL file created:"
echo "database/learning-system-final.sql"

echo ""
echo "Copy this SQL and run it in:"
echo "Supabase Dashboard → SQL Editor → New Query"

cat database/learning-system-final.sql

