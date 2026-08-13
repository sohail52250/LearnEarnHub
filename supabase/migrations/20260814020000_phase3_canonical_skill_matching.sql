-- LearnEarnHub Phase 3
-- Canonical business opportunity -> learner skill matching
-- Additive migration only.

ALTER TABLE IF EXISTS public.business_tasks
    ADD COLUMN IF NOT EXISTS required_skills TEXT[];

CREATE INDEX IF NOT EXISTS business_tasks_required_skills_gin_idx
    ON public.business_tasks USING GIN (required_skills);

COMMENT ON COLUMN public.business_tasks.required_skills IS
    'Normalized learner skill names required by this business opportunity.';

CREATE OR REPLACE VIEW public.phase3_opportunity_skill_catalog AS
SELECT
    bt.id AS opportunity_id,
    bt.reference_id AS opportunity_reference,
    bt.task_description,
    bt.required_skills,
    bt.status,
    bt.created_at,
    bt.deadline
FROM public.business_tasks AS bt
WHERE bt.status = 'open';

NOTIFY pgrst, 'reload schema';
