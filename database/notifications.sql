
CREATE TABLE IF NOT EXISTS notifications (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

title TEXT NOT NULL,

message TEXT NOT NULL,

type TEXT DEFAULT 'general',

read_status BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS notifications_user_idx

ON notifications(user_id);


