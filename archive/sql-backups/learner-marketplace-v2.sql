
create table if not exists course_enrollments (

id uuid primary key default gen_random_uuid(),

course_id uuid not null,

learner_id uuid not null,

progress integer default 0,

status text default 'enrolled',

enrolled_at timestamptz default now(),

completed_at timestamptz

);



create table if not exists course_categories (

id uuid primary key default gen_random_uuid(),

name text not null,

description text,

created_at timestamptz default now()

);



create table if not exists learner_course_history (

id uuid primary key default gen_random_uuid(),

learner_id uuid,

course_id uuid,

action text,

created_at timestamptz default now()

);



create index if not exists enrollment_user_idx

on course_enrollments(learner_id);



create index if not exists enrollment_course_idx

on course_enrollments(course_id);


