
create table if not exists product_orders (

id bigint generated always as identity primary key,

buyer_id uuid,

business_id uuid,

product_id bigint,

quantity integer default 1,

total_amount numeric,

currency text default 'PKR',

status text default 'pending',

created_at timestamptz default now()

);



create table if not exists product_inquiries (

id bigint generated always as identity primary key,

buyer_id uuid,

business_id uuid,

product_id bigint,

message text,

status text default 'open',

created_at timestamptz default now()

);



create table if not exists marketplace_reviews (

id bigint generated always as identity primary key,

buyer_id uuid,

business_id uuid,

product_id bigint,

rating integer,

review text,

status text default 'active',

created_at timestamptz default now()

);



create table if not exists marketplace_messages (

id bigint generated always as identity primary key,

sender_id uuid,

receiver_id uuid,

conversation_id text,

message text,

created_at timestamptz default now()

);



create table if not exists order_payments (

id bigint generated always as identity primary key,

order_id bigint,

payment_id bigint,

status text default 'pending',

created_at timestamptz default now()

);

