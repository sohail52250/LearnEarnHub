

-- API KEY MANAGEMENT

create table if not exists public.api_partner_keys
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key text unique not null,

status text default 'active',

created_at timestamptz default now()

);



-- API APPROVAL LOG

create table if not exists public.api_approval_logs
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

action text,

approved_by text,

created_at timestamptz default now()

);



-- DEMO KEY

insert into public.api_partner_keys
(
partner_id,
api_key
)

select

id,

'LEH_PUBLIC_API_DEMO_KEY_2026'

from public.api_partners

where email='partner@learn-earnhub.com'

on conflict(api_key)
do nothing;



notify pgrst,'reload schema';


select *
from public.api_partner_keys;

