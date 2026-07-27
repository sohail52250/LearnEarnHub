
CREATE TABLE IF NOT EXISTS investment_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

report_type text,

total_investment numeric DEFAULT 0,

total_return numeric DEFAULT 0,

roi_percent numeric DEFAULT 0,

risk_level text,

summary text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS business_performance_metrics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

revenue numeric DEFAULT 0,

growth_percent numeric DEFAULT 0,

market_score integer DEFAULT 0,

created_at timestamp DEFAULT now()

);

