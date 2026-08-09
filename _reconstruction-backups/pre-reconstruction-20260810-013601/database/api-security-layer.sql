

-- =====================================
-- API SECURITY SUPPORT
-- =====================================


alter table public.api_partner_keys

add column if not exists

request_limit integer default 1000;



alter table public.api_partner_keys

add column if not exists

monthly_limit integer default 30000;



alter table public.api_partner_keys

add column if not exists

blocked boolean default false;



create table if not exists public.api_security_events
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

event_type text,

details jsonb,

created_at timestamptz default now()

);



notify pgrst,'reload schema';



select *
from public.api_partner_keys;


