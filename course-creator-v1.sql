
create table if not exists instructor_courses (

id uuid primary key default gen_random_uuid(),

instructor_id uuid references instructors(id),

title text not null,

description text,

category text,

level text default 'Beginner',

status text default 'draft',

created_at timestamptz default now()

);



create table if not exists course_lessons (

id uuid primary key default gen_random_uuid(),

course_id uuid references instructor_courses(id)
on delete cascade,

title text,

content text,

video_url text,

lesson_order integer default 1,

created_at timestamptz default now()

);



create table if not exists course_quizzes (

id uuid primary key default gen_random_uuid(),

course_id uuid references instructor_courses(id)
on delete cascade,

question text,

option_a text,

option_b text,

option_c text,

correct_answer text,

created_at timestamptz default now()

);



create table if not exists instructor_activity_log (

id uuid primary key default gen_random_uuid(),

instructor_id uuid references instructors(id),

action text,

created_at timestamptz default now()

);



alter table instructor_courses enable row level security;

alter table course_lessons enable row level security;

alter table course_quizzes enable row level security;



create policy "view approved courses"

on instructor_courses

for select

using(status='published');



