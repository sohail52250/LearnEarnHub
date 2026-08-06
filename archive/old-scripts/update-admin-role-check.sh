#!/data/data/com.termux/files/usr/bin/bash

echo "Updating admin role verification..."

cat > public/admin-role-check.js <<'JS'
async function verifyAdmin(){

const {data:{session}} = await supabaseClient.auth.getSession();

if(!session){
    location.href="/admin-login.html";
    return false;
}

const {data,error}=await supabaseClient
.from("admin_users")
.select("*")
.eq("id",session.user.id)
.single();


if(error || !data || data.role!=="admin"){

    await supabaseClient.auth.signOut();

    alert("Access denied");

    location.href="/admin-login.html";

    return false;
}


return true;

}
JS


python - <<'PY'
p="public/admin-partnerships.js"

s=open(p).read()

if 'admin-role-check.js' not in s:
    print("Remember to include admin-role-check.js in admin page")

open(p,"w").write(s)

PY


python - <<'PY'
p="public/admin-partnerships.html"

s=open(p).read()

if "admin-role-check.js" not in s:
    s=s.replace(
    '<script src="/admin-partnerships.js"></script>',
    '<script src="/admin-role-check.js"></script>\n<script src="/admin-partnerships.js"></script>'
    )

open(p,"w").write(s)

PY

echo "Admin role verification added."
