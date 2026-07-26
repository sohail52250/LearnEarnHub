
create table entity_verifications (

id bigint generated always as identity primary key,

user_id uuid,

entity_name text,

entity_type text,

platform_id text unique,

verification_status text default 'pending',

created_at timestamptz default now()

);



create table deal_rooms (

id bigint generated always as identity primary key,

party_one_id uuid,

party_two_id uuid,

status text default 'active',

fee_status text default 'pending',

created_at timestamptz default now()

);



create table deal_messages (

id bigint generated always as identity primary key,

room_id bigint,

sender_platform_id text,

message text,

ai_summary text,

created_at timestamptz default now()

);



create table meeting_requests (

id bigint generated always as identity primary key,

room_id bigint,

meeting_type text,

scheduled_time timestamptz,

consent_a boolean default false,

consent_b boolean default false,

created_at timestamptz default now()

);



create table deal_payments (

id bigint generated always as identity primary key,

room_id bigint,

payer_id uuid,

amount numeric,

currency text default 'PKR',

payment_status text default 'pending',

created_at timestamptz default now()

);

