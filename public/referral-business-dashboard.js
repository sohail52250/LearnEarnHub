async function loadBusinessReferrals(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user)return;


const {data}=await client
.select("*")
.eq(
"referrer_user_id",
userData.user.id
);



const box=document.getElementById(
"referrals"
);



if(!data || !data.length){

box.innerHTML=
"No referrals yet.";

return;

}



box.innerHTML=data.map(r=>`

<div class="card">

<p>
Business Verification
</p>

<p>
Status:
${r.status}
</p>

</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadBusinessReferrals
);
