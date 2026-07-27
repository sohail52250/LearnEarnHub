
CREATE TABLE IF NOT EXISTS funding_rounds (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

round_name text,

target_amount numeric DEFAULT 0,

raised_amount numeric DEFAULT 0,

status text DEFAULT 'open',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_offers (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

round_id uuid,

investor_id uuid,

offer_amount numeric DEFAULT 0,

terms text,

status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_closing_checklist (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

round_id uuid,

item text,

status text DEFAULT 'pending',

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS marketplace_activity (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

