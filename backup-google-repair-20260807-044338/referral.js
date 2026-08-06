async function loadReferralCode(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const lang =
localStorage.getItem("language") || "en";


const translationResponse =
await fetch(`/translations/rewards-${lang}.json`);


const t =
await translationResponse.json();


const {data:userData}=await client.auth.getUser();

if(!userData.user) return;


const user=userData.user;


let {data}=await client
.from("referral_codes")
.select("*")
.eq("user_id",user.id)
.single();


if(!data){

const code =
"LEH"+
user.id.replace(/-/g,'').substring(0,8);


await client
.from("referral_codes")
.insert({
user_id:user.id,
referral_code:code
});


data={
referral_code:code
};

}


const link =
window.location.origin+
"/register.html?ref="+
data.referral_code;


const box =
document.getElementById("referral-box");


if(box){

box.innerHTML=`

<h3>
🎁 ${t.invite || "Invite Friends"}
</h3>

<p>
${t.share_message || "Share your invite link and earn rewards."}
</p>


<input
value="${link}"
readonly
style="width:100%;padding:8px;">


<br><br>


<button onclick="navigator.clipboard.writeText('${link}')">

${t.copy_link || "Copy Invite Link"}

</button>

`;

}

}


document.addEventListener(
"DOMContentLoaded",
loadReferralCode
);
