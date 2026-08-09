
-- =====================================================
-- LearnEarnHub API Security + Analytics
-- =====================================================


-- API SECURITY EVENTS

create table if not exists public.api_security_events
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key_id bigint
references public.api_partner_keys(id)
on delete cascade,

event_type text not null,

details jsonb default '{}'::jsonb,

created_at timestamptz default now()

);



create index if not exists idx_api_security_partner

on public.api_security_events(partner_id);



create index if not exists idx_api_security_key

on public.api_security_events(api_key_id);



-- API ANALYTICS VIEW

create or replace view public.api_security_analytics as

select

k.id as api_key_id,

k.partner_id,

p.partner_name,

k.api_key,

k.status,

k.blocked,

k.request_limit,

k.monthly_limit,

count(e.id) as security_events,


max(e.created_at) as last_security_event


from public.api_partner_keys k


left join public.api_partners p

on p.id=k.partner_id


left join public.api_security_events e

on e.api_key_id=k.id


group by

k.id,

k.partner_id,

p.partner_name,

k.api_key,

k.status,

k.blocked,

k.request_limit,

k.monthly_limit;



-- DEMO SECURITY EVENT

insert into public.api_security_events
(
partner_id,
api_key_id,
event_type,
details
)

select

k.partner_id,

k.id,

'API_KEY_CREATED',

jsonb_build_object(
'action',
'Initial API key setup'
)

from public.api_partner_keys k

where k.api_key='LEH_PUBLIC_API_DEMO_KEY_2026';



notify pgrst,'reload schema';


select *
from public.api_security_analytics;

