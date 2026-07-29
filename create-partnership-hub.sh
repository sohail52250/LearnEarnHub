#!/data/data/com.termux/files/usr/bin/bash

mkdir -p public

# partnerships.html
cat > public/partnerships.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Partnership Hub - LearnEarnHub</title>
<link rel="stylesheet" href="/assets/css/learn-earnhub-ui.css">
</head>
<body>
<div id="global-header"></div>

<div class="card">
<h1>🤝 Partnership Hub</h1>
<p>Collaborate with LearnEarnHub as a business, trainer, NGO, recruiter, sponsor, or affiliate.</p>

<form id="partnerForm">
<input type="text" id="name" placeholder="Organization / Person Name" required><br><br>

<input type="email" id="email" placeholder="Email Address" required><br><br>

<input type="text" id="type" placeholder="Partnership Type" required><br><br>

<textarea id="details" placeholder="Describe your proposal" rows="6" required></textarea><br><br>

<button type="submit">Submit Partnership Request</button>
</form>

<div id="status"></div>
</div>

<div id="global-footer"></div>

<script src="/global-layout.js"></script>
<script src="/partnerships.js"></script>
</body>
</html>
HTML

# partnerships.js
cat > public/partnerships.js <<'JS'
document.getElementById("partnerForm").addEventListener("submit", function(e){
e.preventDefault();

const data = {
name: document.getElementById("name").value,
email: document.getElementById("email").value,
type: document.getElementById("type").value,
details: document.getElementById("details").value,
date: new Date().toISOString()
};

let requests = JSON.parse(localStorage.getItem("partnership_requests") || "[]");
requests.push(data);
localStorage.setItem("partnership_requests", JSON.stringify(requests));

document.getElementById("status").innerHTML =
"<p>✅ Partnership request submitted successfully.</p>";

document.getElementById("partnerForm").reset();
});
JS

echo "Partnership Hub created."
