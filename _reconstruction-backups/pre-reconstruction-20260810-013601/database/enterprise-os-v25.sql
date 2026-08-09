
CREATE TABLE IF NOT EXISTS enterprise_hr_employees (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

employee_name text,

department text,

position text,

salary numeric DEFAULT 0,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_accounting (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

transaction_type text,

amount numeric DEFAULT 0,

category text,

description text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_projects (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

project_name text,

manager_id uuid,

status text DEFAULT 'planning',

progress integer DEFAULT 0,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_documents (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

document_name text,

document_type text,

document_url text,

access_level text DEFAULT 'private',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_security_events (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

event_type text,

severity text,

details text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_os_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

