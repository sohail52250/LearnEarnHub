async function loadRewardDisplay(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const lang =
localStorage.getItem("language") || "en";


const tResponse =
await fetch(`/translations/reward-box-${lang}.json`);

const t = tResponse.ok
? await tResponse.json()
: {
title:"My Rewards",
xp:"Experience Points",
units:"Reward Points",
progress:"Keep learning to unlock more rewards."
};


const {data:userData}=await client.auth.getUser();

if(!userData.user) return;


const {data:profile}=await client
.from("profiles")
.select("xp,reward_units")
.eq("id",userData.user.id)
.single();


if(!profile) return;


const box=document.getElementById("reward-box");


if(box){

box.innerHTML=`

<h3>
🏆 ${t.title}
</h3>

<p>
⭐ ${t.xp}: ${profile.xp || 0}
</p>

<p>
🎁 ${t.units}: ${profile.reward_units || 0}
</p>

<small>
${t.progress}
</small>

`;

}

}


document.addEventListener(
"DOMContentLoaded",
loadRewardDisplay
);
