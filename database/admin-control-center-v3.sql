
CREATE TABLE IF NOT EXISTS admin_actions (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

admin_id uuid,

action text,

target_type text,

target_id uuid,

details text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS approval_requests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

request_type text,

request_id uuid,

status text DEFAULT 'pending',

reviewed_by uuid,

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS revenue_analytics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

source text,

amount numeric DEFAULT 0,

period text,

created_at timestamp DEFAULT now()

);

