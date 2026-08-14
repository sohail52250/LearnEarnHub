Set-Location 'F:\Projects\lehup\LearnEarnHub'
$ErrorActionPreference='Stop'

Write-Host "`n=== LEARNEARNHUB BUSINESS FOUNDATION + TASK-VALUE-5 ===" -ForegroundColor Cyan

$root=(Get-Location).Path
$stamp=Get-Date -Format 'yyyyMMdd-HHmmss'
$safe=Join-Path (Split-Path $root -Parent) "LearnEarnHub-BUSINESS-BACKUP-$stamp"

Write-Host "Creating external safety backup: $safe"
New-Item -ItemType Directory -Path $safe -Force | Out-Null
robocopy $root $safe /E /R:1 /W:1 /XD .git node_modules .vercel | Out-Null

Write-Host "`n=== CREATING BUSINESS DATABASE SCHEMA ===" -ForegroundColor Cyan

New-Item -ItemType Directory -Path "$root\database" -Force | Out-Null

@'
create extension if not exists pgcrypto;

create table if not exists public.businesses (
    id uuid primary key default gen_random_uuid(),
    reference_id text unique not null,
    owner_id uuid null,
    business_name text not null,
    legal_name text,
    business_type text,
    category text,
    subcategory text,
    description text,
    website text,
    social_links jsonb not null default '{}'::jsonb,

    contact_person_name text,
    contact_role text,
    contact_email text,
    contact_phone text,
    contact_whatsapp text,

    country text,
    city text,
    address text,
    postal_code text,

    business_hours text,
    years_active integer,
    staff_count integer,

    products_services text,
    current_activities text,
    operational_needs text,

    introducer_name text,
    introducer_relationship text,
    introducer_contact text,
    introducer_reference text,

    visibility text not null default 'private',
    verification_status text not null default 'pending',
    status text not null default 'active',

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create index if not exists businesses_owner_id_idx
    on public.businesses(owner_id);

create index if not exists businesses_reference_id_idx
    on public.businesses(reference_id);

create index if not exists businesses_category_idx
    on public.businesses(category);

create table if not exists public.business_tasks (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references public.businesses(id) on delete cascade,
    reference_id text unique not null,

    task_description text not null,
    payment_amount numeric(12,2),
    payment_currency text not null default 'PKR',

    frequency text,
    time_required_minutes integer,
    deadline timestamptz,

    status text not null default 'open',

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create index if not exists business_tasks_business_id_idx
    on public.business_tasks(business_id);

create index if not exists business_tasks_status_idx
    on public.business_tasks(status);

create or replace function public.generate_business_reference()
returns text
language plpgsql
as $$
declare
    ref text;
begin
    ref := 'LEH-BIZ-' ||
           upper(substr(replace(gen_random_uuid()::text,'-',''),1,10));
    return ref;
end;
$$;

create or replace function public.generate_task_reference()
returns text
language plpgsql
as $$
declare
    ref text;
begin
    ref := 'LEH-TASK-' ||
           upper(substr(replace(gen_random_uuid()::text,'-',''),1,10));
    return ref;
end;
$$;
