
CREATE TABLE IF NOT EXISTS learner_profiles(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid UNIQUE,
bio text,
skills text,
education text,
experience text,
city text,
country text,
level integer DEFAULT 1,
created_at timestamp DEFAULT now(),
updated_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS learner_badges(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
badge_name text,
description text,
created_at timestamp DEFAULT now()
);


