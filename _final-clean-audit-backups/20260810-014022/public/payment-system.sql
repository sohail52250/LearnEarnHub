
create table if not exists payment_transactions (

id bigint generated always as identity primary key,

user_id uuid,

business_id uuid,

payment_type text,

service_name text,

amount numeric,

currency text default 'PKR',

status text default 'pending',

payment_reference text,

created_at timestamptz default now()

);



create table if not exists invoices (

id bigint generated always as identity primary key,

payment_id bigint,

invoice_number text,

description text,

amount numeric,

currency text default 'PKR',

status text default 'unpaid',

created_at timestamptz default now()

);



create table if not exists subscription_packages (

id bigint generated always as identity primary key,

package_name text,

description text,

price numeric,

currency text default 'PKR',

duration_days integer,

status text default 'active',

created_at timestamptz default now()

);



