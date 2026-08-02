
create table if not exists public.learner_notifications (
    id bigint generated always as identity primary key,

    learner_id text,

    title text not null,
    body text,

    read boolean default false,

    created_at timestamptz default now()
);

create index if not exists idx_learner_notifications_read
on public.learner_notifications(read);

notify pgrst,'reload schema';

