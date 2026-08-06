
create table if not exists course_reviews (

id uuid primary key default gen_random_uuid(),

course_id uuid,

instructor_id uuid,

status text default 'pending',

ai_score integer default 0,

review_notes text,

reviewed_by uuid,

created_at timestamptz default now(),

updated_at timestamptz default now()

);



create table if not exists course_review_logs (

id uuid primary key default gen_random_uuid(),

course_review_id uuid,

admin_id uuid,

action text,

notes text,

created_at timestamptz default now()

);



alter table course_reviews enable row level security;

alter table course_review_logs enable row level security;


