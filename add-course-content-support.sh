#!/data/data/com.termux/files/usr/bin/bash

echo "Updating courses API for full content..."

python - <<'PY'
p="api/courses.js"

s=open(p).read()

s=s.replace(
"""description_en,
description_ur,
points
""",
"""description_en,
description_ur,
content_en,
content_ur,
points
"""
)

s=s.replace(
"""description_ur,
points:points || 10
""",
"""description_ur,
content_en,
content_ur,
points:points || 10
"""
)

open(p,"w").write(s)
PY


git add api/courses.js
git commit -m "Add course content support" || true
git push


echo "Done"
