
CREATE TABLE IF NOT EXISTS job_api_sources (

id BIGSERIAL PRIMARY KEY,

name TEXT NOT NULL,

source_type TEXT DEFAULT 'API',

api_url TEXT,

country TEXT DEFAULT 'Global',

active BOOLEAN DEFAULT true,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS imported_jobs (

id BIGSERIAL PRIMARY KEY,

source_id BIGINT REFERENCES job_api_sources(id),

external_id TEXT,

title TEXT,

company TEXT,

description TEXT,

category TEXT,

required_skills TEXT,

country TEXT,

remote BOOLEAN DEFAULT false,

salary TEXT,

apply_url TEXT,

source_name TEXT,

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(source_id,external_id)

);



CREATE INDEX IF NOT EXISTS imported_jobs_skill_idx

ON imported_jobs(required_skills);


