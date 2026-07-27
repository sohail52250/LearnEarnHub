
CREATE TABLE IF NOT EXISTS business_profiles (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
business_name text,
category text,
description text,
phone text,
city text,
verified boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_verification_requests (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
documents text,
status text DEFAULT 'pending',
admin_notes text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS learner_skills (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
skill_name text,
level text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_matches (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
learner_id uuid,
match_score integer DEFAULT 0,
reason text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_dashboard_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
action text,
details text,
created_at timestamp DEFAULT now()
);

