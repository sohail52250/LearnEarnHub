
CREATE TABLE IF NOT EXISTS verification_records (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

reference_code TEXT UNIQUE NOT NULL,

verification_type TEXT,

classification TEXT DEFAULT 'VERIFIED',

status TEXT DEFAULT 'active',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS reputation_scores (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

rating_score INTEGER DEFAULT 0,

completed_jobs INTEGER DEFAULT 0,

verified_skills INTEGER DEFAULT 0,

trust_level TEXT DEFAULT 'NEW',

updated_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS reputation_reviews (

id BIGSERIAL PRIMARY KEY,

reviewer_id UUID,

reviewed_user_id UUID NOT NULL,

rating INTEGER CHECK(rating >=1 AND rating <=5),

comment TEXT,

reference_id BIGINT REFERENCES verification_records(id),

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS verification_user_idx

ON verification_records(user_id);


CREATE INDEX IF NOT EXISTS reputation_user_idx

ON reputation_scores(user_id);


