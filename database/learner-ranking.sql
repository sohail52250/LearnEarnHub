
CREATE TABLE IF NOT EXISTS learner_badges (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

badge_name TEXT NOT NULL,

level TEXT DEFAULT 'Bronze',

points INTEGER DEFAULT 0,

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(user_id,badge_name)

);



CREATE TABLE IF NOT EXISTS learner_scores (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

total_points INTEGER DEFAULT 0,

level TEXT DEFAULT 'Bronze',

updated_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS learner_score_idx

ON learner_scores(total_points);


