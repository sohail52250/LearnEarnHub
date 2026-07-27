#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Points Only Mode"
echo "======================================"

cat > database/points_only.sql <<'SQL'

CREATE TABLE IF NOT EXISTS user_points(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid UNIQUE,
points integer DEFAULT 0,
level integer DEFAULT 1,
updated_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS points_history(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
points integer,
reason text,
created_at timestamp DEFAULT now()
);


SQL


echo "Updating documentation..."

grep -RIl "withdraw\|withdrawal\|payment request\|cash out" public api README* 2>/dev/null \
| xargs -r sed -i 's/withdrawal/points reward/g;s/withdraw/points redeem/g;s/cash out/reward system/g'


git add .

git commit -m "Keep LearnEarnHub points only no withdrawal system" || true

git push


echo "======================================"
echo " POINTS ONLY SYSTEM READY"
echo "======================================"

