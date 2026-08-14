-- ============================================================
-- LearnEarnHub
-- Phase 2 - Business Opportunities Marketplace
-- ============================================================

-- Existing model:
-- public.businesses
-- public.business_tasks

-- Phase 2 does not rename:
--   frequency
--   time_required_minutes
--   deadline
--
-- It makes the opportunity read model efficient and explicit.

create index if not exists business_tasks_open_created_idx
    on public.business_tasks(status, created_at desc);

create index if not exists business_tasks_deadline_idx
    on public.business_tasks(deadline);

create index if not exists businesses_verification_status_idx
    on public.businesses(verification_status);

create index if not exists businesses_visibility_status_idx
    on public.businesses(visibility, status);

-- Optional integrity checks.
-- These are deliberately NOT enforced here because existing
-- production records may contain null values.

comment on table public.business_tasks is
    'LearnEarnHub business opportunities / tasks.';

comment on column public.business_tasks.frequency is
    'How often the work occurs.';

comment on column public.business_tasks.time_required_minutes is
    'Estimated minutes required for one occurrence.';

comment on column public.business_tasks.deadline is
    'Requested completion deadline for the opportunity.';