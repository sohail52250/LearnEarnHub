

create table if not exists admin_permissions (

id uuid primary key default gen_random_uuid(),

user_id uuid not null,

permission text not null,

created_at timestamptz default now()

);



create table if not exists admin_activity_logs (

id uuid primary key default gen_random_uuid(),

admin_id uuid,

action text,

page text,

details text,

created_at timestamptz default now()

);



alter table admin_permissions enable row level security;

alter table admin_activity_logs enable row level security;



