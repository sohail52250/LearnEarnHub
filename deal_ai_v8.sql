
create table deal_contracts (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

contract_title text,

contract_content text,

status text default 'draft',

created_at timestamptz default now()

);



create table deal_signatures (

id bigint generated always as identity primary key,

contract_id bigint references deal_contracts(id) on delete cascade,

signer_id uuid,

signature_status text default 'pending',

signed_at timestamptz

);



create table escrow_release_requests (

id bigint generated always as identity primary key,

escrow_id bigint references deal_escrow(id) on delete cascade,

requested_by uuid,

approval_status text default 'pending',

approved_by uuid,

created_at timestamptz default now()

);



create table completed_deals (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

completion_status text default 'completed',

completion_date timestamptz default now()

);



create table entity_reputation (

id bigint generated always as identity primary key,

entity_id uuid,

total_deals integer default 0,

successful_deals integer default 0,

rating numeric default 0,

updated_at timestamptz default now()

);

