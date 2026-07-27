
CREATE TABLE IF NOT EXISTS enterprise_finance_metrics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

metric_name text,

metric_value numeric DEFAULT 0,

period text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_inventory (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

item_name text,

category text,

quantity numeric DEFAULT 0,

status text DEFAULT 'available',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS supplier_performance (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

vendor_id uuid,

rating integer DEFAULT 0,

delivery_score integer DEFAULT 0,

quality_score integer DEFAULT 0,

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS procurement_analytics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

total_requests integer DEFAULT 0,

completed_requests integer DEFAULT 0,

total_spending numeric DEFAULT 0,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS erp_activity_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

