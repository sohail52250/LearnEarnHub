
-- Learner skills

create table if not exists public.learner_skills (

    id bigint generated always as identity primary key,

    user_id text not null,

    skill text not null,

    level text default 'beginner',

    created_at timestamptz default now()

);


-- Opportunity skills mapping

create table if not exists public.opportunity_skills (

    id bigint generated always as identity primary key,

    opportunity_id bigint references public.external_opportunities(id)
    on delete cascade,

    skill text not null,

    created_at timestamptz default now()

);


-- Recommendations

create table if not exists public.recommendations (

    id bigint generated always as identity primary key,

    user_id text,

    opportunity_id bigint,

    match_score integer default 0,

    reason text,

    created_at timestamptz default now()

);


create index if not exists idx_learner_skills_user
on public.learner_skills(user_id);


create index if not exists idx_recommendations_user
on public.recommendations(user_id);


notify pgrst,'reload schema';

