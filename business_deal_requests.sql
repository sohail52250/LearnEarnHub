
create table business_deal_requests (

id bigint generated always as identity primary key,

owner_id uuid,

request_type text,

company_name text,

industry text,

description text,

requirements text,

expected_value numeric,

visibility text default 'private',

status text default 'pending',

created_at timestamptz default now()

);



create table business_interest_requests (

id bigint generated always as identity primary key,

deal_request_id bigint references business_deal_requests(id) on delete cascade,

interested_party_id uuid,

message text,

status text default 'pending',

created_at timestamptz default now()

);



create table business_anonymous_rooms (

id bigint generated always as identity primary key,

deal_request_id bigint references business_deal_requests(id) on delete cascade,

party_one_id uuid,

party_two_id uuid,

platform_room_code text unique,

status text default 'active',

created_at timestamptz default now()

);

