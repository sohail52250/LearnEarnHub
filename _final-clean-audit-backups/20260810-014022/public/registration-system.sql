
create table if not exists onboarding_progress (

id bigint generated always as identity primary key,

user_id uuid,

account_type text,

step text,

status text default 'started',

created_at timestamptz default now()

);



create table if not exists registration_requests (

id bigint generated always as identity primary key,

user_id uuid,

account_type text,

verification_status text default 'pending',

created_at timestamptz default now()

);

