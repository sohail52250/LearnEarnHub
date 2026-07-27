#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise Registration + HR Panel"
echo "======================================"


cat > api/enterprise-register.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="POST"){


const {
user_id,
company_name,
industry,
description,
website,
email,
phone,
city,
country,
employees
}=req.body;


const {data,error}=await db
.from("enterprises")
.insert([{

user_id,
company_name,
industry,
description,
website,
email,
phone,
city,
country,
employees

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



cat > api/enterprise-employees.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const {data,error}=await db
.from("enterprise_employees")
.select("*")
.eq("enterprise_id",enterprise_id);


return res.json({

success:true,

data,

error

});


}



if(req.method==="POST"){


const {
enterprise_id,
employee_id,
role
}=req.body;


const {data,error}=await db
.from("enterprise_employees")
.insert([{

enterprise_id,
employee_id,
role

}])
.select();


return res.json({

success:!error,

data,

error

});


}


};
JS



cat > public/enterprise-register.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Registration</title>

<meta charset="UTF-8">

</head>


<body>


<h1>
Enterprise Registration
</h1>


<form id="form">


<input id="company_name" placeholder="Company Name">

<input id="industry" placeholder="Industry">


<textarea id="description"
placeholder="Company Description"></textarea>


<input id="website" placeholder="Website">


<input id="email" placeholder="Email">


<input id="phone" placeholder="Phone">


<input id="city" placeholder="City">


<input id="country" placeholder="Country">


<input id="employees" placeholder="Number of Employees">


<button>
Register Enterprise
</button>


</form>



<script>


form.onsubmit=async(e)=>{

e.preventDefault();


await fetch("/api/enterprise-register",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

user_id:localStorage.getItem("user_id"),

company_name:company_name.value,

industry:industry.value,

description:description.value,

website:website.value,

email:email.value,

phone:phone.value,

city:city.value,

country:country.value,

employees:employees.value

})


});


alert("Enterprise registered");


};


</script>


</body>

</html>
HTML



cat > public/enterprise-admin.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise HR Panel</title>

</head>


<body>


<h1>
Enterprise HR/Admin Panel
</h1>


<div id="panel">

Manage employees and training

</div>


</body>

</html>
HTML



git add .

git commit -m "Add enterprise registration and HR admin panel" || true

git push


echo "======================================"
echo " Enterprise HR Panel Added"
echo "======================================"

