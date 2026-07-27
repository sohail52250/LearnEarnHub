
CREATE TABLE IF NOT EXISTS business_verifications(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

company_name text,

registration_number text,

document_url text,

status text DEFAULT 'pending',

trust_score integer DEFAULT 0,

admin_note text,

created_at timestamp DEFAULT now(),

updated_at timestamp DEFAULT now()

);

