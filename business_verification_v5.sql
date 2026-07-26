
create table business_verification_requests (

id bigint generated always as identity primary key,

user_id uuid,

business_name text,

registration_number text,

country text,

document_url text,

verification_status text default 'pending',

admin_notes text,

created_at timestamptz default now()

);



create table business_trust_scores (

id bigint generated always as identity primary key,

business_id uuid,

verification_score integer default 0,

deal_score integer default 0,

payment_score integer default 0,

overall_score integer default 0,

updated_at timestamptz default now()

);



create table business_badges (

id bigint generated always as identity primary key,

business_id uuid,

badge_type text,

status text default 'active',

issued_at timestamptz default now()

);



