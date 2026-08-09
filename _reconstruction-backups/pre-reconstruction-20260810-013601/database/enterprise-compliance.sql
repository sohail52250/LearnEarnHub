
CREATE TABLE IF NOT EXISTS enterprise_documents(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

document_name text,

document_type text,

document_url text,

verification_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_policies(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

policy_name text,

policy_content text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_audit_logs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

user_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

