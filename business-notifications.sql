create table if not exists business_notifications (

    id uuid primary key default gen_random_uuid(),

    business_id uuid references auth.users(id)
    on delete cascade,

    title text not null,

    message text not null,

    read boolean default false,

    created_at timestamptz default now()

);

alter table business_notifications
enable row level security;

create policy "Business read own notifications"
on business_notifications
for select
to authenticated
using (
    auth.uid() = business_id
);

create policy "Business update own notifications"
on business_notifications
for update
to authenticated
using (
    auth.uid() = business_id
);

create index if not exists idx_business_notifications_business
on business_notifications(business_id);

create index if not exists idx_business_notifications_read
on business_notifications(read);
