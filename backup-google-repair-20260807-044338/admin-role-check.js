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
