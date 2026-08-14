-- LearnEarnHub
-- Phase 3 business foundation
-- Additive canonical schema migration.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS public.businesses (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    reference_id text UNIQUE NOT NULL,
    owner_id uuid NULL,
    business_name text NOT NULL,
    legal_name text,
    business_type text,
    category text,
    subcategory text,
    description text,
    website text,
    social_links jsonb NOT NULL DEFAULT '{}'::jsonb,

    contact_person_name text,
    contact_role text,
    contact_email text,
    contact_phone text,
    contact_whatsapp text,

    country text,
    city text,
    address text,
    postal_code text,

    business_hours text,
    years_active integer,
    staff_count integer,

    products_services text,
    current_activities text,
    operational_needs text,

    introducer_name text,
    introducer_relationship text,
    introducer_contact text,
    introducer_reference text,

    visibility text NOT NULL DEFAULT 'private',
    verification_status text NOT NULL DEFAULT 'pending',
    status text NOT NULL DEFAULT 'active',

    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS businesses_owner_id_idx
    ON public.businesses(owner_id);

CREATE INDEX IF NOT EXISTS businesses_reference_id_idx
    ON public.businesses(reference_id);

CREATE INDEX IF NOT EXISTS businesses_category_idx
    ON public.businesses(category);

CREATE INDEX IF NOT EXISTS businesses_verification_status_idx
    ON public.businesses(verification_status);

CREATE INDEX IF NOT EXISTS businesses_visibility_status_idx
    ON public.businesses(visibility, status);


CREATE TABLE IF NOT EXISTS public.business_tasks (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id uuid NOT NULL
        REFERENCES public.businesses(id)
        ON DELETE CASCADE,

    reference_id text UNIQUE NOT NULL,

    task_description text NOT NULL,
    payment_amount numeric(12,2),
    payment_currency text NOT NULL DEFAULT 'PKR',

    frequency text,
    time_required_minutes integer,
    deadline timestamptz,

    status text NOT NULL DEFAULT 'open',

    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS business_tasks_business_id_idx
    ON public.business_tasks(business_id);

CREATE INDEX IF NOT EXISTS business_tasks_reference_id_idx
    ON public.business_tasks(reference_id);

CREATE INDEX IF NOT EXISTS business_tasks_status_idx
    ON public.business_tasks(status);

CREATE INDEX IF NOT EXISTS business_tasks_open_created_idx
    ON public.business_tasks(status, created_at DESC);

CREATE INDEX IF NOT EXISTS business_tasks_deadline_idx
    ON public.business_tasks(deadline);


CREATE OR REPLACE FUNCTION public.generate_business_reference()
RETURNS text
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN 'LEH-BIZ-' ||
           upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 10));
END;
$$;


CREATE OR REPLACE FUNCTION public.generate_task_reference()
RETURNS text
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN 'LEH-TASK-' ||
           upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 10));
END;
$$;


COMMENT ON TABLE public.business_tasks IS
    'LearnEarnHub business opportunities / tasks.';

COMMENT ON COLUMN public.business_tasks.frequency IS
    'How often the work occurs.';

COMMENT ON COLUMN public.business_tasks.time_required_minutes IS
    'Estimated minutes required for one occurrence.';

COMMENT ON COLUMN public.business_tasks.deadline IS
    'Requested completion deadline for the opportunity.';


CREATE TABLE IF NOT EXISTS public.learner_skills (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id text NOT NULL,
    skill text NOT NULL,
    level text DEFAULT 'beginner',
    created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_learner_skills_user
    ON public.learner_skills(user_id);


CREATE TABLE IF NOT EXISTS public.learner_profiles (
    id bigserial PRIMARY KEY,
    user_id uuid UNIQUE NOT NULL,
    full_name text,
    bio text,
    profile_image text,
    portfolio_url text,
    location text,
    created_at timestamp DEFAULT now(),
    updated_at timestamp DEFAULT now()
);

CREATE INDEX IF NOT EXISTS learner_profile_user_idx
    ON public.learner_profiles(user_id);


CREATE TABLE IF NOT EXISTS public.learner_reviews (
    id bigserial PRIMARY KEY,
    learner_id uuid NOT NULL,
    reviewer_id uuid,
    rating integer CHECK (rating >= 1 AND rating <= 5),
    comment text,
    created_at timestamp DEFAULT now()
);


NOTIFY pgrst, 'reload schema';