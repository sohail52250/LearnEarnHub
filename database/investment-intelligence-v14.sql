
CREATE TABLE IF NOT EXISTS market_insights (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

industry text,

trend_score integer DEFAULT 0,

growth_rate numeric DEFAULT 0,

market_summary text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS opportunity_scores (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

score integer DEFAULT 0,

growth_potential text,

risk_level text,

ai_analysis text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investor_insights (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

insight_type text,

summary text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS business_growth_metrics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

revenue_growth numeric DEFAULT 0,

customer_growth numeric DEFAULT 0,

market_position text,

created_at timestamp DEFAULT now()

);

