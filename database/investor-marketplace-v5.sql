
CREATE TABLE IF NOT EXISTS investor_profiles (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

investor_type text,

industry_focus text,

investment_range numeric DEFAULT 0,

location text,

bio text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS funding_requests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

owner_id uuid,

funding_amount numeric DEFAULT 0,

purpose text,

equity_offered text,

status text DEFAULT 'open',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_interests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

funding_id uuid,

investor_id uuid,

message text,

status text DEFAULT 'submitted',

created_at timestamp DEFAULT now()

);

