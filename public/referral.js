async function loadReferralCode(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:userData}=await client.auth.getUser();

if(!userData.user) return;

const user=userData.user;

let {data}=await client
.from("referral_codes")
.select("*")
.eq("user_id",user.id)
.single();

if(!data){

const code=
"LEH"+
user.id.replace(/-/g,'').substring(0,8);

await client
.from("referral_codes")
.insert({
user_id:user.id,
referral_code:code
});

data={referral_code:code};

}

const link=
window.location.origin+
"/register.html?ref="+
data.referral_code;

const box=document.getElementById("referral-box");

if(box){

box.innerHTML=`
<h3>🎁 Invite Friends</h3>
<p>Your Referral Code:</p>
<p><strong>${data.referral_code}</strong></p>

<input
value="${link}"
readonly
style="width:100%;padding:8px;">

<br><br>

<button onclick="navigator.clipboard.writeText('${link}')">
Copy Referral Link
</button>
`;

}

}

document.addEventListener(
"DOMContentLoaded",
loadReferralCode
);
