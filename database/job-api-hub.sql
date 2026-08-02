
-- External source registry

create table if not exists public.job_sources (

 id bigint generated always as identity primary key,

 name text not null,

 api_url text,

 source_type text default 'api',

 status text default 'active',

 created_at timestamptz default now()

);


-- Imported jobs cache

create table if not exists public.imported_jobs (

 id bigint generated always as identity primary key,

 source_id bigint references public.job_sources(id),

 external_id text,

 title text,

 company text,

 description text,

 location text,

 category text,

 job_url text,

 imported_at timestamptz default now(),

 status text default 'active',

 unique(source_id,external_id)

);


create index if not exists idx_imported_jobs_title
on public.imported_jobs(title);


create index if not exists idx_imported_jobs_source
on public.imported_jobs(source_id);


-- Insert supported source examples

insert into public.job_sources
(name,api_url,source_type)
values

('Adzuna','https://api.adzuna.com','API'),

('Jooble','https://jooble.org/api','API'),

('Remote Jobs','https://remoteok.com/api','API'),

('LinkedIn Partner Feed','partner-api','PARTNER')

on conflict do nothing;


notify pgrst,'reload schema';

