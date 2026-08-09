
CREATE TABLE IF NOT EXISTS enterprises(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid UNIQUE,

company_name text,

industry text,

description text,

website text,

email text,

phone text,

city text,

country text,

employees text,

verification_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_training(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

course_id uuid,

assigned_to uuid,

status text DEFAULT 'assigned',

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_employees(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

employee_id uuid,

role text,

created_at timestamp DEFAULT now()

);

