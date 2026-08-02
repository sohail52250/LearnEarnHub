
CREATE TABLE IF NOT EXISTS fraud_flags (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

flag_type TEXT,

risk_level TEXT DEFAULT 'LOW',

details TEXT,

status TEXT DEFAULT 'OPEN',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS identity_checks (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

check_type TEXT,

result TEXT DEFAULT 'PENDING',

reference_code TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS fraud_user_idx

ON fraud_flags(user_id);


