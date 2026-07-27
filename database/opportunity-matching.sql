
CREATE TABLE IF NOT EXISTS opportunity_matches(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,
opportunity_id uuid,

match_score integer DEFAULT 0,

status text DEFAULT 'recommended',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS opportunity_applications(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,
opportunity_id uuid,

message text,

status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);

