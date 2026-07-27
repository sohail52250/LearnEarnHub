ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS status text DEFAULT 'pending';

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS approved_by uuid;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS approved_at timestamp;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS revoked_by uuid;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS revoked_at timestamp;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS revoked_reason text;
