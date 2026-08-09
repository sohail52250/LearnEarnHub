
CREATE TABLE IF NOT EXISTS investor_verification (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

verification_type text,

status text DEFAULT 'pending',

verified_by uuid,

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS compliance_documents (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

document_name text,

document_type text,

document_url text,

verification_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS regulatory_audits (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

audit_type text,

audit_status text DEFAULT 'pending',

audit_notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS compliance_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

