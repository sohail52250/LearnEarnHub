#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Auto Supabase Auth Connect ==="

if [ ! -f .env ]; then
 echo "❌ .env not found"
 exit 1
fi


URL=$(grep SUPABASE_URL .env | cut -d '=' -f2)
ANON=$(grep SUPABASE_ANON_KEY .env | cut -d '=' -f2)


if [ -z "$URL" ] || [ -z "$ANON" ]; then
 echo "❌ SUPABASE_URL or SUPABASE_ANON_KEY missing in .env"
 echo "Add them first"
 exit 1
fi


mkdir -p public/js


cat > public/js/supabase-config.js <<JS
window.SUPABASE_URL="$URL";
window.SUPABASE_ANON_KEY="$ANON";

window.supabaseClient = supabase.createClient(
 window.SUPABASE_URL,
 window.SUPABASE_ANON_KEY
);
JS


echo "✅ Supabase config connected"


cat > public/js/dashboard-auth.js <<'JS'
async function requireUser(){

const {data,error}=await supabaseClient.auth.getUser();

if(error || !data.user){

window.location="/login.html";

return null;

}

return data.user;

}


async function showUser(){

const user=await requireUser();

if(user){

const box=document.getElementById("user-email");

if(box){
box.innerText=user.email;
}

}

}


showUser();

JS


echo "✅ Real user authentication connected"

echo ""
echo "Files updated:"
echo "public/js/supabase-config.js"
echo "public/js/dashboard-auth.js"

