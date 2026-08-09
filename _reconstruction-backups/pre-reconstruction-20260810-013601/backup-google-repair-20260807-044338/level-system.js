
function getLevel(xp){

if(xp < 100){
return {
level:1,
name:"Beginner"
};
}

if(xp < 500){
return {
level:2,
name:"Learner"
};
}

if(xp < 1000){
return {
level:3,
name:"Explorer"
};
}

if(xp < 2500){
return {
level:4,
name:"Skill Builder"
};
}

return {
level:5,
name:"Expert"
};

}


async function loadLevel(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();

if(!userData.user) return;


const {data}=await client
.from("profiles")
.select("xp")
.eq("id",userData.user.id)
.single();


const xp=data?.xp || 0;

const level=getLevel(xp);


const box=document.getElementById(
"level-display"
);


if(box){

box.innerHTML=
`
🏆 Level ${level.level}
<br>
<strong>${level.name}</strong>
<br>
⭐ ${xp} XP
`;

}

}


document.addEventListener(
"DOMContentLoaded",
loadLevel
);

