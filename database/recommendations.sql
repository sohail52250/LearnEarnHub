
CREATE TABLE IF NOT EXISTS opportunity_recommendations (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES external_opportunities(id) ON DELETE CASCADE,

skill_score INTEGER DEFAULT 0,

location_score INTEGER DEFAULT 0,

history_score INTEGER DEFAULT 0,

final_score INTEGER DEFAULT 0,

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(user_id,opportunity_id)

);



CREATE INDEX IF NOT EXISTS recommendation_user_idx

ON opportunity_recommendations(user_id);


