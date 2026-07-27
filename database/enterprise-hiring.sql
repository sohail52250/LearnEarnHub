
CREATE TABLE IF NOT EXISTS enterprise_jobs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

title text,

description text,

skills text,

location text,

employment_type text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_job_applications(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

job_id uuid,

learner_id uuid,

status text DEFAULT 'applied',

notes text,

created_at timestamp DEFAULT now()

);

