CREATE TABLE IF NOT EXISTS learning_progress (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    course_id BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    lesson_id BIGINT NOT NULL REFERENCES course_lessons(id) ON DELETE CASCADE,
    completed BOOLEAN DEFAULT false,
    completed_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, lesson_id)
);


CREATE TABLE IF NOT EXISTS course_completion (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    course_id BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    completed_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, course_id)
);


CREATE INDEX IF NOT EXISTS idx_learning_progress_user
ON learning_progress(user_id);


CREATE INDEX IF NOT EXISTS idx_learning_progress_course
ON learning_progress(course_id);


CREATE INDEX IF NOT EXISTS idx_course_completion_user
ON course_completion(user_id);
