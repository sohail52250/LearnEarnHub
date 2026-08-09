
CREATE TABLE IF NOT EXISTS messages (

id BIGSERIAL PRIMARY KEY,

sender_id UUID NOT NULL,

receiver_id UUID NOT NULL,

job_id BIGINT,

message TEXT NOT NULL,

read_status BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS messages_receiver_idx

ON messages(receiver_id);


CREATE INDEX IF NOT EXISTS messages_sender_idx

ON messages(sender_id);


