#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Learning System Setup ==="

mkdir -p database services

cat > database/learning-system.sql <<'SQL'
CREATE TABLE IF NOT EXISTS learning_progress (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    course_id BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    lesson_id BIGINT NOT NULL REFERENCES course_lessons(id) ON DELETE CASCADE,
    completed BOOLEAN DEFAULT false,
    completed_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, lesson_id)
);

CREATE TABLE IF NOT EXISTS course_completion (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    course_id BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    completed_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, course_id)
);

CREATE INDEX IF NOT EXISTS learning_progress_user_idx
ON learning_progress(user_id);

CREATE INDEX IF NOT EXISTS learning_progress_course_idx
ON learning_progress(course_id);
SQL


cat > services/progress-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);


async function getProgress(user_id,course_id){

const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course_id);


const {count:done}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true);


return {
course_id,
total_lessons:total||0,
completed_lessons:done||0,
percentage: total ? Math.round((done/total)*100):0
};

}


module.exports={getProgress};
JS


echo "Files created:"
echo "database/learning-system.sql"
echo "services/progress-service.js"

echo ""
echo "Now run SQL in Supabase SQL Editor:"
echo "database/learning-system.sql"

