alter table partnership_requests
add column if not exists verified boolean default false;

alter table partnership_requests
add column if not exists company_description text;

alter table partnership_requests
add column if not exists logo_url text;

create table if not exists business_profiles (
id uuid default gen_random_uuid() primary key,
owner_id uuid references auth.users(id),
company_name text,
email text,
phone text,
website text,
description text,
verified boolean default false,
created_at timestamptz default now()
);

alter table business_profiles enable row level security;

create policy "Public view verified businesses"
on business_profiles
for select
to public
using (verified=true);

create policy "Authenticated business insert"
on business_profiles
for insert
to authenticated
with check (true);

