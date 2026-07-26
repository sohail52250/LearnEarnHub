

create table business_packages (

id bigint generated always as identity primary key,

package_name text,

price numeric,

features text,

status text default 'active',

created_at timestamptz default now()

);



create table business_payments (

id bigint generated always as identity primary key,

user_id uuid,

package_name text,

amount numeric,

currency text default 'PKR',

payment_status text default 'pending',

transaction_id text,

created_at timestamptz default now()

);



create table business_commissions (

id bigint generated always as identity primary key,

payment_id bigint references business_payments(id) on delete cascade,

commission_amount numeric,

status text default 'pending',

created_at timestamptz default now()

);


