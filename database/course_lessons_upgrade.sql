CREATE TABLE IF NOT EXISTS course_lessons (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
lesson_title_en text NOT NULL,
lesson_title_ur text,
lesson_content_en text,
lesson_content_ur text,
video_url text,
lesson_order integer DEFAULT 1,
points integer DEFAULT 5,
created_at timestamp DEFAULT now()
);

ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;
