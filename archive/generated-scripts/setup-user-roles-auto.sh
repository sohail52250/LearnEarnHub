#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub User Roles System Setup ==="

mkdir -p services api public/admin



cat > database/user-roles.sql <<'SQL'

CREATE TABLE IF NOT EXISTS user_roles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

role TEXT DEFAULT 'learner',

created_at TIMESTAMP DEFAULT NOW(),

updated_at TIMESTAMP DEFAULT NOW()

);


CREATE INDEX IF NOT EXISTS user_roles_user_idx
ON user_roles(user_id);

SQL



cat > services/user-role-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getUsers(){


const {data,error}=await db
.from("profiles")
.select(`
user_id,
full_name,
bio
`);


if(error) throw error;


return data || [];

}



async function getRole(user_id){


const {data,error}=await db
.from("user_roles")
.select("*")
.eq("user_id",user_id)
.single();



if(error && error.code!=="PGRST116")
throw error;


return data || {
role:"learner"
};

}



async function updateRole(user_id,role){


const {data,error}=await db
.from("user_roles")
.upsert({

user_id,

role,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return data;

}



module.exports={
getUsers,
getRole,
updateRole
};

JS



cat > api/admin-users.js <<'JS'
const service=require("../services/user-role-service");


module.exports=async function(req,res){

try{


if(req.query.action==="users"){

return res.json(
await service.getUsers()
);

}



if(req.query.action==="role"){

return res.json(
await service.getRole(
req.query.user_id
)
);

}



if(req.body.action==="update-role"){

return res.json(
await service.updateRole(
req.body.user_id,
req.body.role
)
);

}



res.status(400).json({
error:"Invalid request"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/admin-users" server.js
then

cat >> server.js <<'JS'


// Admin User Management API

const adminUsers=require("./api/admin-users");

app.get(
"/api/admin-users",
adminUsers
);

app.post(
"/api/admin-users",
adminUsers
);

JS

fi



cat > public/admin/users.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>User Management</title>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.card{

background:white;
padding:15px;
margin:10px;
border-radius:10px;

}

button{

background:#1565c0;
color:white;
border:0;
padding:8px;

}

</style>

</head>


<body>


<h1>👥 User Management</h1>


<div id="users">
Loading...
</div>



<script>


async function loadUsers(){


let res=
await fetch(
"/api/admin-users?action=users"
);


let users=
await res.json();



document.getElementById("users")
.innerHTML=users.map(u=>`

<div class="card">

<b>
${u.full_name || "User"}
</b>

<br>

ID:
${u.user_id}

<br><br>


<button onclick="makeAdmin('${u.user_id}')">

Make Admin

</button>


</div>

`).join("");

}



async function makeAdmin(id){


await fetch(
"/api/admin-users",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"update-role",

user_id:id,

role:"admin"

})

});


alert("Role updated ✅");

}



loadUsers();


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ User roles system created"

echo ""
echo "SQL:"
echo "database/user-roles.sql"

echo ""
echo "Admin page:"
echo "/admin/users.html"


