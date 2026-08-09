
CREATE TABLE IF NOT EXISTS wallets(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid UNIQUE,
points integer DEFAULT 0,
balance_pkr numeric DEFAULT 0,
updated_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS earning_tasks(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
title_en text,
title_ur text,
description_en text,
description_ur text,
reward_points integer DEFAULT 10,
status text DEFAULT 'active',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS task_applications(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
task_id uuid,
user_id uuid,
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS wallet_transactions(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
type text,
points integer,
amount_pkr numeric,
description text,
created_at timestamp DEFAULT now()
);


