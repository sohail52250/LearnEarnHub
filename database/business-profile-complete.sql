
CREATE TABLE IF NOT EXISTS business_profiles_complete(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid UNIQUE,

company_name text,
logo text,

owner_name text,
email text,
phone text,

category text,

description text,
about_company text,

services text,
products text,

experience text,

team_size text,

city text,
country text,
address text,

website text,
facebook text,
linkedin text,

registration_number text,

verification_status text DEFAULT 'pending',

portfolio text,

created_at timestamp DEFAULT now(),
updated_at timestamp DEFAULT now()

);

