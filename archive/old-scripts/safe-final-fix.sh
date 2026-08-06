#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Safe Final Fix"
echo "======================================"

# Backup auth
if [ -f api/auth.js ]; then
cp api/auth.js api/auth.backup.$(date +%Y%m%d-%H%M%S)
fi

echo "1) Securing auth response..."

python - <<'PY'
p="api/auth.js"

try:
    s=open(p).read()

    if "delete data[0].password" not in s:
        s=s.replace(
        "return res.json({success:true,data,error});",
        """if(data && data[0]) delete data[0].password;
return res.json({success:true,data,error});"""
        )

        open(p,"w").write(s)

except Exception as e:
    print(e)
PY


echo "2) Creating missing course-player page..."

if [ ! -f public/course-player.html ]; then

cat > public/course-player.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course Player</title>
</head>
<body>
<h1>Course Player / کورس پلیئر</h1>
<div id="course-content">
Loading course...
</div>
<script src="/course-player.js"></script>
</body>
</html>
HTML

fi


echo "3) Creating missing apply opportunity page..."

if [ ! -f public/apply-opportunity.html ]; then

cat > public/apply-opportunity.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Apply Opportunity</title>
</head>
<body>
<h1>Apply Opportunity / موقع کے لئے درخواست</h1>
<p>Please login to apply.</p>
<script src="/apply-opportunity.js"></script>
</body>
</html>
HTML

fi


echo "4) Git save..."

git add api/auth.js public/course-player.html public/apply-opportunity.html

git commit -m "Safe auth security and missing pages fix" || true

git push


echo ""
echo "======================================"
echo " Deployment check"
echo "======================================"

sleep 5

echo "Users API:"
curl -s https://learn-earnhub.vercel.app/api/users

echo ""
echo "Course Player:"
curl -I -s https://learn-earnhub.vercel.app/course-player.html | head -1

echo ""
echo "Apply Opportunity:"
curl -I -s https://learn-earnhub.vercel.app/apply-opportunity.html | head -1

echo ""
echo "DONE"

