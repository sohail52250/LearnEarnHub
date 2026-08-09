async function loadRealLearner(){

const user = JSON.parse(
localStorage.getItem("user")
|| "null"
);


if(!user){

document.getElementById("skills").innerHTML =
"Please login first";

return;

}


const profile = await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles?user_id=eq.${user.id}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
)
.then(r=>r.json());


if(!profile.length){

document.getElementById("skills").innerHTML =
"No learning profile found";

return;

}


const learner = profile[0];


let skills = learner.skills || [];


document.getElementById("skills").innerHTML =
skills.length
? skills.map(s=>"✅ "+s).join("<br>")
: "Complete courses to unlock skills";


document.getElementById("score").innerText =
(learner.career_score || 0)+"/100";


if(window.findOpportunityMatches){

let matches =
await findOpportunityMatches(user.id);


document.getElementById("matches").innerHTML =
matches.length
?
matches.map(
m=>`⭐ ${m.title} (${m.score}% match)`
).join("<br>")
:
"No matching opportunities yet";

}


}


window.loadRealLearner=loadRealLearner;
