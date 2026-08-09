

create table if not exists public.api_dashboard_logs
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

action text,

details jsonb default '{}'::jsonb,

created_at timestamptz default now()

);



insert into public.api_dashboard_logs
(
partner_id,
action,
details
)

select

id,

'SWAGGER_ENABLED',

jsonb_build_object(
'version',
'1.0'
)

from public.api_partners

where email='partner@learn-earnhub.com';



notify pgrst,'reload schema';



select *
from public.api_dashboard_logs;


