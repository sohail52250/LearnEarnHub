-- ============================================================
-- LearnEarnHub - Customer Sourcing Foundation
-- ============================================================
-- NON-DESTRUCTIVE FOUNDATION ONLY.
-- No DROP / DELETE / TRUNCATE.
-- This migration is intentionally separate from the Phase 2
-- business foundation and must be reviewed before production use.
-- ============================================================

create extension if not exists pgcrypto;

create table if not exists public.customer_requests (
    id uuid primary key default gen_random_uuid(),
    reference_id text unique not null,
    customer_id uuid,
    title text not null,
    description text,
    category text,
    quantity numeric(12,2),
    unit text,
    delivery_location text,
    needed_by timestamptz,
    budget_amount numeric(12,2),
    budget_currency text not null default 'PKR',
    condition_preference text not null default 'new',
    status text not null default 'open',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.sourcing_quotations (
    id uuid primary key default gen_random_uuid(),
    request_id uuid not null references public.customer_requests(id) on delete cascade,
    supplier_business_id uuid,
    reference_id text unique not null,
    unit_price numeric(12,2),
    quantity numeric(12,2),
    delivery_fee numeric(12,2) default 0,
    total_amount numeric(12,2),
    currency text not null default 'PKR',
    estimated_delivery_days integer,
    valid_until timestamptz,
    terms text,
    status text not null default 'submitted',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.sourcing_orders (
    id uuid primary key default gen_random_uuid(),
    request_id uuid not null references public.customer_requests(id) on delete restrict,
    quotation_id uuid references public.sourcing_quotations(id) on delete set null,
    customer_id uuid,
    supplier_business_id uuid,
    reference_id text unique not null,
    status text not null default 'pending',
    agreed_amount numeric(12,2),
    currency text not null default 'PKR',
    delivery_status text not null default 'not_started',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create index if not exists idx_customer_requests_customer_status
    on public.customer_requests(customer_id, status);
create index if not exists idx_customer_requests_status_needed_by
    on public.customer_requests(status, needed_by);
create index if not exists idx_sourcing_quotations_request
    on public.sourcing_quotations(request_id);
create index if not exists idx_sourcing_quotations_supplier
    on public.sourcing_quotations(supplier_business_id);
create index if not exists idx_sourcing_orders_request
    on public.sourcing_orders(request_id);

alter table public.customer_requests enable row level security;
alter table public.sourcing_quotations enable row level security;
alter table public.sourcing_orders enable row level security;

-- Private by default. Application-specific authenticated policies
-- should be added only after the identity/ownership model is verified.

-- ============================================================
-- END CUSTOMER SOURCING FOUNDATION
-- ============================================================
