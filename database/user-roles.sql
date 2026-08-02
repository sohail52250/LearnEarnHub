
CREATE TABLE IF NOT EXISTS user_roles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

role TEXT DEFAULT 'learner',

created_at TIMESTAMP DEFAULT NOW(),

updated_at TIMESTAMP DEFAULT NOW()

);


CREATE INDEX IF NOT EXISTS user_roles_user_idx
ON user_roles(user_id);

