-- LearnEarnHub - Customer Need Discovery & Sourcing Foundation
-- NON-DESTRUCTIVE: creates only new tables/indexes/policies.
-- No government/civic workflow is represented here.

create extension if not exists pgcrypto;

create table if not exists public.customers (
    id uuid primary key default gen_random_uuid(),
    reference_id text unique not null,
    user_id uuid null,
    customer_type text not null default 'individual',
    display_name text not null,
    company_name text,
    contact_person_name text,
    contact_email text,
    contact_phone text,
    contact_whatsapp text,
    preferred_contact_method text,
    country text,
    city text,
    address text,
    status text not null default 'active',
    visibility text not null default 'private',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.customer_needs (
    id uuid primary key default gen_random_uuid(),
    customer_id uuid not null references public.customers(id) on delete cascade,
    reference_id text unique not null,
    need_title text not null,
    problem_statement text not null,
    desired_outcome text,
    product_service text,
    specifications text,
    quantity numeric(12,2),
    unit text,
    budget_min numeric(12,2),
    budget_max numeric(12,2),
    currency text not null default 'PKR',
    delivery_location text,
    needed_by timestamptz,
    priority text not null default 'normal',
    status text not null default 'open',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.sourcing_suppliers (
    id uuid primary key default gen_random_uuid(),
    business_id uuid references public.businesses(id) on delete set null,
    reference_id text unique not null,
    supplier_name text not null,
    contact_person_name text,
    contact_email text,
    contact_phone text,
    contact_whatsapp text,
    website text,
    country text,
    city text,
    address text,
    products_services text,
    capabilities text,
    service_areas text,
    verification_status text not null default 'pending',
    status text not null default 'active',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.sourcing_quotations (
    id uuid primary key default gen_random_uuid(),
    need_id uuid not null references public.customer_needs(id) on delete cascade,
    supplier_id uuid not null references public.sourcing_suppliers(id) on delete cascade,
    reference_id text unique not null,
    unit_price numeric(12,2),
    quantity numeric(12,2),
    delivery_cost numeric(12,2),
    total_price numeric(12,2),
    currency text not null default 'PKR',
    estimated_delivery text,
    payment_terms text,
    warranty_terms text,
    quotation_valid_until timestamptz,
    notes text,
    status text not null default 'received',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.sourcing_orders (
    id uuid primary key default gen_random_uuid(),
    need_id uuid not null references public.customer_needs(id) on delete restrict,
    quotation_id uuid references public.sourcing_quotations(id) on delete set null,
    customer_id uuid not null references public.customers(id) on delete restrict,
    supplier_id uuid not null references public.sourcing_suppliers(id) on delete restrict,
    reference_id text unique not null,
    status text not null default 'selected',
    delivery_status text not null default 'pending',
    payment_status text not null default 'pending',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create index if not exists idx_customer_needs_customer_status on public.customer_needs(customer_id,status);
create index if not exists idx_customer_needs_location on public.customer_needs(delivery_location);
create index if not exists idx_sourcing_suppliers_business on public.sourcing_suppliers(business_id);
create index if not exists idx_sourcing_suppliers_status_verification on public.sourcing_suppliers(status,verification_status);
create index if not exists idx_sourcing_quotations_need on public.sourcing_quotations(need_id);
create index if not exists idx_sourcing_quotations_supplier on public.sourcing_quotations(supplier_id);
create index if not exists idx_sourcing_orders_customer on public.sourcing_orders(customer_id);
create index if not exists idx_sourcing_orders_supplier on public.sourcing_orders(supplier_id);

alter table public.customers enable row level security;
alter table public.customer_needs enable row level security;
alter table public.sourcing_suppliers enable row level security;
alter table public.sourcing_quotations enable row level security;
alter table public.sourcing_orders enable row level security;

drop policy if exists "public_read_approved_sourcing_suppliers" on public.sourcing_suppliers;
create policy "public_read_approved_sourcing_suppliers"
on public.sourcing_suppliers for select to anon, authenticated
using (status = 'active' and verification_status = 'approved');

-- Customer records, needs, quotations and orders remain private until explicit
-- authenticated application policies are designed around ownership/authorization.
