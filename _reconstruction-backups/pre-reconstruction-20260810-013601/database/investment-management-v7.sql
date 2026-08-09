
CREATE TABLE IF NOT EXISTS investments (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

business_id uuid,

funding_id uuid,

amount numeric DEFAULT 0,

equity text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_returns (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

roi_percent numeric DEFAULT 0,

return_amount numeric DEFAULT 0,

report_note text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investor_portfolio_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

