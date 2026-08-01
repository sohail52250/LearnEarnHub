import json
from pathlib import Path

courses = json.loads(Path("courses.json").read_text())

sql = []

for c in courses:
    cid = c["id"]
    title = c.get("title_en") or c.get("title") or "Course"

    content_en = f"""
# {title}

## Course Overview
This course is designed for complete beginners and will gradually build professional-level understanding of {title}.

## Module 1: Foundations
### Lesson 1: Introduction
What is {title} and why is it important?

### Lesson 2: Key Concepts
Understanding terminology, tools and workflows.

### Exercise
Write a short summary of what you learned.

## Module 2: Practical Skills
### Lesson 3: Hands-On Practice
Step-by-step activities and examples.

### Lesson 4: Common Mistakes
How to avoid beginner errors.

### Exercise
Complete a practical task.

## Module 3: Real-World Applications
### Lesson 5: Professional Usage
How businesses and professionals use these skills.

### Lesson 6: Advanced Techniques
Methods used by experienced practitioners.

## Project
Build a small project demonstrating your understanding.

## Final Quiz
1. Explain the main purpose of {title}.
2. Describe two practical uses.
3. List three important concepts.

## Certificate Requirements
- Complete all lessons
- Finish exercises
- Pass final quiz
- Submit project

## Learning Outcome
After completing this course, the learner will be able to confidently understand and apply {title}.
""".strip()

    content_ur = f"یہ {title} کا مکمل تربیتی کورس ہے۔ اس میں بنیادی معلومات، عملی مشقیں، منصوبے اور امتحان شامل ہیں۔"
    content_ar = f"هذه دورة تدريبية كاملة حول {title}. تحتوي على دروس وتمارين ومشاريع واختبار نهائي."
    content_nl = f"Dit is een volledige cursus over {title}. Inclusief lessen, oefeningen, projecten en een eindtoets."

    def esc(txt):
        return txt.replace("'", "''")

    sql.append(f"""
update courses
set
content_en='{esc(content_en)}',
content_ur='{esc(content_ur)}',
content_ar='{esc(content_ar)}',
content_nl='{esc(content_nl)}'
where id={cid};
""")

Path("advanced-course-content.sql").write_text(
    "\n".join(sql),
    encoding="utf-8"
)

print("Created advanced-course-content.sql")
