
create table if not exists business_sales (

id bigint generated always as identity primary key,

business_id uuid,

owner_id uuid,

company_name text,

industry text,

description text,

location text,

years_operation integer,

asking_price numeric,

currency text default 'PKR',

status text default 'pending',

ai_status text default 'pending',

created_at timestamptz default now()

);



create table if not exists business_buy_requests (

id bigint generated always as identity primary key,

buyer_id uuid,

industry text,

budget numeric,

currency text default 'PKR',

requirements text,

status text default 'pending',

created_at timestamptz default now()

);



create table if not exists company_acquisitions (

id bigint generated always as identity primary key,

requester_id uuid,

target_business_id uuid,

offer_amount numeric,

currency text default 'PKR',

status text default 'pending',

created_at timestamptz default now()

);



create table if not exists business_partnership_requests (

id bigint generated always as identity primary key,

company_id uuid,

partner_type text,

proposal text,

status text default 'pending',

created_at timestamptz default now()

);



create table if not exists due_diligence_documents (

id bigint generated always as identity primary key,

deal_id bigint,

document_name text,

document_url text,

access_status text default 'restricted',

created_at timestamptz default now()

);



create table if not exists business_contracts (

id bigint generated always as identity primary key,

deal_id bigint,

contract_type text,

contract_url text,

status text default 'draft',

created_at timestamptz default now()

);



create table if not exists deal_milestones (

id bigint generated always as identity primary key,

deal_id bigint,

milestone_name text,

status text default 'pending',

completed_at timestamptz

);

