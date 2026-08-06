create table if not exists referral_scores (

id uuid primary key default gen_random_uuid(),

referrer_id uuid references auth.users(id),

total_referrals integer default 0,

approved_referrals integer default 0,

active_businesses integer default 0,

score integer default 0,

updated_at timestamp default now()

);

alter table referral_scores enable row level security;

create policy "Referral owner can view score"
on referral_scores
for select
using (auth.uid() = referrer_id);
