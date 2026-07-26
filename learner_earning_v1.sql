
create table earning_tasks (

id bigint generated always as identity primary key,

creator_id uuid,

title text,

description text,

required_skill text,

reward_amount numeric,

currency text default 'PKR',

status text default 'open',

created_at timestamptz default now()

);



create table task_applications (

id bigint generated always as identity primary key,

task_id bigint references earning_tasks(id) on delete cascade,

learner_id uuid,

application_message text,

status text default 'pending',

created_at timestamptz default now()

);



create table learner_earnings (

id bigint generated always as identity primary key,

learner_id uuid,

task_id bigint references earning_tasks(id) on delete cascade,

amount numeric,

currency text default 'PKR',

payment_status text default 'pending',

created_at timestamptz default now()

);

