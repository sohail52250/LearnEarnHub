
create table if not exists admin_users (

id bigint generated always as identity primary key,

user_id uuid,

role text default 'admin',

permissions text,

status text default 'active',

created_at timestamptz default now()

);



create table if not exists admin_actions (

id bigint generated always as identity primary key,

admin_id uuid,

module text,

action text,

target_id bigint,

notes text,

created_at timestamptz default now()

);



create table if not exists ai_review_queue (

id bigint generated always as identity primary key,

item_type text,

item_id bigint,

ai_result text,

review_status text default 'pending',

reviewed_by uuid,

created_at timestamptz default now()

);



create table if not exists platform_reports (

id bigint generated always as identity primary key,

report_type text,

generated_by uuid,

report_data text,

created_at timestamptz default now()

);

