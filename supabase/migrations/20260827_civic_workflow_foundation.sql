-- LearnEarnHub - Civic/Public Works Workflow Foundation
-- NON-DESTRUCTIVE: additive only. Execute in Supabase only after review.
-- Lifecycle:
-- Citizen need -> Problem identified -> Site verification -> Work designed
-- -> Cost estimated -> Budget/admin approval -> Procurement/contract
-- -> Work completed -> Measurement & inspection -> Payment

create table if not exists public.civic_requests (
    id uuid primary key default gen_random_uuid(),
    reference_id text unique not null,
    citizen_user_id uuid,
    citizen_name text,
    citizen_contact text,
    location_text text not null,
    latitude numeric(9,6),
    longitude numeric(9,6),
    category text not null,
    description text not null,
    status text not null default 'need_reported',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.civic_workflow (
    id uuid primary key default gen_random_uuid(),
    request_id uuid not null unique references public.civic_requests(id) on delete cascade,
    problem_identified_at timestamptz,
    site_verified_at timestamptz,
    work_designed_at timestamptz,
    cost_estimated_at timestamptz,
    budget_approved_at timestamptz,
    procurement_contracted_at timestamptz,
    work_completed_at timestamptz,
    measurement_inspected_at timestamptz,
    payment_completed_at timestamptz,
    estimated_cost numeric(14,2),
    approved_budget numeric(14,2),
    contract_amount numeric(14,2),
    measured_amount numeric(14,2),
    paid_amount numeric(14,2),
    currency text not null default 'PKR',
    notes text,
    updated_at timestamptz not null default now()
);

create table if not exists public.civic_workflow_events (
    id uuid primary key default gen_random_uuid(),
    request_id uuid not null references public.civic_requests(id) on delete cascade,
    stage text not null,
    action text not null default 'completed',
    actor_user_id uuid,
    note text,
    created_at timestamptz not null default now()
);

create index if not exists idx_civic_requests_status on public.civic_requests(status);
create index if not exists idx_civic_requests_location on public.civic_requests(location_text);
create index if not exists idx_civic_events_request on public.civic_workflow_events(request_id, created_at);

alter table public.civic_requests enable row level security;
alter table public.civic_workflow enable row level security;
alter table public.civic_workflow_events enable row level security;

-- Public users may see only non-sensitive request tracking data through the API.
-- Direct anonymous table reads/writes are intentionally not granted.

comment on table public.civic_requests is 'Citizen-reported public need and problem intake.';
comment on table public.civic_workflow is 'End-to-end public works lifecycle and financial controls.';
comment on table public.civic_workflow_events is 'Immutable audit trail for civic workflow stage changes.';
