
CREATE TABLE IF NOT EXISTS investor_preferences (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

preferred_industry text,

risk_level text,

investment_capacity numeric DEFAULT 0,

preferred_location text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS ai_investment_recommendations (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

business_id uuid,

score integer DEFAULT 0,

risk_rating text,

ai_reason text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS ai_advisor_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

report text,

created_at timestamp DEFAULT now()

);

