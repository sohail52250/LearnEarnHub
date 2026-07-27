#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Safe Final Fix ==="

# Backup auth
cp api/auth.js api/auth.backup.$(date +%Y%m%d-%H%M)

# Remove password from auth register response
python - <<'PY'
p="api/auth.js"

s=open(p).read()

s=s.replace(
'return res.json({success:true,data,error});',
'''if(data && data[0]) delete data[0].password;
return res.json({success:true,data,error});'''
)

open(p,"w").write(s)

PY


# Create missing route pages safely

if [ ! -f public/course-player.html ]; then

cat > public/course-player.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Course Player</title>
</head>
<body>
<h1>Course Player / کورس پلیئر</h1>
<p>Loading course...</p>
<script src="/course-player.js"></script>
</body>
</html>
HTML

fi


if [ ! -f public/apply-opportunity.html ]; then

cat > public/apply-opportunity.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Apply Opportunity</title>
</head>
<body>
<h1>Apply Opportunity / موقع کے لئے درخواست</h1>
<p>Please login and apply.</p>
</body>
</html>
HTML

fi


git add .

git commit -m "Safe final security and missing page fixes"

git push

echo "=== DONE ==="

