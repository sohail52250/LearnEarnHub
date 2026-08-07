
create table if not exists user_roles (

id bigint generated always as identity primary key,

user_id uuid,

role_name text,

status text default 'active',

created_at timestamptz default now()

);



create table if not exists user_permissions (

id bigint generated always as identity primary key,

role_name text,

permission_name text,

created_at timestamptz default now()

);



create table if not exists user_profiles (

id bigint generated always as identity primary key,

user_id uuid,

full_name text,

profile_type text,

avatar_url text,

bio text,

country text,

language text default 'en',

created_at timestamptz default now()

);



create table if not exists user_activity_logs (

id bigint generated always as identity primary key,

user_id uuid,

activity_type text,

activity_details text,

created_at timestamptz default now()

);



create table if not exists account_status (

id bigint generated always as identity primary key,

user_id uuid,

status text default 'active',

reason text,

updated_at timestamptz default now()

);

