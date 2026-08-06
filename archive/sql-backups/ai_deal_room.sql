
create table if not exists ai_deal_requests(
id uuid default gen_random_uuid() primary key,
company text,
email text,
purpose text,
status text default 'pending',
approved boolean default false,
created_at timestamp default now()
);

