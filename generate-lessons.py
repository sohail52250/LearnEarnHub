import json
from pathlib import Path

courses=json.loads(Path("courses.json").read_text())

sql=[]

for course in courses:

    cid=course["id"]
    title=course.get("title_en","Course")

    for module_num in range(1,4):

        sql.append(f"""
insert into course_modules
(course_id,module_order,title_en,title_ur,title_ar,title_nl)
values
(
{cid},
{module_num},
'Module {module_num}: {title}',
'ماڈیول {module_num}: {title}',
'الوحدة {module_num}: {title}',
'Module {module_num}: {title}'
);
""")

Path("create-modules.sql").write_text(
"\n".join(sql),
encoding="utf-8"
)

print("Created create-modules.sql")
