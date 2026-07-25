
create table if not exists admin_roles (

id uuid primary key default gen_random_uuid(),

user_id uuid not null,

admin_level text not null,

created_at timestamptz default now()

);



create table if not exists admin_permissions (

id uuid primary key default gen_random_uuid(),

admin_level text not null,

permission text not null

);



insert into admin_permissions
(admin_level,permission)

values

('super_admin','all'),

('course_reviewer','course_review'),

('business_moderator','business_verify'),

('support_admin','user_support')

on conflict do nothing;



