
async function addXP(points){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user)return;


const user=userData.user.id;


const {data}=await client
.from("user_rewards")
.select("*")
.eq("user_id",user)
.single();


if(data){

await client
.from("user_rewards")
.update({

xp:data.xp + points,

updated_at:new Date()

})
.eq("user_id",user);


}else{


await client
.from("user_rewards")
.insert({

user_id:user,

xp:points,

badges:["First Step"],

streak:1

});


}


}



async function loadRewards(){

const box=document.getElementById(
"reward-box"
);


if(!box)return;


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

box.innerHTML="Login to view rewards";

return;

}


const {data}=await client
.from("user_rewards")
.select("*")
.eq("user_id",userData.user.id)
.single();


if(data){

box.innerHTML=
"⭐ XP: "+data.xp+
"<br>🏅 Badges: "+
data.badges.join(",")+
"<br>🔥 Streak: "+
data.streak;

}

}


document.addEventListener(
"DOMContentLoaded",
loadRewards
);

