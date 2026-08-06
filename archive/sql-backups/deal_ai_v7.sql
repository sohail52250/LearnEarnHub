
create table deal_negotiations (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

sender_id uuid,

offer_type text default 'offer',

offer_amount numeric,

message text,

status text default 'pending',

created_at timestamptz default now()

);



create table deal_escrow (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

payer_id uuid,

amount numeric,

currency text default 'PKR',

escrow_status text default 'holding',

released_to uuid,

created_at timestamptz default now()

);



create table deal_final_approval (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

party_one_approved boolean default false,

party_two_approved boolean default false,

admin_approved boolean default false,

final_status text default 'pending',

created_at timestamptz default now()

);

