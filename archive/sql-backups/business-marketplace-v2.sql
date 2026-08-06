
create table if not exists job_opportunities (

id bigint generated always as identity primary key,

business_id bigint references businesses(id) on delete cascade,

title text not null,

description text,

skill_required text,

status text default 'open',

created_at timestamptz default now()

);



create table if not exists job_applications (

id bigint generated always as identity primary key,

job_id bigint references job_opportunities(id) on delete cascade,

learner_id uuid references auth.users(id) on delete cascade,

status text default 'pending',

created_at timestamptz default now()

);



create table if not exists business_analytics (

id bigint generated always as identity primary key,

business_id bigint,

profile_views integer default 0,

applications_received integer default 0,

successful_hires integer default 0,

updated_at timestamptz default now()

);



alter table job_opportunities enable row level security;

alter table job_applications enable row level security;

alter table business_analytics enable row level security;



create policy "public jobs view"
on job_opportunities
for select
using(true);



create policy "learner apply jobs"
on job_applications
for insert
with check(auth.uid()=learner_id);



