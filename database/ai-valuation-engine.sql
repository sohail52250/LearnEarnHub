
CREATE TABLE IF NOT EXISTS business_valuations (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

revenue numeric DEFAULT 0,

profit numeric DEFAULT 0,

assets numeric DEFAULT 0,

risk_score integer DEFAULT 0,

estimated_value numeric DEFAULT 0,

ai_report text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS valuation_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

valuation_id uuid,

report_title text,

report_content text,

created_at timestamp DEFAULT now()

);

