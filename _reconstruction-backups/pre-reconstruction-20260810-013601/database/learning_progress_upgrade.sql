
CREATE TABLE IF NOT EXISTS lesson_progress (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
lesson_id uuid REFERENCES course_lessons(id) ON DELETE CASCADE,
completed boolean DEFAULT false,
score integer DEFAULT 0,
completed_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS certificates (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
certificate_code text UNIQUE,
issued_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS badges (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
badge_name text,
created_at timestamp DEFAULT now()
);

