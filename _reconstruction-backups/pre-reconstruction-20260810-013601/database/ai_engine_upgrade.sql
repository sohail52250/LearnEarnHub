
CREATE TABLE IF NOT EXISTS ai_assistant_messages (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
message text,
response text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_recommendations (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
course_id uuid REFERENCES courses(id),
reason text,
score integer DEFAULT 0,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_moderation_reviews (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
content_type text,
content_id uuid,
review_status text DEFAULT 'pending',
ai_result text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS user_activity (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
activity text,
page text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS recommendation_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
action text,
details text,
created_at timestamp DEFAULT now()
);

