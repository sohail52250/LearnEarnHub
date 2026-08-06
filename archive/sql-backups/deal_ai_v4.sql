
create table deal_ai_summaries (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

summary text,

created_at timestamptz default now()

);



create table deal_proposals (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

proposal text,

status text default 'pending',

created_at timestamptz default now()

);



create table deal_agreements (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

agreement_type text,

status text default 'draft',

created_at timestamptz default now()

);

