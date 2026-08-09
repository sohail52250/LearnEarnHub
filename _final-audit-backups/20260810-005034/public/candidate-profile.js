async function loadCandidate(){

const id =
new URLSearchParams(location.search)
.get("id");


if(!id) return;


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:profile}=await client
.from("profiles")
.select("xp,reward_units")
.eq("id",id)
.single();


const box=document.getElementById(
"candidate-box"
);


if(box){

box.innerHTML=`

<h2>
Verified Learner
</h2>

<p>
⭐ XP:
${profile?.xp || 0}
</p>

<p>
🎁 Reward Units:
${profile?.reward_units || 0}
</p>

<p>
✅ Learning profile available
</p>

`;

}

}


document.addEventListener(
"DOMContentLoaded",
loadCandidate
);
