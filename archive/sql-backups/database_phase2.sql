
create table if not exists users (
 id uuid default gen_random_uuid() primary key,
 name text,
 email text unique,
 phone text,
 password text,
 language text default 'en',
 created_at timestamp default now()
);


create table if not exists ads (
 id uuid default gen_random_uuid() primary key,
 user_id uuid references users(id),
 title text not null,
 description text,
 category text,
 contact text,
 location text,
 created_at timestamp default now()
);


create table if not exists courses (
 id uuid default gen_random_uuid() primary key,
 title text not null,
 description text,
 language text default 'en',
 created_at timestamp default now()
);


create table if not exists reviews (
 id uuid default gen_random_uuid() primary key,
 user_id uuid references users(id),
 rating integer,
 comment text,
 created_at timestamp default now()
);


create table if not exists categories (
 id uuid default gen_random_uuid() primary key,
 name text unique
);


insert into categories(name)
values
('Jobs'),
('Services'),
('Education'),
('Business'),
('Trading')
on conflict do nothing;

