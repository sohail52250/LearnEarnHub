-- LearnEarnHub Phase 3: canonical opportunity -> learner skill matching
-- Safe, additive migration. Do not create legacy duplicate opportunity tables.

-- Existing Phase 2 opportunity model is business_tasks.
-- Existing learner skill model is learner_skills.
-- Add normalized required skill names to the canonical opportunity record.
ALTER TABLE IF EXISTS public.business_tasks
  ADD COLUMN IF NOT EXISTS required_skills TEXT[];

CREATE INDEX IF NOT EXISTS business_tasks_required_skills_gin_idx
  ON public.business_tasks USING GIN (required_skills);

COMMENT ON COLUMN public.business_tasks.required_skills IS
  'Normalized learner skill names required by this business opportunity.';

-- Canonical read-only catalog for the Phase 3 matching service.
-- Match scores are intentionally computed by the service and are not
-- persisted by this migration.
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
