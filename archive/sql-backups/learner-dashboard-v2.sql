
create table if not exists learner_stats (

id bigint generated always as identity primary key,

user_id uuid references auth.users(id) on delete cascade,

level integer default 1,

xp integer default 0,

completed_courses integer default 0,

certificates integer default 0,

learning_hours integer default 0,

updated_at timestamptz default now()

);


create table if not exists learner_goals (

id bigint generated always as identity primary key,

user_id uuid references auth.users(id) on delete cascade,

goal text,

target_date date,

status text default 'active'

);


alter table learner_stats enable row level security;

alter table learner_goals enable row level security;


create policy "learner stats owner"
on learner_stats
for all
using(auth.uid()=user_id);


create policy "learner goals owner"
on learner_goals
for all
using(auth.uid()=user_id);


