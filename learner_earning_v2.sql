
create table task_matches (

id bigint generated always as identity primary key,

task_id bigint references earning_tasks(id) on delete cascade,

learner_id uuid,

match_score integer default 0,

ai_reason text,

created_at timestamptz default now()

);



create table task_progress (

id bigint generated always as identity primary key,

task_id bigint references earning_tasks(id) on delete cascade,

learner_id uuid,

progress_status text default 'started',

completion_note text,

updated_at timestamptz default now()

);



create table task_payments (

id bigint generated always as identity primary key,

task_id bigint references earning_tasks(id) on delete cascade,

learner_id uuid,

amount numeric,

currency text default 'PKR',

payment_status text default 'pending',

released_at timestamptz

);

