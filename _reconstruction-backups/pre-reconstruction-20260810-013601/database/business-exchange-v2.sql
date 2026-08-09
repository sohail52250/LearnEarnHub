
CREATE TABLE IF NOT EXISTS business_deals (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

owner_id uuid,

deal_type text,

title text,

description text,

value numeric DEFAULT 0,

status text DEFAULT 'draft',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_messages (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

sender_id uuid,

message text,

created_at timestamp DEFAULT now()

);

