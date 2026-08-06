
create table if not exists course_submissions (

id uuid primary key default gen_random_uuid(),

course_id uuid not null,

instructor_id uuid not null,

status text default 'draft',

submitted_at timestamptz,

approved_at timestamptz,

approved_by uuid,

rejection_reason text,

created_at timestamptz default now()

);



create table if not exists course_publish_logs (

id uuid primary key default gen_random_uuid(),

course_id uuid,

action text,

performed_by uuid,

notes text,

created_at timestamptz default now()

);



create index if not exists course_submission_status_idx

on course_submissions(status);


