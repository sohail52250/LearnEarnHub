CREATE TABLE IF NOT EXISTS learning_progress (
id BIGSERIAL PRIMARY KEY,
user_id UUID NOT NULL,
course_id BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
lesson_id BIGINT NOT NULL REFERENCES course_lessons(id) ON DELETE CASCADE,
completed BOOLEAN DEFAULT false,
completed_at TIMESTAMP DEFAULT now(),
created_at TIMESTAMP DEFAULT now(),
UNIQUE(user_id,lesson_id)
);

CREATE INDEX IF NOT EXISTS idx_learning_progress_user
ON learning_progress(user_id);

CREATE INDEX IF NOT EXISTS idx_learning_progress_course
ON learning_progress(course_id);
