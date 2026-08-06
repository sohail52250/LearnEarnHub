
create table deal_risk_scores (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

score integer default 0,

risk_level text default 'low',

ai_notes text,

created_at timestamptz default now()

);



create table deal_document_reviews (

id bigint generated always as identity primary key,

document_id bigint references deal_documents(id) on delete cascade,

reviewer_id uuid,

decision text default 'pending',

notes text,

created_at timestamptz default now()

);



create table deal_certificates (

id bigint generated always as identity primary key,

room_id bigint references deal_rooms(id) on delete cascade,

certificate_code text unique,

issued_to text,

status text default 'active',

created_at timestamptz default now()

);

