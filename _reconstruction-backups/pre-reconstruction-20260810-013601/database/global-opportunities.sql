
CREATE TABLE IF NOT EXISTS job_sources (

id BIGSERIAL PRIMARY KEY,

name TEXT NOT NULL,

country TEXT DEFAULT 'Global',

source_type TEXT DEFAULT 'jobs',

api_url TEXT,

active BOOLEAN DEFAULT true,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS external_opportunities (

id BIGSERIAL PRIMARY KEY,

source_id BIGINT REFERENCES job_sources(id) ON DELETE CASCADE,

title TEXT NOT NULL,

company TEXT,

description TEXT,

required_skill TEXT,

country TEXT,

remote BOOLEAN DEFAULT false,

apply_url TEXT,

opportunity_type TEXT DEFAULT 'job',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS opportunity_matches (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES external_opportunities(id) ON DELETE CASCADE,

match_score INTEGER DEFAULT 0,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS external_skill_idx

ON external_opportunities(required_skill);


