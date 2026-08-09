
CREATE TABLE IF NOT EXISTS learner_skills (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,

skill_name TEXT NOT NULL,

certificate_id BIGINT REFERENCES certificates(id) ON DELETE CASCADE,

verified BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW(),


UNIQUE(user_id,course_id)

);



CREATE TABLE IF NOT EXISTS opportunity_access (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

skill_id BIGINT REFERENCES learner_skills(id) ON DELETE CASCADE,

unlocked BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS learner_skills_user_idx

ON learner_skills(user_id);


