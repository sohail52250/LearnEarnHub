
-- Skills
create table if not exists skills (

    id uuid primary key default gen_random_uuid(),

    name text not null,

    description text,

    created_at timestamptz default now()

);


-- Tasks
create table if not exists skill_tasks (

    id uuid primary key default gen_random_uuid(),

    skill_id uuid references skills(id)
    on delete cascade,

    title text not null,

    description text,

    difficulty text default 'beginner',

    coin_reward integer default 0,

    status text default 'active',

    created_at timestamptz default now()

);


-- Learner task submissions

create table if not exists task_submissions (

    id uuid primary key default gen_random_uuid(),

    task_id uuid references skill_tasks(id)
    on delete cascade,

    learner_id uuid references auth.users(id)
    on delete cascade,

    submission_text text,

    status text default 'pending',

    created_at timestamptz default now()

);


-- Coin wallet

create table if not exists learner_wallets (

    id uuid primary key default gen_random_uuid(),

    learner_id uuid references auth.users(id)
    on delete cascade,

    coins integer default 0,

    updated_at timestamptz default now()

);


-- Coin history

create table if not exists coin_transactions (

    id uuid primary key default gen_random_uuid(),

    learner_id uuid references auth.users(id)
    on delete cascade,

    amount integer not null,

    transaction_type text,

    description text,

    created_at timestamptz default now()

);


-- Indexes

create index if not exists idx_skill_tasks_skill
on skill_tasks(skill_id);


create index if not exists idx_task_submissions_learner
on task_submissions(learner_id);


create index if not exists idx_coin_transactions_learner
on coin_transactions(learner_id);


