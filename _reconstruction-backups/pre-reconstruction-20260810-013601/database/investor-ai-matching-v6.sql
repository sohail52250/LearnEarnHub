
CREATE TABLE IF NOT EXISTS investor_matches (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

business_id uuid,

funding_id uuid,

match_score integer DEFAULT 0,

ai_reason text,

created_at timestamp DEFAULT now()

);

