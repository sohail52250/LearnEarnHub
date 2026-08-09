
CREATE TABLE IF NOT EXISTS ai_deal_rooms (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

owner_id uuid,

ai_summary text,

valuation_notes text,

risk_analysis text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_negotiations (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

user_id uuid,

message text,

stage text DEFAULT 'negotiation',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_due_diligence (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

item text,

status text DEFAULT 'pending',

notes text,

created_at timestamp DEFAULT now()

);

