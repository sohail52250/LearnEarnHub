
CREATE TABLE IF NOT EXISTS enterprise_plans(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

name text,

description text,

price numeric DEFAULT 0,

features text,

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_subscriptions(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

plan_id uuid,

status text DEFAULT 'active',

start_date timestamp DEFAULT now(),

end_date timestamp,

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_invoices(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

subscription_id uuid,

amount numeric,

status text DEFAULT 'pending',

invoice_number text,

created_at timestamp DEFAULT now()

);

