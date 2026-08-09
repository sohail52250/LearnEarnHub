
async function loadBadges(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();

if(!userData.user) return;


const {data}=await client
.from("user_badges")
.select("*")
.eq("user_id",userData.user.id);


const box=document.getElementById(
"badge-display"
);


if(box){

if(!data || data.length===0){

box.innerHTML="No badges yet";

return;

}


box.innerHTML=data
.map(b=>"🏅 "+b.badge)
.join("<br>");

}

}


document.addEventListener(
"DOMContentLoaded",
loadBadges
);

