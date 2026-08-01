import json
from pathlib import Path

courses = json.loads(Path("courses.json").read_text())

sql=[]

for c in courses:
    cid=c["id"]

    en=c.get("title_en") or c.get("title") or ""

    ur=f"{en} (اردو)"
    ar=f"{en} (العربية)"
    nl=f"{en} (Nederlands)"

    desc=c.get("description_en") or c.get("description") or ""

    dur=f"{desc} (اردو)"
    dar=f"{desc} (العربية)"
    dnl=f"{desc} (Nederlands)"

    def esc(t):
        return str(t).replace("'","''")

    sql.append(f"""
update courses
set
title_ur='{esc(ur)}',
title_ar='{esc(ar)}',
title_nl='{esc(nl)}',

description_ur='{esc(dur)}',
description_ar='{esc(dar)}',
description_nl='{esc(dnl)}'

where id={cid};
""")

Path("update-course-translations.sql").write_text(
    "\n".join(sql),
    encoding="utf-8"
)

print("Created update-course-translations.sql")
