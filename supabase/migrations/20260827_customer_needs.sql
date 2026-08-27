-- LearnEarnHub: universal customer need / suggestion intake
-- Non-government, customer-first workflow. No DROP/DELETE/TRUNCATE.
create extension if not exists pgcrypto;

create table if not exists public.customer_needs (
  id uuid primary key default gen_random_uuid(),
  reference_id text unique not null default ('NEED-' || upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 10))),
  user_id uuid null,
  person_type text not null,
  request_type text not null,
  title text not null,
  problem_description text not null,
  desired_outcome text,
  urgency text not null default 'normal',
  location text,
  budget numeric(12,2),
  contact_name text,
  contact_email text,
  contact_phone text,
  preferred_contact text,
  attachment_url text,
  status text not null default 'new',
  source text not null default 'public-need-form',
  internal_note text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_customer_needs_status_created
  on public.customer_needs(status, created_at desc);
create index if not exists idx_customer_needs_person_type
  on public.customer_needs(person_type);
create index if not exists idx_customer_needs_request_type
  on public.customer_needs(request_type);

alter table public.customer_needs enable row level security;

-- Public intake is intentionally write-only. No public read policy is created.
drop policy if exists "public_submit_customer_need" on public.customer_needs;
create policy "public_submit_customer_need"
on public.customer_needs
for insert
to anon, authenticated
with check (true);

-- Authenticated users may see only their own submitted requests when user_id is set.
drop policy if exists "users_read_own_customer_needs" on public.customer_needs;
create policy "users_read_own_customer_needs"
on public.customer_needs
for select
to authenticated
using (user_id = auth.uid());
