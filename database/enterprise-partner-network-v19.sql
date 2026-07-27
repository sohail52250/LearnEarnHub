
CREATE TABLE IF NOT EXISTS enterprise_partners (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

partner_name text,

partner_type text,

industry text,

country text,

description text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS partnership_requests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

sender_org_id uuid,

receiver_org_id uuid,

request_type text,

message text,

status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS b2b_opportunities (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

title text,

category text,

description text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_network_activity (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

