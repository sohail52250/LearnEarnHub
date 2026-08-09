
CREATE TABLE IF NOT EXISTS profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

full_name TEXT,

avatar_url TEXT,

bio TEXT,

created_at TIMESTAMP DEFAULT NOW(),

updated_at TIMESTAMP DEFAULT NOW()

);


CREATE INDEX IF NOT EXISTS profiles_user_idx
ON profiles(user_id);

