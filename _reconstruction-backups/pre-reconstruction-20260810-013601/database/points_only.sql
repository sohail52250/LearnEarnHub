
CREATE TABLE IF NOT EXISTS user_points(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid UNIQUE,
points integer DEFAULT 0,
level integer DEFAULT 1,
updated_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS points_history(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
points integer,
reason text,
created_at timestamp DEFAULT now()
);


