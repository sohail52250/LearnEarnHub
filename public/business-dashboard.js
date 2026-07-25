async function loadCandidates(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:users,error}=await client
.from("profiles")
.select("id,xp,reward_units")
.order("xp",{ascending:false})
.limit(20);


const box=document.getElementById(
"candidates"
);


if(!box) return;


if(error || !users){

box.innerHTML="No candidates found";

return;

}


box.innerHTML=users.map(user=>`

<div class="card">

<h2>
👤 Learner
</h2>


<p>
⭐ XP:
${user.xp || 0}
</p>


<p>
🎁 Rewards:
${user.reward_units || 0}
</p>


<p>
🏅 Skill Status:
Learning Progress Available
</p>


<a href="/candidate-profile.html?id=${user.id}">

<button>
View Profile
</button>

</a>


</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadCandidates
);
