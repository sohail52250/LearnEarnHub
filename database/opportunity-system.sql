
create table if not exists business_profiles (

id uuid default gen_random_uuid() primary key,

user_id uuid references auth.users(id),

company_name text,

description text,

website text,

verified boolean default false,

created_at timestamp default now()

);


create table if not exists jobs (

id uuid default gen_random_uuid() primary key,

business_id uuid references business_profiles(id),

title text,

description text,

skills_required text,

location text,

type text,

status text default 'active',

created_at timestamp default now()

);


create table if not exists applications (

id uuid default gen_random_uuid() primary key,

job_id uuid references jobs(id),

student_id uuid references auth.users(id),

message text,

status text default 'pending',

created_at timestamp default now()

);

