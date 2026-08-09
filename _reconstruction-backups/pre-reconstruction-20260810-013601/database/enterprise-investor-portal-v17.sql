
CREATE TABLE IF NOT EXISTS investor_organizations (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

name text,

industry text,

country text,

description text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS organization_members (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

user_id uuid,

role text DEFAULT 'member',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_deal_rooms (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

deal_id uuid,

access_level text DEFAULT 'private',

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

report_type text,

report_data text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_activity_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

user_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

