#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Backup ==="
cp public/index.html public/index-before-guide-center-$(date +%Y%m%d-%H%M%S).html


echo "=== Create Guide Pages ==="

cat > public/how-it-works.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>How LearnEarnHub Works</title>
<link rel="stylesheet" href="/style.css">
</head>

<body>

<h1 data-i18n="guide_title">🚀 How LearnEarnHub Works</h1>

<div class="card">
<h2>🌍 What is LearnEarnHub?</h2>
<p>
LearnEarnHub is a global learning, earning, opportunity and business connection platform.
</p>
<p>
Learn skills, build profiles, find opportunities, connect with businesses and earn rewards.
</p>
</div>


<div class="card">
<h2>👥 Who Benefits?</h2>

<h3>🎓 Students</h3>
<p>
Learn skills, complete courses, earn certificates, build career profiles and discover opportunities.
</p>

<h3>💼 Individuals & Freelancers</h3>
<p>
Show skills, create professional profiles, find projects and grow reputation.
</p>

<h3>🏢 Businesses</h3>
<p>
Advertise services, find talent, create opportunities and grow connections.
</p>

<h3>👨‍🏫 Instructors</h3>
<p>
Publish courses, teach skills and reach learners.
</p>

</div>


<div class="card">

<h2>🔄 How To Use</h2>

<p>
1. Create free account
</p>

<p>
2. Select your role
</p>

<p>
3. Complete your profile
</p>

<p>
4. Learn, connect and participate
</p>

<p>
5. Earn rewards and opportunities
</p>

</div>


<div class="card">

<h2>🎁 Reward System</h2>

<p>
Rewards may include:
</p>

<ul>
<li>Learning points</li>
<li>Certificates</li>
<li>Skill badges</li>
<li>Profile verification</li>
<li>Business opportunities</li>
<li>Future earning programs</li>
</ul>

</div>


<a href="/index.html">⬅ Home</a>

<script src="/language-switcher.js"></script>

</body>
</html>
HTML


cp public/how-it-works.html public/guide.html
cp public/how-it-works.html public/student-guide.html
cp public/how-it-works.html public/business-guide.html
cp public/how-it-works.html public/rewards-guide.html
cp public/how-it-works.html public/individual-guide.html


echo "=== Add translation keys ==="

python3 <<'PY'
import json,os

items={
"en":{
"guide_title":"🚀 How LearnEarnHub Works",
"guides":"Guides",
"rewards":"Rewards",
"how_it_works":"How It Works"
},
"ur":{
"guide_title":"🚀 LearnEarnHub کیسے کام کرتا ہے",
"guides":"رہنمائی",
"rewards":"انعامات",
"how_it_works":"طریقہ کار"
},
"ar":{
"guide_title":"🚀 كيف يعمل LearnEarnHub",
"guides":"الأدلة",
"rewards":"المكافآت",
"how_it_works":"طريقة العمل"
},
"nl":{
"guide_title":"🚀 Hoe LearnEarnHub werkt",
"guides":"Handleidingen",
"rewards":"Beloningen",
"how_it_works":"Hoe het werkt"
}
}

for lang,data in items.items():

 p=f"public/translations/{lang}.json"

 if os.path.exists(p):
  with open(p,encoding="utf8") as f:
   old=json.load(f)
 else:
  old={}

 old.update(data)

 with open(p,"w",encoding="utf8") as f:
  json.dump(old,f,ensure_ascii=False,indent=2)

print("translations added")
PY


echo "=== Add homepage guide links ==="

python3 <<'PY'
p="public/index.html"

with open(p,encoding="utf8") as f:
 s=f.read()

section="""

<div class="card">

<h2>🌍 LearnEarnHub Guide Center</h2>

<p>
Understand how students, individuals and businesses use the platform.
</p>

<a class="btn" href="/how-it-works.html">
How It Works
</a>

<a class="btn" href="/student-guide.html">
Student Guide
</a>

<a class="btn" href="/business-guide.html">
Business Guide
</a>

<a class="btn" href="/rewards-guide.html">
Rewards Guide
</a>

</div>

"""

if "LearnEarnHub Guide Center" not in s:

 s=s.replace(
 "<footer>",
 section+"<footer>"
 )

with open(p,"w",encoding="utf8") as f:
 f.write(s)

print("homepage updated")
PY


echo "=== Git Save ==="

git add public

git commit -m "Add LearnEarnHub Guide Center and onboarding pages" || true

git push


echo "DONE"
