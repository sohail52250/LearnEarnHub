alter table users
add column if not exists points integer default 0;

create table if not exists course_progress (
id uuid default gen_random_uuid() primary key,
user_id uuid references users(id),
course_id uuid references courses(id),
completed boolean default false,
points_added integer default 0,
created_at timestamp default now()
);

NOTIFY pgrst, 'reload schema';
