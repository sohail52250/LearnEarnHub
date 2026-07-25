async function loadBusinessTrust(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();

if(!userData.user)return;


const {data:referrals}=await client
.from("business_referrals")
.select("*")
.eq(
"referrer_user_id",
userData.user.id
);



let score=0;


if(referrals){

referrals.forEach(r=>{

if(r.status==="approved"){

score += 20;

}

});

}



const box=document.getElementById(
"business-trust-score"
);



if(box){

box.innerHTML=`

<h3>
🤝 Business Trust Score
</h3>

<p>
⭐ ${score}/100
</p>

<p>
Verified referrals increase your reputation.
</p>

`;

}


}


document.addEventListener(
"DOMContentLoaded",
loadBusinessTrust
);
