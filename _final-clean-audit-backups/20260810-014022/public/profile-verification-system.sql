
create table if not exists profile_details (

id bigint generated always as identity primary key,

user_id uuid,

profile_photo text,

bio text,

skills text,

experience text,

education text,

profile_completion integer default 0,

created_at timestamptz default now()

);



create table if not exists user_verification_requests (

id bigint generated always as identity primary key,

user_id uuid,

verification_type text,

document_url text,

status text default 'pending',

review_notes text,

reviewed_by uuid,

created_at timestamptz default now()

);



create table if not exists user_trust_scores (

id bigint generated always as identity primary key,

user_id uuid,

verification_score integer default 0,

profile_score integer default 0,

activity_score integer default 0,

total_score integer default 0,

updated_at timestamptz default now()

);



create table if not exists user_skills (

id bigint generated always as identity primary key,

user_id uuid,

skill_name text,

skill_level text,

created_at timestamptz default now()

);

