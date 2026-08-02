
-- =========================================
-- AI Matching Cleanup & Repair
-- =========================================


-- Remove old weak matches

delete from public.recommendations;


-- Ensure job skills table exists

create table if not exists public.job_skills (

id bigint generated always as identity primary key,

opportunity_id bigint
references public.imported_jobs(id)
on delete cascade,

skill text not null,

created_at timestamptz default now(),

unique(opportunity_id,skill)

);



-- Ensure AI matching fields

alter table public.recommendations
add column if not exists confidence text;



-- Add skills automatically from job data

insert into public.job_skills
(opportunity_id,skill)

select
id,
'AI'

from public.imported_jobs

where lower(title) like '%ai%'

on conflict do nothing;



insert into public.job_skills
(opportunity_id,skill)

select
id,
'Writing'

from public.imported_jobs

where lower(title) like '%writer%'

on conflict do nothing;



insert into public.job_skills
(opportunity_id,skill)

select
id,
'Data Entry'

from public.imported_jobs

where lower(title) like '%data%'

on conflict do nothing;



notify pgrst,'reload schema';

