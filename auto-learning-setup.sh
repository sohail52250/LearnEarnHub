#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Learning System Auto Setup ==="

if ! grep -q "SUPABASE_SERVICE_KEY=" .env; then
 echo "❌ Missing SUPABASE_SERVICE_KEY"
 exit 1
fi

KEY=$(grep SUPABASE_SERVICE_KEY .env | cut -d '=' -f2)

if [ "$KEY" = "YOUR_SERVICE_ROLE_KEY" ]; then
 echo "❌ Replace SERVICE_ROLE_KEY first"
 exit 1
fi

echo "✅ Service key found"

mkdir -p database

cat > database/learning-system.sql <<'SQL'

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

echo "✅ SQL created:"
echo "database/learning-system.sql"

echo ""
echo "Database execution requires PostgreSQL connection."
echo "Add DATABASE_URL to .env"
echo "Then run:"
echo "node create-learning-tables-pg.js"

