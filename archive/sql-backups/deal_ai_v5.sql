
create table deal_risk_reports (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

reported_by uuid,

reason text,

risk_level text default 'medium',

status text default 'open',

created_at timestamptz default now()

);



create table deal_documents (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

uploaded_by uuid,

document_name text,

document_url text,

verification_status text default 'pending',

created_at timestamptz default now()

);



create table deal_service_fees (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

service_type text,

amount numeric,

currency text default 'PKR',

payment_status text default 'pending',

created_at timestamptz default now()

);



create table deal_audit_logs (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

action text,

performed_by uuid,

details text,

created_at timestamptz default now()

);

