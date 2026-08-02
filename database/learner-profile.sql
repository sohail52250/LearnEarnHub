
CREATE TABLE IF NOT EXISTS learner_profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

full_name TEXT,

bio TEXT,

profile_image TEXT,

portfolio_url TEXT,

location TEXT,

created_at TIMESTAMP DEFAULT NOW(),

updated_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS learner_reviews (

id BIGSERIAL PRIMARY KEY,

learner_id UUID NOT NULL,

reviewer_id UUID,

rating INTEGER CHECK(rating >=1 AND rating <=5),

comment TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS learner_profile_user_idx

ON learner_profiles(user_id);


