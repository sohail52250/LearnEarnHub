
create table if not exists business_profiles (

id bigint generated always as identity primary key,

user_id uuid references auth.users(id) on delete cascade,

company_name text not null,

industry text,

description text,

website text,

logo_url text,

verified boolean default false,

created_at timestamptz default now()

);



create table if not exists business_opportunities (

id bigint generated always as identity primary key,

business_id bigint references business_profiles(id) on delete cascade,

title text not null,

description text,

skill_required text,

reward_units integer default 0,

status text default 'open',

created_at timestamptz default now()

);



create table if not exists job_applications (

id bigint generated always as identity primary key,

opportunity_id bigint references business_opportunities(id) on delete cascade,

learner_id uuid references auth.users(id) on delete cascade,

status text default 'pending',

created_at timestamptz default now()

);



alter table business_profiles enable row level security;

alter table business_opportunities enable row level security;

alter table job_applications enable row level security;



create policy "business profile access"
on business_profiles
for all
using(auth.uid() = user_id);



create policy "business opportunities public"
on business_opportunities
for select
using(true);



create policy "applications owner"
on job_applications
for all
using(auth.uid() = learner_id);


