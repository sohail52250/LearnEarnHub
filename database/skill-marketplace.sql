
CREATE TABLE IF NOT EXISTS marketplace_opportunities (

id BIGSERIAL PRIMARY KEY,

title TEXT NOT NULL,

description TEXT,

required_skill TEXT NOT NULL,

type TEXT DEFAULT 'task',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS learner_applications (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES marketplace_opportunities(id) ON DELETE CASCADE,

status TEXT DEFAULT 'pending',

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(user_id,opportunity_id)

);



CREATE INDEX IF NOT EXISTS opportunity_skill_idx

ON marketplace_opportunities(required_skill);


