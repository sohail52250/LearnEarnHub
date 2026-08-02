
CREATE TABLE IF NOT EXISTS job_submissions (

id BIGSERIAL PRIMARY KEY,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

learner_id UUID NOT NULL,

submission_text TEXT,

status TEXT DEFAULT 'submitted',

submitted_at TIMESTAMP DEFAULT NOW(),

approved_at TIMESTAMP DEFAULT NULL

);



CREATE INDEX IF NOT EXISTS job_submission_learner_idx

ON job_submissions(learner_id);


