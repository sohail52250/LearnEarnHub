
create table if not exists course_categories (

id bigint generated always as identity primary key,

name text not null,

icon text,

description text,

created_at timestamptz default now()

);



alter table course_categories enable row level security;


create policy "public categories"
on course_categories
for select
using(true);



insert into course_categories
(name,icon,description)

values

(
'AI & Future Skills',
'🤖',
'Artificial intelligence, automation and modern AI tools'
),

(
'Technology & Programming',
'💻',
'Web development, software and coding skills'
),

(
'Cyber Security',
'🔐',
'Security, ethical hacking and protection skills'
),

(
'Data Analytics',
'📊',
'Data analysis, SQL, Excel and visualization'
),

(
'Digital Marketing',
'📱',
'SEO, social media and online marketing'
),

(
'Design & Creativity',
'🎨',
'UI UX, graphics and creative tools'
),

(
'Freelancing',
'💰',
'Online earning and client skills'
),

(
'Cloud Computing',
'☁️',
'Cloud platforms and infrastructure'
),

(
'Business Skills',
'🏢',
'Entrepreneurship and management'
),

(
'English & Career',
'🌎',
'Communication and professional growth'
);


