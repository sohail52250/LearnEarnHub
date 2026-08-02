
CREATE TABLE IF NOT EXISTS audit_logs (

id BIGSERIAL PRIMARY KEY,

user_email TEXT,

action TEXT,

target TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS audit_logs_date_idx

ON audit_logs(created_at);


