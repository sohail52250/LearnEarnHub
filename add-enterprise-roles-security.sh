#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise Roles & Security System"
echo "======================================"


cat > database/enterprise-roles.sql <<'SQL'

CREATE TABLE IF NOT EXISTS enterprise_roles(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

user_id uuid,

role text DEFAULT 'employee',

permissions text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_activity_logs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

user_id uuid,

action text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/enterprise-roles.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const {data,error}=await db

.from("enterprise_roles")

.select("*")

.eq("enterprise_id",enterprise_id);


return res.json({

success:true,

roles:data||[],

error

});


}



if(req.method==="POST"){


const {

enterprise_id,

user_id,

role,

permissions

}=req.body;


const {data,error}=await db

.from("enterprise_roles")

.upsert([{

enterprise_id,

user_id,

role,

permissions

}])

.select();


return res.json({

success:!error,

data,

error

});


}


res.status(405).json({

error:"Method not allowed"

});


};
JS



cat > public/enterprise-role-manager.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Role Manager</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:10px;
}

</style>

</head>


<body>


<h1>
Enterprise User Roles
</h1>


<div class="card">

<form id="roleForm">


<input id="user_id"
placeholder="User ID">


<select id="role">

<option>owner</option>
<option>hr_manager</option>
<option>trainer</option>
<option>finance</option>
<option>employee</option>

</select>


<input id="permissions"
placeholder="Permissions">


<button>
Save Role
</button>


</form>

</div>



<script>


roleForm.onsubmit=async(e)=>{

e.preventDefault();


await fetch("/api/enterprise-roles",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

enterprise_id:
localStorage.getItem("enterprise_id"),

user_id:user_id.value,

role:role.value,

permissions:permissions.value

})

});


alert("Role saved");

};


</script>


</body>

</html>
HTML



git add .

git commit -m "Add enterprise security roles and permissions" || true

git push


echo "======================================"
echo " Enterprise Security Added"
echo "======================================"

