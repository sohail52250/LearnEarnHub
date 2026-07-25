
create table if not exists instructor_feedback (

id uuid primary key default gen_random_uuid(),

course_id uuid,

instructor_id uuid,

quality_score integer default 0,

feedback_type text,

feedback_message text,

status text default 'pending',

created_at timestamptz default now()

);



create table if not exists instructor_improvements (

id uuid primary key default gen_random_uuid(),

course_id uuid,

instructor_id uuid,

improvement text,

completed boolean default false,

created_at timestamptz default now()

);


