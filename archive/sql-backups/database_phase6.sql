
create table if not exists profiles (
id uuid primary key default gen_random_uuid(),
user_id uuid references users(id),
bio text,
skills text,
city text,
avatar text,
created_at timestamp default now()
);


create table if not exists reviews (
id uuid primary key default gen_random_uuid(),
user_id uuid references users(id),
reviewer text,
rating integer,
comment text,
created_at timestamp default now()
);


create table if not exists referrals (
id uuid primary key default gen_random_uuid(),
user_id uuid references users(id),
referral_code text,
points integer default 0,
created_at timestamp default now()
);

