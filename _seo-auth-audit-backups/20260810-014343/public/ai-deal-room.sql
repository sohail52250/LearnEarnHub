
create table if not exists deal_rooms (

id bigint generated always as identity primary key,

deal_id bigint,

party_one_id uuid,

party_two_id uuid,

room_status text default 'active',

ai_monitoring boolean default true,

created_at timestamptz default now()

);



create table if not exists deal_messages (

id bigint generated always as identity primary key,

room_id bigint,

sender_platform_id text,

message text,

ai_flag text default 'normal',

created_at timestamptz default now()

);



create table if not exists deal_meeting_requests (

id bigint generated always as identity primary key,

room_id bigint,

requested_by uuid,

consent_status text default 'pending',

meeting_date timestamptz,

created_at timestamptz default now()

);



create table if not exists deal_introduction_payments (

id bigint generated always as identity primary key,

deal_id bigint,

payer_id uuid,

amount numeric,

currency text default 'PKR',

status text default 'pending',

created_at timestamptz default now()

);



create table if not exists deal_documents_access (

id bigint generated always as identity primary key,

deal_id bigint,

document_id bigint,

access_granted_to uuid,

permission text default 'view',

created_at timestamptz default now()

);



create table if not exists deal_completion_records (

id bigint generated always as identity primary key,

deal_id bigint,

completion_status text default 'pending',

completion_notes text,

created_at timestamptz default now()

);

