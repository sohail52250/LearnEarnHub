create table if not exists contact_requests (

id uuid primary key default gen_random_uuid(),

learner_id uuid references auth.users(id),

business_id uuid references auth.users(id),

status text default 'pending',

created_at timestamp default now()

);



alter table contact_requests enable row level security;



create policy "Users manage own requests"

on contact_requests

for all

using(

auth.uid()=learner_id

or

auth.uid()=business_id

);
