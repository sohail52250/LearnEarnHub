
CREATE TABLE IF NOT EXISTS enterprise_employees (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

name text,

email text,

department text,

role text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS workflow_automation (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

workflow_name text,

trigger_event text,

action text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS crm_customers (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

customer_name text,

email text,

phone text,

customer_type text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS customer_analytics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

customer_id uuid,

activity text,

value_score integer DEFAULT 0,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS business_process_intelligence (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

process_name text,

efficiency_score integer DEFAULT 0,

ai_recommendation text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS digital_transformation_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

