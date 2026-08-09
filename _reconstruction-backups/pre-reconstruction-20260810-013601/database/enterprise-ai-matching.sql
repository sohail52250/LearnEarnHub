
CREATE TABLE IF NOT EXISTS enterprise_candidate_matches(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

job_id uuid,

learner_id uuid,

match_score integer DEFAULT 0,

status text DEFAULT 'recommended',

created_at timestamp DEFAULT now()

);

