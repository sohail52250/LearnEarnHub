CREATE TABLE IF NOT EXISTS unified_wallets (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid UNIQUE,
    points integer DEFAULT 0,
    earnings numeric DEFAULT 0,
    rewards numeric DEFAULT 0,
    last_updated timestamp DEFAULT now()
);

CREATE TABLE IF NOT EXISTS wallet_transactions (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid,
    transaction_type text,
    amount numeric DEFAULT 0,
    points integer DEFAULT 0,
    description text,
    created_at timestamp DEFAULT now()
);
