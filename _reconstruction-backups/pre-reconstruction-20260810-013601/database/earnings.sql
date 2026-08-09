
CREATE TABLE IF NOT EXISTS learner_earnings (

id BIGSERIAL PRIMARY KEY,

learner_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

amount NUMERIC DEFAULT 0,

currency TEXT DEFAULT 'USD',

status TEXT DEFAULT 'pending',

paid_at TIMESTAMP DEFAULT NULL,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS business_payments (

id BIGSERIAL PRIMARY KEY,

business_id BIGINT,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

amount NUMERIC DEFAULT 0,

currency TEXT DEFAULT 'USD',

status TEXT DEFAULT 'pending',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS earnings_user_idx

ON learner_earnings(learner_id);


