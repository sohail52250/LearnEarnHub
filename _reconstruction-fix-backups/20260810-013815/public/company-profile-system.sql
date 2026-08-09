
create table if not exists company_profiles (

id bigint generated always as identity primary key,

business_id uuid,

company_name text,

industry text,

company_type text,

description text,

website text,

location text,

employees_count integer,

founded_year integer,

profile_visibility text default 'public',

verification_status text default 'pending',

created_at timestamptz default now()

);



create table if not exists company_private_information (

id bigint generated always as identity primary key,

business_id uuid,

financial_information text,

asset_information text,

documents_access text default 'restricted',

created_at timestamptz default now()

);



create table if not exists investor_profiles (

id bigint generated always as identity primary key,

user_id uuid,

investment_interest text,

preferred_industry text,

investment_range numeric,

currency text default 'PKR',

profile_status text default 'active',

created_at timestamptz default now()

);



create table if not exists partnership_preferences (

id bigint generated always as identity primary key,

business_id uuid,

partnership_type text,

preferred_industry text,

requirements text,

status text default 'active',

created_at timestamptz default now()

);



create table if not exists company_reputation_scores (

id bigint generated always as identity primary key,

business_id uuid,

trust_score numeric default 0,

review_score numeric default 0,

verification_score numeric default 0,

updated_at timestamptz default now()

);



create table if not exists company_badges (

id bigint generated always as identity primary key,

business_id uuid,

badge_type text,

badge_status text default 'active',

issued_by uuid,

created_at timestamptz default now()

);



create table if not exists verification_history (

id bigint generated always as identity primary key,

business_id uuid,

verification_action text,

performed_by uuid,

notes text,

created_at timestamptz default now()

);

