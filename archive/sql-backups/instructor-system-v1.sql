
-- Instructor applications

create table if not exists instructor_applications (

id uuid primary key default gen_random_uuid(),

user_id uuid references auth.users(id) on delete cascade,

full_name text not null,

skills text,

experience text,

portfolio text,

certificate_url text,

category text,

status text default 'pending',

created_at timestamptz default now()

);



-- Approved instructors

create table if not exists instructors (

id uuid primary key default gen_random_uuid(),

user_id uuid references auth.users(id) on delete cascade,

full_name text,

title text,

bio text,

skills text,

category text,

verified boolean default false,

quality_score integer default 0,

courses_created integer default 0,

students_completed integer default 0,

created_at timestamptz default now()

);



-- Instructor rewards

create table if not exists instructor_rewards (

id uuid primary key default gen_random_uuid(),

instructor_id uuid references instructors(id),

course_id bigint,

completed_students integer default 0,

reward_units integer default 0,

created_at timestamptz default now()

);



-- Course ownership

alter table courses

add column if not exists instructor_id uuid;



-- Security

alter table instructor_applications enable row level security;

alter table instructors enable row level security;

alter table instructor_rewards enable row level security;



create policy "public verified instructors"

on instructors

for select

using(verified=true);



create policy "user submit application"

on instructor_applications

for insert

with check(auth.uid()=user_id);



