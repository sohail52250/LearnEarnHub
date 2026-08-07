


async function getUserLevel(xp){

const lang =
localStorage.getItem("language") || "en";

const response =
await fetch(`/translations/levels-${lang}.json`);

const t =
response.ok ? await response.json() : {};

let key="beginner";
let number=1;

if(xp < 100){
key="beginner";
number=1;
}
else if(xp < 500){
key="learner";
number=2;
}
else if(xp < 1000){
key="explorer";
number=3;
}
else if(xp < 2500){
key="skill_builder";
number=4;
}
else{
key="expert";
number=5;
}

return `Level ${number} - ${t[key] || key}`;

}

async function loadProgressSummary(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const lang =
localStorage.getItem("language") || "en";


const response =
await fetch(`/translations/progress-summary-${lang}.json`);

const t =
response.ok ? await response.json() : {};


const {data:userData}=await client.auth.getUser();

if(!userData.user) return;


const userId=userData.user.id;


// Profile data

const {data:profile}=await client
.from("profiles")
.select("xp,reward_units")
.eq("id",userId)
.single();


// Badges

const {data:badges}=await client
.from("badges")
.select("id")
.eq("user_id",userId);


// Certificates

const {data:certificates}=await client
.from("certificates")
.select("id")
.eq("user_id",userId);


// Progress

const {data:progress}=await client
.from("lesson_progress")
.select("id")
.eq("user_id",userId);



const box=
document.getElementById("progress-summary");


if(box){

box.innerHTML=`

<h2>
ðŸ† ${t.title || "Learning Progress Summary"}
</h2>


<p>
â­ ${t.xp || "Experience Points"}:
${profile?.xp || 0}
</p>


<p>
ðŸ… ${t.level || "Current Level"}:
<span id="summary-level">
Loading...
</span>
</p>


<p>
ðŸŽ–ï¸ ${t.badges || "Badges"}:
${badges?.length || 0}
</p>


<p>
📄œ ${t.certificates || "Certificates"}:
${certificates?.length || 0}
</p>


<p>
📚 ${t.courses || "Courses Progress"}:
${progress?.length || 0}
</p>

`;

}

const levelText =
await getUserLevel(profile?.xp || 0);

const levelBox =
document.getElementById("summary-level");

if(levelBox){
levelBox.innerHTML = levelText;
}

}


document.addEventListener(
"DOMContentLoaded",
loadProgressSummary
);



