
CREATE TABLE IF NOT EXISTS learner_cv_profiles(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid UNIQUE,

full_name text,
headline text,
profile_photo text,

phone text,
email text,

city text,
country text,

bio text,

education text,
experience text,

technical_skills text,
soft_skills text,

projects text,

certifications text,

languages text,

career_goal text,

availability text,

linkedin text,
github text,
portfolio text,

created_at timestamp DEFAULT now(),
updated_at timestamp DEFAULT now()

);


