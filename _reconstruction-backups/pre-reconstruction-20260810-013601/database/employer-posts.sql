
CREATE TABLE IF NOT EXISTS employer_jobs (

id BIGSERIAL PRIMARY KEY,

employer_id UUID NOT NULL,

title TEXT NOT NULL,

company TEXT,

description TEXT,

required_skills TEXT,

job_type TEXT DEFAULT 'job',

country TEXT DEFAULT 'Global',

remote BOOLEAN DEFAULT false,

salary TEXT,

status TEXT DEFAULT 'pending',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS employer_jobs_skill_idx

ON employer_jobs(required_skills);


