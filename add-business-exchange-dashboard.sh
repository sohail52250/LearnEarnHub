#!/data/data/com.termux/files/usr/bin/bash

cat > public/business-exchange-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Business Exchange Dashboard</title>
<meta charset="UTF-8">
<style>
.card{
border:1px solid #ddd;
padding:20px;
margin:10px;
border-radius:12px;
}
</style>
</head>

<body>

<h1>🏢 Business Exchange Dashboard</h1>

<div class="card">🏷 Sell Business</div>
<div class="card">🔎 Buy Business</div>
<div class="card">🤝 Acquisition</div>
<div class="card">🔗 Merger</div>
<div class="card">🌐 Partnership</div>
<div class="card">📂 Due Diligence</div>
<div class="card">📄 Contracts</div>
<div class="card">📊 Deal Progress</div>

</body>
</html>
HTML


git add .
git commit -m "Add Business Exchange Dashboard" || true
git push

echo "Business Exchange Dashboard Added"

