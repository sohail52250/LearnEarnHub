#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Achievement Dashboard"
echo "======================================"

echo ""
echo "1) Create learner achievement page"

cat > public/achievement-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Achievements - LearnEarnHub</title>
</head>

<body>

<h1>🏆 Achievements / کامیابیاں</h1>

<h2 id="status">Loading...</h2>

<h3>Certificates</h3>
<div id="certificates"></div>

<h3>Skills</h3>
<div id="skills"></div>

<script>

const user_id =
localStorage.getItem("user_id") ||
"3ddc5d80-b236-43d4-ace5-d8ff4e7a6c47";


async function loadData(){

let cert =
await fetch("/api/certificate?user_id="+user_id);

let certData =
await cert.json();


document.getElementById("certificates")
.innerText =
JSON.stringify(certData.data || [],null,2);



let skills =
await fetch("/api/skills");

let skillsData =
await skills.json();


document.getElementById("skills")
.innerText =
JSON.stringify(skillsData.data || [],null,2);



let unlock =
await fetch("/api/earning-unlock?user_id="+user_id);

let unlockData =
await unlock.json();


document.getElementById("status")
.innerText =
unlockData.message;


}


loadData();

</script>

</body>
</html>
HTML


echo ""
echo "2) Add page test"

curl -I -s https://learn-earnhub.vercel.app/achievement-dashboard.html | head -1


echo ""
echo "3) Save"

git add public/achievement-dashboard.html

git commit -m "Add learner achievement dashboard" || true

git push


echo ""
echo "4) Deployment check"

sleep 5

curl -I -s https://learn-earnhub.vercel.app/achievement-dashboard.html | head -1


echo ""
echo "======================================"
echo " ACHIEVEMENT DASHBOARD READY"
echo "======================================"

