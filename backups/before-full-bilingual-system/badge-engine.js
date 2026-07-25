
async function awardBadge(userId,badge){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("user_badges")
.upsert({

user_id:userId,

badge:badge

});


await client
.from("achievements")
.upsert({

user_id:userId,

achievement:badge

});

}



async function checkBadges(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();

if(!userData.user) return;


const userId=userData.user.id;



// Lesson badge

const {data:lessons}=await client
.from("lesson_progress")
.select("*")
.eq("user_id",userId);



if(lessons && lessons.length >= 1){

await awardBadge(
userId,
"🎓 First Lesson Complete"
);

}


if(lessons && lessons.length >= 5){

await awardBadge(
userId,
"📚 Learning Explorer"
);

}



// Certificate badge

const {data:certs}=await client
.from("certificates")
.select("*")
.eq("user_id",userId);


if(certs && certs.length >= 1){

await awardBadge(
userId,
"🏆 Certificate Master"
);

}



// Referral badge

const {data:refs}=await client
.from("referrals")
.select("*")
.eq("referrer_user_id",userId)
.eq("rewarded",true);



if(refs && refs.length >= 5){

await awardBadge(
userId,
"🎁 Referral Ambassador"
);

}


}


document.addEventListener(
"DOMContentLoaded",
checkBadges
);

