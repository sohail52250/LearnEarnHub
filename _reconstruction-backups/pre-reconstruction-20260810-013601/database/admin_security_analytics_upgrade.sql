
CREATE TABLE IF NOT EXISTS admin_roles (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
role_name text DEFAULT 'admin',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS admin_permissions (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
role_id uuid REFERENCES admin_roles(id),
permission_name text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS admin_activity_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
admin_id uuid,
action text,
target text,
details text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS security_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
event_type text,
ip_address text,
details text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS platform_analytics (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
metric_name text,
metric_value integer DEFAULT 0,
created_at timestamp DEFAULT now()
);

