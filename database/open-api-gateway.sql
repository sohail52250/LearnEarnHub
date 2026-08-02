
-- =========================================
-- Open API Partner System
-- =========================================


create table if not exists public.api_partners (

id bigint generated always as identity primary key,

name text not null,

email text,

api_key text unique not null,

status text default 'active',

rate_limit integer default 1000,

created_at timestamptz default now()

);



create table if not exists public.api_request_logs (

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

endpoint text,

method text,

created_at timestamptz default now()

);



create index if not exists idx_api_logs_partner

on public.api_request_logs(partner_id);



notify pgrst,'reload schema';

