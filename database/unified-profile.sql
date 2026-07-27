CREATE TABLE IF NOT EXISTS unified_profiles (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid UNIQUE,
    full_name text,
    headline text,
    bio text,
    skills text,
    education text,
    experience text,
    certifications text,
    profile_type text DEFAULT 'learner',
    city text,
    country text,
    updated_at timestamp DEFAULT now()
);
