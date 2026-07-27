
CREATE TABLE IF NOT EXISTS vendor_profiles (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

company_id uuid,

vendor_name text,

category text,

country text,

approval_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS purchase_requests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

vendor_id uuid,

request_title text,

amount numeric DEFAULT 0,

purpose text,

status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_contract_workflow (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

vendor_id uuid,

contract_title text,

contract_status text DEFAULT 'draft',

approval_stage text DEFAULT 'review',

contract_details text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS procurement_tracking (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

request_id uuid,

stage text,

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS procurement_activity_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

