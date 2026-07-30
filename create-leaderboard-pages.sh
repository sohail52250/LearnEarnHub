
#!/data/data/com.termux/files/usr/bin/bash

cat > public/leaderboards.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Leaderboards</title>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>
</head>
<body>

<h1>🏆 Leaderboards</h1>

<h2>🎓 Top Learners</h2>
<div id="top-learners">Loading...</div>

<h2>🏢 Top Businesses</h2>
<div id="top-businesses">Loading...</div>

<script src="/leaderboards.js"></script>

</body>
</html>
HTML


cat > public/leaderboards.js <<'JS'

const client=supabaseClient;

async function loadLeaderboards(){

// Top learners by XP

const {data:learners}=await client
.from("learner_stats")
.select("*")
.order("xp",{ascending:false})
.limit(10);


document.getElementById("top-learners").innerHTML=

(learners||[]).map((l,i)=>`

<p>

${i+1}.
Level ${l.level}
-
XP ${l.xp}

</p>

`).join("")

||
"No learner data";



// Top businesses by trust score

const {data:businesses}=await client
.from("business_trust_scores")
.select("*")
.order("trust_score",{ascending:false})
.limit(10);


document.getElementById("top-businesses").innerHTML=

(businesses||[]).map((b,i)=>`

<p>

${i+1}.
Trust Score:
${b.trust_score}

</p>

`).join("")

||
"No business data";

}

document.addEventListener(
"DOMContentLoaded",
loadLeaderboards
);

JS

echo "Leaderboards created"

