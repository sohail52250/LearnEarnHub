
function requireRole(requiredRole){

const user =
JSON.parse(
localStorage.getItem("user")
);


if(!user || user.role !== requiredRole){

document.body.innerHTML =
`
<div class="card">

<h1>Access Restricted</h1>

<p>
You do not have permission for this area.
</p>

</div>
`;

return false;

}


return true;

}


window.requireRole=requireRole;

