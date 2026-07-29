async function getUserRole(userId){

const result = await fetch(
`${SUPABASE_URL}/rest/v1/user_roles?user_id=eq.${userId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());


if(!result.length){
return null;
}


return result[0].role;

}



async function requireRole(allowedRoles){

const user =
JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

alert("Login required");

window.location.href="/login.html";

return false;

}


const role =
await getUserRole(user.id);


if(!allowedRoles.includes(role)){

alert("Access denied");

window.location.href="/index.html";

return false;

}


return true;

}


window.getUserRole=getUserRole;
window.requireRole=requireRole;
