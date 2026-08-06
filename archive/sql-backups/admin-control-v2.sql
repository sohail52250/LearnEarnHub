
create table if not exists businesses (

id bigint generated always as identity primary key,

user_id uuid references auth.users(id) on delete cascade,

company_name text,

email text,

description text,

verified boolean default false,

created_at timestamptz default now()

);



create table if not exists platform_rewards (

id bigint generated always as identity primary key,

user_id uuid references auth.users(id) on delete cascade,

amount numeric default 0,

reason text,

created_at timestamptz default now()

);



create table if not exists security_logs (

id bigint generated always as identity primary key,

user_id uuid,

action text,

ip_address text,

created_at timestamptz default now()

);



create table if not exists admin_actions (

id bigint generated always as identity primary key,

admin_id uuid,

action text,

target_id uuid,

created_at timestamptz default now()

);



alter table businesses enable row level security;

alter table platform_rewards enable row level security;

alter table security_logs enable row level security;

alter table admin_actions enable row level security;



create policy "business public read"
on businesses
for select
using(true);



