
CREATE TABLE IF NOT EXISTS earning_tasks (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
title_en text,
title_ur text,
description_en text,
description_ur text,
reward integer DEFAULT 0,
status text DEFAULT 'active',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS task_applications (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
task_id uuid REFERENCES earning_tasks(id),
user_id uuid REFERENCES users(id),
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_opportunities (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
title_en text,
title_ur text,
description_en text,
description_ur text,
category text,
status text DEFAULT 'open',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_offers (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
offer_title text,
offer_description text,
category text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS opportunity_matches (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
learner_id uuid,
opportunity_id uuid,
match_score integer DEFAULT 0,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS payment_transactions (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
amount integer DEFAULT 0,
payment_type text,
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);

