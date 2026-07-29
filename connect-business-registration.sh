#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting Business Registration Flow ==="

# Backup files
cp public/business-register.js public/business-register.js.bak 2>/dev/null
cp public/business-register.html public/business-register.html.bak 2>/dev/null

cat > public/business-register.js <<'JS'
document
.getElementById("businessRegisterForm")
.addEventListener("submit", async function(e){

e.preventDefault();


const email =
document.getElementById("email").value;

const password =
document.getElementById("password").value;


const company =
document.getElementById("company_name").value;


const {data,error}=await supabaseClient.auth.signUp({

email,
password

});


if(error){

document.getElementById("status").innerHTML=
"❌ "+error.message;

return;

}


const user=data.user;


if(user){

const {error:profileError}=await supabaseClient
.from("business_profiles")
.insert({

owner_id:user.id,

company_name:company,

verified:false

});


if(profileError){

document.getElementById("status").innerHTML=
"❌ "+profileError.message;

return;

}


document.getElementById("status").innerHTML=
"✅ Business account created. Redirecting...";


setTimeout(()=>{

location.href="/business-dashboard.html";

},1500);


}

});
JS


# Add Supabase scripts if missing

grep -q "supabase-config.js" public/business-register.html || \
sed -i '/<\/head>/i\
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>\
<script src="/supabase-config.js"></script>' public/business-register.html


echo "=== Business registration connected ==="

