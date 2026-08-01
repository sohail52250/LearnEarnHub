import csv
from pathlib import Path

sql=[]

for module_id in range(1,277):

    for lesson in range(1,6):

        sql.append(f"""
insert into course_lessons
(
module_id,
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
{module_id},
{lesson},
'Lesson {lesson}',
'سبق {lesson}',
'الدرس {lesson}',
'Les {lesson}',

'This lesson explains concepts step by step with examples and exercises.',

'یہ سبق مرحلہ وار وضاحت، مثالوں اور مشقوں کے ساتھ سکھاتا ہے۔',

'يشرح هذا الدرس المفاهيم خطوة بخطوة مع أمثلة وتمارين.',

'Deze les legt stap voor stap concepten uit met voorbeelden en oefeningen.'
);
""")

Path("create-lessons.sql").write_text(
"\n".join(sql),
encoding="utf-8"
)

print("Created create-lessons.sql")
