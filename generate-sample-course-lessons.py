from pathlib import Path

course_id = 1
course_name = "Basic Computer Networking"

sql=[]

for lesson in range(1,16):

    content=f"""
Lesson {lesson}: {course_name}

Learning Objectives
- Understand the topic
- Apply concepts in practice
- Complete exercises

Explanation
This lesson explains {course_name} concepts in detail with practical examples.

Example
Review the worked example and understand each step.

Practice Exercise
Complete the activity related to this lesson.

Quiz
1. What did you learn?
2. How would you apply it?

Summary
Review the key points before moving to the next lesson.
""".strip().replace("'","''")

    sql.append(f"""
insert into course_lessons
(
course_id,
lesson_order,
title_en,
title_ur,
title_ar,
title_nl,
content_en,
content_ur,
content_ar,
content_nl
)
values
(
{course_id},
{lesson},
'Lesson {lesson}',
'سبق {lesson}',
'الدرس {lesson}',
'Les {lesson}',
'{content}',
'یہ سبق {course_name} کے بارے میں ہے۔',
'هذا الدرس عن {course_name}.',
'Deze les gaat over {course_name}.'
);
""")

Path("sample-course-lessons.sql").write_text(
    "\n".join(sql),
    encoding="utf-8"
)

print("Created sample-course-lessons.sql")
