
CREATE TABLE IF NOT EXISTS erp_ai_insights (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

insight_type text,

insight text,

priority text DEFAULT 'normal',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS inventory_predictions (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

item_name text,

current_stock numeric DEFAULT 0,

predicted_demand numeric DEFAULT 0,

recommendation text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS supplier_risk_alerts (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

vendor_id uuid,

risk_level text,

reason text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS executive_ai_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

report_title text,

report_content text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS erp_ai_activity_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

