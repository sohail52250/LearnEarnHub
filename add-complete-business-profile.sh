#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Complete Business Profile"
echo "======================================"


cat > database/business-profile-complete.sql <<'SQL'

CREATE TABLE IF NOT EXISTS business_profiles_complete(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid UNIQUE,

company_name text,
logo text,

owner_name text,
email text,
phone text,

category text,

description text,
about_company text,

services text,
products text,

experience text,

team_size text,

city text,
country text,
address text,

website text,
facebook text,
linkedin text,

registration_number text,

verification_status text DEFAULT 'pending',

portfolio text,

created_at timestamp DEFAULT now(),
updated_at timestamp DEFAULT now()

);

SQL



echo "Creating API..."


cat > api/business-profile-complete.js <<'JS'

const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const user_id=req.query.user_id;


const {data,error}=await db

.from("business_profiles_complete")

.select("*")

.eq("user_id",user_id)

.single();


return res.json({

success:!error,

profile:data,

error

});


}



if(req.method==="POST"){


const profile=req.body;


const {data,error}=await db

.from("business_profiles_complete")

.upsert([profile])

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



echo "Creating business profile page..."


cat > public/business-profile-complete.html <<'HTML'

<!DOCTYPE html>
<html>

<head>

<title>Business Profile</title>

<meta charset="UTF-8">

<style>

input,textarea{
width:100%;
padding:10px;
margin:5px;
}

button{
padding:12px;
}

</style>

</head>


<body>


<h1>
Complete Business Profile
</h1>


<form id="businessForm">


<input id="company_name" placeholder="Company Name">

<input id="logo" placeholder="Logo URL">

<input id="owner_name" placeholder="Owner Name">

<input id="email" placeholder="Email">

<input id="phone" placeholder="Phone">


<input id="category" placeholder="Business Category">


<textarea id="description" placeholder="Short Description"></textarea>


<textarea id="about_company" placeholder="About Company"></textarea>


<textarea id="services" placeholder="Services"></textarea>


<textarea id="products" placeholder="Products"></textarea>


<textarea id="experience" placeholder="Business Experience"></textarea>


<input id="team_size" placeholder="Team Size">


<input id="city" placeholder="City">


<input id="country" placeholder="Country">


<input id="address" placeholder="Address">


<input id="website" placeholder="Website">


<input id="linkedin" placeholder="LinkedIn">


<input id="facebook" placeholder="Facebook">


<input id="registration_number" placeholder="Registration Number">


<textarea id="portfolio" placeholder="Portfolio"></textarea>


<button>
Save Business Profile
</button>


</form>



<script>


businessForm.onsubmit=async(e)=>{

e.preventDefault();


let data={

user_id:localStorage.getItem("user_id"),

company_name:company_name.value,

logo:logo.value,

owner_name:owner_name.value,

email:email.value,

phone:phone.value,

category:category.value,

description:description.value,

about_company:about_company.value,

services:services.value,

products:products.value,

experience:experience.value,

team_size:team_size.value,

city:city.value,

country:country.value,

address:address.value,

website:website.value,

linkedin:linkedin.value,

facebook:facebook.value,

registration_number:registration_number.value,

portfolio:portfolio.value

};


let r=await fetch("/api/business-profile-complete",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify(data)

});


let result=await r.json();


alert(
result.success?
"Business Profile Saved":
"Error"
);


};


</script>


</body>

</html>

HTML



git add .

git commit -m "Add complete business profile system" || true

git push


echo "======================================"
echo " Complete Business Profile Added"
echo "======================================"

