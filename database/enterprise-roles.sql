
CREATE TABLE IF NOT EXISTS enterprise_roles(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

user_id uuid,

role text DEFAULT 'employee',

permissions text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_activity_logs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

user_id uuid,

action text,

created_at timestamp DEFAULT now()

);

