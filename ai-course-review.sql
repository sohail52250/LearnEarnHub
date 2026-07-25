
create table if not exists ai_course_reviews (

id uuid primary key default gen_random_uuid(),

course_id uuid,

content_score integer default 0,

structure_score integer default 0,

skill_score integer default 0,

difficulty_score integer default 0,

overall_score integer default 0,

recommendation text,

ai_notes text,

created_at timestamptz default now()

);


