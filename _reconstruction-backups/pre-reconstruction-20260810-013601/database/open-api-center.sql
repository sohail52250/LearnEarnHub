
-- ======================================
-- LearnEarnHub Open API Center Database
-- ======================================


create table if not exists public.api_join_requests
(
id bigint generated always as identity primary key,

company_name text not null,

email text not null,

purpose text,

status text default 'pending',

created_at timestamptz default now(),

updated_at timestamptz default now()
);



create table if not exists public.api_permissions
(
id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

permission_name text not null,

allowed boolean default false,

created_at timestamptz default now()
);



create table if not exists public.api_rate_limits
(
id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

daily_limit integer default 1000,

monthly_limit integer default 30000,

created_at timestamptz default now()
);



create table if not exists public.api_agreements
(
id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

agreement_type text default 'data-sharing',

accepted boolean default false,

accepted_at timestamptz,

created_at timestamptz default now()
);



notify pgrst,'reload schema';


select *
from public.api_join_requests;

