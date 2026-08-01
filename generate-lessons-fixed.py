import json
from pathlib import Path

courses=json.loads(Path("courses.json").read_text())

sql=[]

for c in courses:

    cid=c["id"]

    for lesson in range(1,16):

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
{lesson},

'Lesson {lesson}',
'سبق {lesson}',
'الدرس {lesson}',
'Les {lesson}',

'This lesson explains the topic step by step. Learners should read carefully, practice examples, and complete exercises.',

'یہ سبق مرحلہ وار وضاحت فراہم کرتا ہے۔ طلبہ مثالوں اور مشقوں کے ذریعے سیکھیں۔',

'يشرح هذا الدرس الموضوع خطوة بخطوة مع أمثلة وتمارين عملية.',

'Deze les legt het onderwerp stap voor stap uit met voorbeelden en oefeningen.'
);
""")

Path("create-lessons-fixed.sql").write_text(
    "\n".join(sql),
    encoding="utf-8"
)

print("Created create-lessons-fixed.sql")
