create table if not exists user_roles (

id uuid primary key default gen_random_uuid(),

user_id uuid references auth.users(id),

role text,

created_at timestamp default now()

);


alter table user_roles enable row level security;


create policy "Users can read own role"

on user_roles

for select

using(auth.uid()=user_id);
