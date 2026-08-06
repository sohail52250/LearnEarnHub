
CREATE TABLE IF NOT EXISTS course_lessons (
id BIGSERIAL PRIMARY KEY,
course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
title_en TEXT NOT NULL,
title_ur TEXT NOT NULL,
content_en TEXT,
content_ur TEXT,
lesson_order INTEGER DEFAULT 1,
points INTEGER DEFAULT 10,
created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read lessons"
ON course_lessons
FOR SELECT
USING (true);

