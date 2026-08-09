
CREATE TABLE IF NOT EXISTS certificate_verification (

id BIGSERIAL PRIMARY KEY,

certificate_id BIGINT REFERENCES certificates(id) ON DELETE CASCADE,

verification_code TEXT UNIQUE NOT NULL,

user_id UUID NOT NULL,

skill_name TEXT,

status TEXT DEFAULT 'verified',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS certificate_code_idx

ON certificate_verification(verification_code);


