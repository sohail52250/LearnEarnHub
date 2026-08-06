alter table ads
add column if not exists title text;

alter table ads
add column if not exists description text;

alter table ads
add column if not exists category text;

alter table ads
add column if not exists contact text;

alter table ads
add column if not exists location text;

alter table ads
add column if not exists user_id uuid;

alter table ads
add column if not exists created_at timestamp default now();

NOTIFY pgrst, 'reload schema';
