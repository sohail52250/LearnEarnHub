
create table if not exists admin_vacancies (

id uuid primary key default gen_random_uuid(),

title text not null,

department text,

description text,

requirements text,

status text default 'open',

created_at timestamptz default now()

);



create table if not exists admin_applications (

id uuid primary key default gen_random_uuid(),

vacancy_id uuid references admin_vacancies(id)
on delete cascade,

applicant_id uuid,

name text,

email text,

experience text,

skills text,

status text default 'submitted',

created_at timestamptz default now()

);



alter table admin_vacancies enable row level security;

alter table admin_applications enable row level security;



create policy "public view open vacancies"

on admin_vacancies

for select

using(status='open');



