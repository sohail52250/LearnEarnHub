
create table if not exists admin_logs (

id bigint generated always as identity primary key,

admin_id uuid,

action text,

details text,

created_at timestamptz default now()

);

