
create table business_match_scores (

id bigint generated always as identity primary key,

deal_request_id bigint references business_deal_requests(id) on delete cascade,

user_id uuid,

match_score integer default 0,

ai_reason text,

created_at timestamptz default now()

);


create table business_verification_badges (

id bigint generated always as identity primary key,

entity_id uuid,

badge_type text,

status text default 'pending',

created_at timestamptz default now()

);

