create table if not exists skill_verifications (

id uuid primary key default gen_random_uuid(),

learner_id uuid references auth.users(id),

business_id uuid references auth.users(id),

status text default 'requested',

created_at timestamp default now()

);


alter table skill_verifications enable row level security;


create policy "Users view own verification requests"

on skill_verifications

for select

using(
auth.uid()=learner_id
or
auth.uid()=business_id
);
