

create table if not exists public.api_documentation_views
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

page text,

created_at timestamptz default now()

);



notify pgrst,'reload schema';


select *
from public.api_documentation_views;


