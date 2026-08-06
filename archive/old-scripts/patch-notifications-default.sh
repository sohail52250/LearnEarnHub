#!/data/data/com.termux/files/usr/bin/bash

python3 <<'PY'
from pathlib import Path

p = Path("api/notifications.js")

s = p.read_text()

old = """
if(req.query.user_id){
return res.json(
await service.getNotifications(
req.query.user_id
)
);
}
"""

new = """
const userId =
req.query.user_id || "GLOBAL";

return res.json(
await service.getNotifications(
userId
)
);
"""

s = s.replace(old,new)

p.write_text(s)

print("notifications.js updated")
PY

node -c server.js
