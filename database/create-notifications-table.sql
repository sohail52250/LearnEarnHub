
-- Main notifications table expected by API

create table if not exists public.notifications (

    id bigint generated always as identity primary key,

    user_id text,

    title text not null,

    message text,

    notification_type text default 'system',

    is_read boolean default false,

    created_at timestamptz default now(),

    updated_at timestamptz default now()
);


create index if not exists idx_notifications_user_id
on public.notifications(user_id);


create index if not exists idx_notifications_read
on public.notifications(is_read);


-- Trigger

create or replace function public.update_notifications_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = now();
    return new;
end;
$$;


drop trigger if exists trg_notifications_updated
on public.notifications;


create trigger trg_notifications_updated
before update
on public.notifications
for each row
execute function public.update_notifications_updated_at();


-- Security

alter table public.notifications
enable row level security;


drop policy if exists notifications_read_policy
on public.notifications;


create policy notifications_read_policy
on public.notifications
for select
using (true);


-- Test notification

insert into public.notifications
(
 user_id,
 title,
 message,
 notification_type
)
values
(
 'GLOBAL',
 'LearnEarnHub Notification System',
 'Opportunity alert system is active.',
 'system'
);


notify pgrst,'reload schema';

