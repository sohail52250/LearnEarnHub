

create table business_service_fees (

id bigint generated always as identity primary key,

deal_request_id bigint references business_deal_requests(id) on delete cascade,

fee_type text,

amount numeric,

currency text default 'PKR',

payment_status text default 'pending',

created_at timestamptz default now()

);



create table business_admin_reviews (

id bigint generated always as identity primary key,

deal_request_id bigint references business_deal_requests(id) on delete cascade,

admin_id uuid,

decision text,

notes text,

created_at timestamptz default now()

);



