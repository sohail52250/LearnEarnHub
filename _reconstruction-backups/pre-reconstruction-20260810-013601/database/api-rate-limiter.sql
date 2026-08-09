

-- =====================================
-- API Usage Tracking
-- =====================================


create table if not exists public.api_usage_logs
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key_id bigint
references public.api_partner_keys(id)
on delete cascade,

endpoint text,

method text,

status_code integer,

created_at timestamptz default now()

);



create index if not exists idx_api_usage_partner

on public.api_usage_logs(partner_id);



create index if not exists idx_api_usage_key

on public.api_usage_logs(api_key_id);



notify pgrst,'reload schema';



select *

from public.api_usage_logs;


