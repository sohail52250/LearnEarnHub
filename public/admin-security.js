
function checkAdmin(){

const user =
JSON.parse(
localStorage.getItem("user")
);


if(!user){

window.location.href="/auth/sign-in.html";
return false;

}


if(user.role !== "admin"){

document.body.innerHTML =
`
<div class="card">
<h1>Access Denied</h1>
<p>Admin permission required.</p>
</div>
`;

return false;

}


return true;

}



async function createAdminLog(action,details){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("admin_logs")
.insert({

action:action,

details:details,

created_at:new Date()

});


}



window.checkAdmin=checkAdmin;
window.createAdminLog=createAdminLog;

