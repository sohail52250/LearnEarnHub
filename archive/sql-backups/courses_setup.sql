create table if not exists courses (
id uuid default gen_random_uuid() primary key,
title_en text,
title_ur text,
description_en text,
description_ur text,
points integer default 10,
created_at timestamp default now()
);

create table if not exists enrollments (
id uuid default gen_random_uuid() primary key,
user_id uuid,
course_id uuid,
completed boolean default false,
created_at timestamp default now()
);

NOTIFY pgrst, 'reload schema';
