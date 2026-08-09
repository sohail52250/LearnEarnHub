async function loadXP(){

const client = supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:userData} = await client.auth.getUser();

if(!userData.user) return;

const {data} = await client
.from("profiles")
.select("xp")
.eq("id", userData.user.id)
.single();

const box = document.getElementById("xp-display");

if(box){
box.innerText = (data?.xp || 0) + " XP";
}

}

document.addEventListener(
"DOMContentLoaded",
loadXP
);
