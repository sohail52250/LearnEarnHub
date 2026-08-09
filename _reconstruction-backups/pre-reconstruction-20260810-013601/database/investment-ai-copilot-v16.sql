
CREATE TABLE IF NOT EXISTS ai_copilot_sessions (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

question text,

ai_response text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS ai_investment_notes (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

note_type text,

content text,

created_at timestamp DEFAULT now()

);

