
CREATE TABLE IF NOT EXISTS business_profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL UNIQUE,

company_name TEXT,

description TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS business_opportunities (

id BIGSERIAL PRIMARY KEY,

business_id BIGINT REFERENCES business_profiles(id) ON DELETE CASCADE,

title TEXT NOT NULL,

description TEXT,

required_skill TEXT NOT NULL,

payment TEXT,

status TEXT DEFAULT 'open',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS job_hires (

id BIGSERIAL PRIMARY KEY,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

learner_id UUID NOT NULL,

status TEXT DEFAULT 'selected',

created_at TIMESTAMP DEFAULT NOW()

);



