create table if not exists business_referrals (

id uuid primary key default gen_random_uuid(),

business_name text,

business_category text,

contact_info text,

referrer_id uuid references auth.users(id),

status text default 'pending',

created_at timestamp default now()

);



alter table business_referrals enable row level security;



create policy "Referral owners view own leads"

on business_referrals

for select

using(
auth.uid()=referrer_id
);



create policy "Users create referrals"

on business_referrals

for insert

with check(
auth.uid()=referrer_id
);
