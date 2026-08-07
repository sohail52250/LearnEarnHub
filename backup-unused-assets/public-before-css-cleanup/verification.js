async function loadVerification(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user)return;


const {data:business}=await client
.from("business_profiles")
.select("verified")
.eq("user_id",userData.user.id)
.single();



const {data:profile}=await client
.from("profiles")
.select("xp")
.eq("id",userData.user.id)
.single();



const box=document.getElementById(
"verification-status"
);



if(!box)return;


let html="";


if(business?.verified){

html += `
<p>
✅ Verified Business
</p>
`;

}


if((profile?.xp || 0) >= 500){

html += `
<p>
🎓 Verified Learner
</p>
`;

}


if(!html){

html =
`
<p>
⏳ Verification pending
</p>
`;

}


box.innerHTML=html;


}


document.addEventListener(
"DOMContentLoaded",
loadVerification
);
