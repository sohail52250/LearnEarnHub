
create table if not exists business_verification_requests (

id bigint generated always as identity primary key,

business_id uuid,

request_type text,

submitted_documents text,

verification_status text default 'pending',

review_notes text,

reviewed_by uuid,

created_at timestamptz default now()

);



create table if not exists compliance_documents (

id bigint generated always as identity primary key,

business_id uuid,

document_type text,

document_url text,

verification_status text default 'pending',

uploaded_at timestamptz default now()

);



create table if not exists admin_audit_logs (

id bigint generated always as identity primary key,

admin_id uuid,

action_type text,

target_type text,

target_id bigint,

notes text,

created_at timestamptz default now()

);



create table if not exists verification_actions (

id bigint generated always as identity primary key,

business_id uuid,

action text,

status text,

performed_by uuid,

created_at timestamptz default now()

);



create table if not exists compliance_reports (

id bigint generated always as identity primary key,

business_id uuid,

report_type text,

report_status text default 'generated',

report_data text,

created_at timestamptz default now()

);

