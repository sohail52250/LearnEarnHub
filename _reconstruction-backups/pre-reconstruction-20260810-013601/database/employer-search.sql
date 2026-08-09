
CREATE TABLE IF NOT EXISTS employer_profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

company_name TEXT,

industry TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS candidate_views (

id BIGSERIAL PRIMARY KEY,

employer_id BIGINT,

learner_id UUID NOT NULL,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS candidate_skill_idx

ON learner_skills(skill_name);


