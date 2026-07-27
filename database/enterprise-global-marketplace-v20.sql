
CREATE TABLE IF NOT EXISTS global_companies (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

company_name text,

country text,

industry text,

company_type text,

website text,

description text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS supplier_marketplace (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

company_id uuid,

service_name text,

category text,

price_range text,

availability text DEFAULT 'available',

description text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_contracts (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

company_id uuid,

contract_title text,

contract_type text,

status text DEFAULT 'draft',

details text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS global_opportunities (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

company_id uuid,

title text,

country text,

category text,

description text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS global_market_activity (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

company_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

