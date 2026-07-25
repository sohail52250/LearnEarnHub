
create table if not exists courses (

id bigint generated always as identity primary key,

title text not null,

description text,

category text,

level text default 'Beginner',

instructor text,

thumbnail text,

rating numeric default 0,

students integer default 0,

created_at timestamptz default now()

);



create table if not exists enrollments (

id bigint generated always as identity primary key,

course_id bigint references courses(id) on delete cascade,

user_id uuid references auth.users(id) on delete cascade,

progress integer default 0,

completed boolean default false,

created_at timestamptz default now()

);



alter table courses enable row level security;

alter table enrollments enable row level security;


create policy "courses public access"
on courses
for select
using(true);


create policy "student enrollment access"
on enrollments
for all
using(auth.uid()=user_id);


