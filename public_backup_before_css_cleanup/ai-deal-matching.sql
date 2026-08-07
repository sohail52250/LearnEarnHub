
create table if not exists deal_matches (

id bigint generated always as identity primary key,

buyer_id uuid,

business_id uuid,

match_score numeric default 0,

match_reason text,

status text default 'suggested',

created_at timestamptz default now()

);



create table if not exists company_verification_records (

id bigint generated always as identity primary key,

business_id uuid,

verification_type text,

verification_status text default 'pending',

verified_by uuid,

verification_notes text,

created_at timestamptz default now()

);



create table if not exists deal_risk_assessments (

id bigint generated always as identity primary key,

deal_id bigint,

risk_level text default 'low',

ai_notes text,

created_at timestamptz default now()

);

