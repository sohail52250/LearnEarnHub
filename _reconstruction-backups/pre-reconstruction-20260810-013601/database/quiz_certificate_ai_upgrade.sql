
CREATE TABLE IF NOT EXISTS quizzes (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
question_en text,
question_ur text,
option_a text,
option_b text,
option_c text,
option_d text,
correct_answer text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS quiz_results (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
score integer DEFAULT 0,
passed boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_course_reviews (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
review_text text,
rating integer DEFAULT 5,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS certificates (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
certificate_code text UNIQUE,
certificate_title text,
issued_at timestamp DEFAULT now()
);

