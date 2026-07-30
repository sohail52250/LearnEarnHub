
#!/data/data/com.termux/files/usr/bin/bash


cat > public/reputation-center.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Reputation Center</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>

<body>

<h1>⭐ Reputation Center</h1>

<div id="reputation">
Loading...
</div>

<script src="/reputation-center.js"></script>

</body>

</html>
HTML



cat > public/reputation-center.js <<'JS'

const client=supabaseClient;


async function loadReputation(){


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.body.innerHTML=
"Please login";

return;

}



const {data:stats}=await client

.from("learner_stats")

.select("*")

.eq("user_id",user.id)

.single();



const {data:badges}=await client

.from("learner_badges")

.select("*")

.eq("user_id",user.id);



const {data:trust}=await client

.from("business_trust_scores")

.select("*")

.eq("user_id",user.id)

.single();



const {data:rep}=await client

.from("entity_reputation")

.select("*")

.eq("entity_id",user.id)

.single();



let html="";


if(stats){

html+=`

<h2>🎓 Learner Profile</h2>

<p>XP: ${stats.xp || 0}</p>

<p>Level: ${stats.level || 1}</p>

<p>Certificates: ${stats.certificates || 0}</p>

<p>Completed Courses: ${stats.completed_courses || 0}</p>

<p>Completed Lessons: ${stats.completed_lessons || 0}</p>

<p>Badges: ${stats.badges || 0}</p>

`;

}



if(badges){

html+=`

<h2>🏅 Earned Badges</h2>

`;

badges.forEach(b=>{

html+=`<p>${b.badge_name}</p>`;

});

}



if(trust){

html+=`

<h2>🏢 Business Trust</h2>

<p>Trust Score:
${trust.trust_score || 0}
</p>

<p>Approved Referrals:
${trust.approved_referrals || 0}
</p>

`;

}



if(rep){

let successRate=0;

if(rep.total_deals>0){

successRate=
Math.round(
(rep.successful_deals*100)
/rep.total_deals
);

}



html+=`

<h2>🤝 Deal Reputation</h2>

<p>Total Deals:
${rep.total_deals}
</p>

<p>Successful Deals:
${rep.successful_deals}
</p>

<p>Success Rate:
${successRate}%
</p>

<p>Rating:
${rep.rating}
</p>

`;

}



document.getElementById(
"reputation"
).innerHTML=

html ||

"No reputation data available";


}



document.addEventListener(
"DOMContentLoaded",
loadReputation
);

JS


echo "Reputation Center created"

