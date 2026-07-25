
create table if not exists admin_activity_logs (

id uuid primary key default gen_random_uuid(),

admin_id uuid,

action text,

details text,

created_at timestamptz default now()

);



create table if not exists admin_permissions (

id uuid primary key default gen_random_uuid(),

user_id uuid,

permission text,

created_at timestamptz default now()

);


