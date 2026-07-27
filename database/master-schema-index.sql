
CREATE TABLE IF NOT EXISTS schema_registry(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

module_name text,

table_name text,

version text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS security_audit_logs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

action text,

ip_address text,

details text,

created_at timestamp DEFAULT now()

);

