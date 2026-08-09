
create table if not exists business_premium_features (

id bigint generated always as identity primary key,

business_id uuid,

feature_name text,

price numeric,

currency text default 'PKR',

status text default 'pending',

payment_id bigint,

created_at timestamptz default now()

);



create table if not exists advertisement_packages (

id bigint generated always as identity primary key,

package_name text,

description text,

price numeric,

currency text default 'PKR',

duration_days integer,

visibility_level text,

status text default 'active',

created_at timestamptz default now()

);



create table if not exists payment_history (

id bigint generated always as identity primary key,

user_id uuid,

payment_type text,

amount numeric,

currency text default 'PKR',

status text default 'pending',

reference_id text,

created_at timestamptz default now()

);

