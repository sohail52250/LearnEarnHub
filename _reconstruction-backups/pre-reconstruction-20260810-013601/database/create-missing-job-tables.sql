
create table if not exists public.employer_jobs (
    id bigint generated always as identity primary key,
    title text not null,
    company text,
    description text,
    location text,
    salary text,
    created_at timestamptz default now()
);

create table if not exists public.external_opportunities (
    id bigint generated always as identity primary key,
    title text not null,
    source text,
    url text,
    location text,
    description text,
    created_at timestamptz default now()
);

