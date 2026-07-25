create table if not exists learner_badges (
id bigint generated always as identity primary key,
user_id uuid references auth.users(id) on delete cascade,
badge_name text not null,
description text,
earned_at timestamptz default now()
);

create table if not exists learner_skills (
id bigint generated always as identity primary key,
user_id uuid references auth.users(id) on delete cascade,
skill text not null,
level text default 'Beginner'
);

create table if not exists learner_projects (
id bigint generated always as identity primary key,
user_id uuid references auth.users(id) on delete cascade,
title text,
description text,
link text
);

alter table learner_badges enable row level security;
alter table learner_skills enable row level security;
alter table learner_projects enable row level security;

create policy "public read badges"
on learner_badges for select
using (true);

create policy "public read skills"
on learner_skills for select
using (true);

create policy "public read projects"
on learner_projects for select
using (true);
