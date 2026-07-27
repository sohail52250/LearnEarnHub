
CREATE TABLE IF NOT EXISTS investor_approvals (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

reviewer_id uuid,

status text DEFAULT 'pending',

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS funding_agreements (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

agreement_title text,

agreement_content text,

signed_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS shareholder_records (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

investor_id uuid,

ownership_percentage numeric DEFAULT 0,

share_type text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_documents (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

document_name text,

document_url text,

verification_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS governance_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

