create table if not exists opportunity_matches (

id uuid primary key default gen_random_uuid(),

need_id uuid references business_needs(id)
on delete cascade,

offer_id uuid references business_offers(id)
on delete cascade,

match_score integer default 0,

status text default 'matched',

created_at timestamp default now()

);


create index if not exists opportunity_match_score_index

on opportunity_matches(match_score);

