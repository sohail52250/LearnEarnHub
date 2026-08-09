
CREATE TABLE IF NOT EXISTS api_access_logs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

endpoint text,

method text,

status integer,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS login_security_events(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

event text,

ip_address text,

created_at timestamp DEFAULT now()

);

