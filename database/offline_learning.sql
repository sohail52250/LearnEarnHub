
CREATE TABLE IF NOT EXISTS notifications(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
title text,
message text,
read boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS offline_learning(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
course_id uuid,
downloaded boolean DEFAULT false,
last_sync timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS mobile_devices(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
device_token text,
platform text,
created_at timestamp DEFAULT now()
);


