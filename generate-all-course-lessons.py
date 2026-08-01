import json
from pathlib import Path

courses=json.loads(Path("courses.json").read_text())

lesson_templates={

"Computer Skills":[
"What is {title}?",
"Basic Concepts of {title}",
"Tools and Environment",
"Step by Step Usage",
"Practical Examples",
"Common Problems and Solutions",
"Security and Best Practices",
"Advanced Techniques",
"Real World Applications",
"Hands-on Practice",
"Professional Tips",
"Troubleshooting",
"Mini Project",
"Review and Assessment",
"Final Skill Test"
],

"Office Skills":[
"Introduction to {title}",
"Understanding the Interface",
"Basic Features",
"Working with Documents",
"Working with Data",
"Creating Professional Work",
"Time Saving Techniques",
"Common Mistakes",
"Practical Tasks",
"Advanced Features",
"Workplace Examples",
"Productivity Tips",
"Practice Project",
"Knowledge Review",
"Final Assessment"
],

"Programming":[
"Introduction to {title}",
"Programming Fundamentals",
"Development Environment",
"Syntax and Structure",
"Variables and Data",
"Logic and Conditions",
"Functions",
"Working with Data",
"Projects",
"Debugging",
"Best Practices",
"Advanced Concepts",
"Real Applications",
"Portfolio Project",
"Final Assessment"
],

"AI & Future Skills":[
"Introduction to {title}",
"AI Fundamentals",
"Important Concepts",
"Modern Tools",
"Practical Usage",
"Automation Examples",
"Workplace Applications",
"Future Trends",
"Safety and Ethics",
"Hands-on Practice",
"Mini Project",
"Advanced Skills",
"Career Opportunities",
"Review",
"Final Assessment"
]

}

default_lessons=[
"Introduction to {title}",
"Basic Concepts",
"Important Skills",
"Practical Methods",
"Examples",
"Tools and Techniques",
"Common Mistakes",
"Best Practices",
"Real Applications",
"Exercises",
"Advanced Knowledge",
"Professional Tips",
"Practice Project",
"Review",
"Final Assessment"
]


sql=[]

for c in courses:

    cid=c["id"]
    title=c.get("title_en") or c.get("title")
    category=c.get("category","")

    lessons=lesson_templates.get(
        category,
        default_lessons
    )

    for i,lesson in enumerate(lessons,1):

        name=lesson.format(title=title)

        content=f"""
{name}

Learning Objectives:
- Understand {title}
- Learn practical skills
- Apply knowledge in real situations

Introduction:
This lesson explains {title} step by step for beginners.

Detailed Explanation:
Learners will understand concepts, tools, examples and practical methods.

Practice:
Complete exercises and apply what you learned.

Summary:
Review important points before continuing.

Quiz:
Test your understanding.
""".strip()

        def esc(x):
            return x.replace("'","''")

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
{cid},
{i},
'{esc(name)}',
'سبق {i}',
'الدرس {i}',
'Les {i}',
'{esc(content)}',
'یہ سبق {title} کے بارے میں مکمل معلومات فراہم کرتا ہے۔',
'هذا الدرس يقدم شرحا كاملا عن {title}.',
'Deze les geeft volledige uitleg over {title}.'
);
""")

Path("all-course-lessons.sql").write_text(
"\n".join(sql),
encoding="utf-8"
)

print("Created all-course-lessons.sql")
print("Total lessons:",len(sql))
