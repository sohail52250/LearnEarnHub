alter table courses
add column if not exists title_en text;

alter table courses
add column if not exists title_ur text;

alter table courses
add column if not exists description_en text;

alter table courses
add column if not exists description_ur text;

alter table courses
add column if not exists points integer default 10;

alter table courses
add column if not exists created_at timestamp default now();

NOTIFY pgrst, 'reload schema';
