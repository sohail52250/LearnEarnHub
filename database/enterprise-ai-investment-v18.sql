
CREATE TABLE IF NOT EXISTS enterprise_ai_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

report_type text,

ai_summary text,

risk_score integer DEFAULT 0,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_due_diligence (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

company_id uuid,

check_type text,

status text DEFAULT 'pending',

ai_notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_risk_scores (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

business_id uuid,

risk_level text,

score integer DEFAULT 0,

analysis text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS executive_dashboard_metrics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

metric_name text,

metric_value text,

created_at timestamp DEFAULT now()

);

