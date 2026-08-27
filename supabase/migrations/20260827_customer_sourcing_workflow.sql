-- LearnEarnHub customer-first commercial sourcing workflow.
-- customer need -> discovery -> quotation -> comparison -> order -> delivery -> confirmation -> payment
-- Non-destructive: new tables, indexes and RLS policies only.
create extension if not exists pgcrypto;
create table if not exists public.sourcing_requests (
 id uuid primary key default gen_random_uuid(), reference_id text unique not null,
 customer_id uuid null, product_service text not null, quantity numeric(14,2) not null default 1,
 specifications text, delivery_location text not null, needed_by timestamptz,
 budget numeric(14,2), budget_currency text not null default 'PKR', condition text not null default 'New',
 customer_name text, customer_email text, customer_phone text, customer_whatsapp text,
 status text not null default 'open', selected_quote_id uuid null,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.sourcing_quotations (
 id uuid primary key default gen_random_uuid(), reference_id text unique not null,
 request_id uuid not null references public.sourcing_requests(id) on delete cascade,
 supplier_business_id uuid not null references public.businesses(id) on delete restrict,
 supplier_contact_name text, supplier_contact_email text, supplier_contact_phone text, supplier_contact_whatsapp text,
 unit_price numeric(14,2) not null, quantity numeric(14,2) not null default 1,
 delivery_cost numeric(14,2) not null default 0, currency text not null default 'PKR',
 estimated_delivery_days integer, valid_until timestamptz, terms text, status text not null default 'submitted',
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.sourcing_orders (
 id uuid primary key default gen_random_uuid(), reference_id text unique not null,
 request_id uuid not null references public.sourcing_requests(id) on delete restrict,
 quotation_id uuid not null references public.sourcing_quotations(id) on delete restrict,
 customer_id uuid, supplier_business_id uuid not null references public.businesses(id) on delete restrict,
 status text not null default 'placed', agreed_total numeric(14,2), currency text not null default 'PKR', delivery_location text,
 customer_contact_name text, customer_contact_email text, customer_contact_phone text, customer_contact_whatsapp text,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.sourcing_deliveries (
 id uuid primary key default gen_random_uuid(), order_id uuid unique not null references public.sourcing_orders(id) on delete cascade,
 status text not null default 'pending', tracking_reference text, estimated_delivery_at timestamptz,
 delivered_at timestamptz, customer_confirmed_at timestamptz, notes text,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create index if not exists idx_sourcing_requests_customer_status on public.sourcing_requests(customer_id,status,created_at desc);
create index if not exists idx_sourcing_requests_status_created on public.sourcing_requests(status,created_at desc);
create index if not exists idx_sourcing_quotes_request_status on public.sourcing_quotations(request_id,status,created_at desc);
create index if not exists idx_sourcing_quotes_supplier on public.sourcing_quotations(supplier_business_id,created_at desc);
create index if not exists idx_sourcing_orders_customer on public.sourcing_orders(customer_id,created_at desc);
create index if not exists idx_sourcing_orders_supplier on public.sourcing_orders(supplier_business_id,created_at desc);
create index if not exists idx_sourcing_deliveries_status on public.sourcing_deliveries(status,estimated_delivery_at);
alter table public.sourcing_requests enable row level security;
alter table public.sourcing_quotations enable row level security;
alter table public.sourcing_orders enable row level security;
alter table public.sourcing_deliveries enable row level security;
drop policy if exists sourcing_requests_owner_select on public.sourcing_requests;
create policy sourcing_requests_owner_select on public.sourcing_requests for select to authenticated using (customer_id=auth.uid());
drop policy if exists sourcing_requests_owner_insert on public.sourcing_requests;
create policy sourcing_requests_owner_insert on public.sourcing_requests for insert to authenticated with check (customer_id=auth.uid());
drop policy if exists sourcing_requests_owner_update on public.sourcing_requests;
create policy sourcing_requests_owner_update on public.sourcing_requests for update to authenticated using (customer_id=auth.uid()) with check (customer_id=auth.uid());
drop policy if exists sourcing_quotes_request_owner_select on public.sourcing_quotations;
create policy sourcing_quotes_request_owner_select on public.sourcing_quotations for select to authenticated using (exists(select 1 from public.sourcing_requests r where r.id=request_id and r.customer_id=auth.uid()) or exists(select 1 from public.businesses b where b.id=supplier_business_id and b.owner_id=auth.uid()));
drop policy if exists sourcing_quotes_supplier_insert on public.sourcing_quotations;
create policy sourcing_quotes_supplier_insert on public.sourcing_quotations for insert to authenticated with check (exists(select 1 from public.businesses b where b.id=supplier_business_id and b.owner_id=auth.uid() and b.status='active'));
drop policy if exists sourcing_quotes_supplier_update on public.sourcing_quotations;
create policy sourcing_quotes_supplier_update on public.sourcing_quotations for update to authenticated using (exists(select 1 from public.businesses b where b.id=supplier_business_id and b.owner_id=auth.uid())) with check (exists(select 1 from public.businesses b where b.id=supplier_business_id and b.owner_id=auth.uid()));
drop policy if exists sourcing_orders_participant_select on public.sourcing_orders;
create policy sourcing_orders_participant_select on public.sourcing_orders for select to authenticated using (customer_id=auth.uid() or exists(select 1 from public.businesses b where b.id=supplier_business_id and b.owner_id=auth.uid()));
drop policy if exists sourcing_deliveries_participant_select on public.sourcing_deliveries;
create policy sourcing_deliveries_participant_select on public.sourcing_deliveries for select to authenticated using (exists(select 1 from public.sourcing_orders o where o.id=order_id and (o.customer_id=auth.uid() or exists(select 1 from public.businesses b where b.id=o.supplier_business_id and b.owner_id=auth.uid()))));
