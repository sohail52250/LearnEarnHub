
-- =====================================================
-- LearnEarnHub API Usage Dashboard
-- =====================================================


create table if not exists public.api_request_events
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key_id bigint
references public.api_partner_keys(id)
on delete cascade,

endpoint text,

method text default 'GET',

status_code integer,

created_at timestamptz default now()

);



create index if not exists idx_api_events_partner
on public.api_request_events(partner_id);



create index if not exists idx_api_events_key
on public.api_request_events(api_key_id);



create index if not exists idx_api_events_date
on public.api_request_events(created_at);



create or replace view public.api_usage_dashboard as

select

k.id as api_key_id,

k.partner_id,

k.api_key,

k.status,

k.request_limit,

k.monthly_limit,

count(e.id) as total_requests,

max(e.created_at) as last_request


from public.api_partner_keys k

left join public.api_request_events e

on k.id=e.api_key_id


group by

k.id,

k.partner_id,

k.api_key,

k.status,

k.request_limit,

k.monthly_limit;



notify pgrst,'reload schema';



select *

from public.api_usage_dashboard;

