
CREATE TABLE IF NOT EXISTS instructors (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
bio text,
skills text,
verified boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS instructor_courses (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
instructor_id uuid REFERENCES instructors(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS course_reviews (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
admin_id uuid,
status text DEFAULT 'pending',
review_notes text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS admin_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
admin_id uuid,
action text,
details text,
created_at timestamp DEFAULT now()
);

