create table if not exists business_needs (

id uuid primary key default gen_random_uuid(),

business_id uuid references business_profiles(id)
on delete cascade,

need_title text,

category text,

quantity text,

budget text,

location text,

status text default 'open',

created_at timestamp default now()

);


create index if not exists business_needs_category_index

on business_needs(category);


create index if not exists business_needs_status_index

on business_needs(status);

