# LearnEarnHub Learner Guidance Design Specification

**Phase:** 7
**Step:** 24C
**Status:** CANONICAL DESIGN SPECIFICATION
**Baseline:** 3301166f836b098856033659f216ca492bcff417
**Reference:** docs/LEARNER-GUIDANCE-SYSTEM.md

## 1. Primary UX decision

### First-time learner
Start Learning -> Learning Hub -> Study Plan -> Recommended Course -> First Lesson.

### Returning learner
Continue Learning -> Active Course -> Last Incomplete Lesson.

### Experienced learner
Direct access to Course Catalogue remains available.

## 2. Primary CTA hierarchy

| Page | Primary CTA |
|---|---|
| Main page | Start Learning |
| Learning Hub | Start Study Plan |
| Study Plan | Start Recommended Course |
| Course | Start / Continue Course |
| Lesson | Start / Continue Lesson |
| Progress | Continue Learning |
| Assessment | Start Assessment |
| Certificate | View Certificate |

## 3. Guidance behaviour

- First-time learners receive the strongest guidance.
- Returning learners receive continuation guidance.
- Experienced learners retain direct navigation.
- Secondary actions remain available.
- Guidance must not block normal navigation.
- No forced onboarding sequence.
- No duplicate learning-state system.
- Existing course, lesson, progress, authentication, and API state must be reused.

## 4. Visual hierarchy

Use:
- one clearly dominant primary CTA;
- concise next-step helper text;
- Recommended or Start Here indicators;
- progress/journey position where reliable state exists;
- subtle visual emphasis only.

Avoid:
- flashing elements;
- competing primary CTAs;
- blocking popups;
- unnecessary dialogs;
- disappearing instructions;
- unexplained icons.

## 5. Accessibility

- Respect prefers-reduced-motion.
- Keyboard navigation must remain functional.
- Primary CTA must have clear accessible text.
- Do not rely on colour alone.
- Guidance must remain understandable on mobile.
- Existing accessibility behaviour must not be removed.

## 6. Architecture constraints

Before UI implementation:

1. Reuse existing learning routes.
2. Reuse existing learning APIs.
3. Reuse existing authentication/session state.
4. Reuse existing course and lesson identifiers.
5. Reuse existing progress state.
6. Do not create parallel route systems.
7. Do not create duplicate APIs.
8. Do not replace working authentication.

## 7. Implementation order

24D - Main-page Start Learning guidance.
24E - Learning Hub Study Plan recommendation.
24F - Course and lesson next-action guidance.
24G - Returning learner Continue Learning.
24H - Full read-only verification and UX audit.
24I - Production deployment only after all gates pass.

## 8. Acceptance criteria

A first-time learner must be able to identify:

1. Where to start.
2. What to click.
3. Why to click it.
4. What happens next.
5. Where they are.
6. Their progress.
7. The next recommended action.
8. How to continue later.
9. How to reach assessment and certificate.

## 9. Permanent decision

> Guide first-time learners strongly while preserving freedom for experienced learners.

**Step 24C is design-only. No UI implementation is authorized by this document.**
