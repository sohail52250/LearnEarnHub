create table if not exists government_requests (
 id bigint generated always as identity primary key,
 department_name text,
 officer_name text,
 officer_id text,
 official_email text,
 country text,
 request_type text,
 case_reference text,
 legal_basis text,
 request_status text default 'pending',
 created_at timestamptz default now()
);

create table if not exists government_accounts (
 id bigint generated always as identity primary key,
 department_name text,
 officer_name text,
 officer_id text,
 official_email text,
 verified boolean default false,
 created_at timestamptz default now()
);

create table if not exists compliance_audit_logs (
 id bigint generated always as identity primary key,
 actor text,
 action text,
 details text,
 created_at timestamptz default now()
);
