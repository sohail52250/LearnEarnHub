create table if not exists acquisition_requests (
 id uuid default gen_random_uuid() primary key,
 user_id uuid,
 company_name text,
 industry text,
 budget text,
 description text,
 status text default 'pending',
 access_granted boolean default false,
 created_at timestamp default now()
);

create table if not exists merger_requests (
 id uuid default gen_random_uuid() primary key,
 user_id uuid,
 company_name text,
 target_company text,
 proposal text,
 status text default 'pending',
 access_granted boolean default false,
 created_at timestamp default now()
);

create table if not exists partnership_requests (
 id uuid default gen_random_uuid() primary key,
 user_id uuid,
 company_name text,
 partnership_type text,
 proposal text,
 status text default 'pending',
 access_granted boolean default false,
 created_at timestamp default now()
);

create table if not exists deal_room_requests (
 id uuid default gen_random_uuid() primary key,
 user_id uuid,
 deal_type text,
 details text,
 admin_notes text,
 status text default 'pending',
 access_granted boolean default false,
 created_at timestamp default now()
);

alter table acquisition_requests enable row level security;
alter table merger_requests enable row level security;
alter table partnership_requests enable row level security;
alter table deal_room_requests enable row level security;
