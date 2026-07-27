#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Business Verification System"
echo "======================================"


cat > database/business-verification.sql <<'SQL'

CREATE TABLE IF NOT EXISTS business_verifications(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

company_name text,

registration_number text,

document_url text,

status text DEFAULT 'pending',

trust_score integer DEFAULT 0,

admin_note text,

created_at timestamp DEFAULT now(),

updated_at timestamp DEFAULT now()

);

SQL



cat > api/business-verification.js <<'JS'

const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const user_id=req.query.user_id;


const {data,error}=await db

.from("business_verifications")

.select("*")

.eq("user_id",user_id);


return res.json({

success:true,

data,

error

});


}



if(req.method==="POST"){


const {

user_id,

company_name,

registration_number,

document_url

}=req.body;


const {data,error}=await db

.from("business_verifications")

.insert([{

user_id,

company_name,

registration_number,

document_url

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



cat > public/business-verification.html <<'HTML'

<!DOCTYPE html>
<html>

<head>

<title>Business Verification</title>

<meta charset="UTF-8">

</head>


<body>


<h1>
Business Verification Request
</h1>


<form id="verifyForm">


<input id="company_name"
placeholder="Company Name">


<input id="registration_number"
placeholder="Registration Number">


<input id="document_url"
placeholder="Document URL">


<button>
Submit Verification
</button>


</form>



<script>


verifyForm.onsubmit=async(e)=>{

e.preventDefault();


let body={

user_id:localStorage.getItem("user_id"),

company_name:company_name.value,

registration_number:registration_number.value,

document_url:document_url.value

};


let r=await fetch("/api/business-verification",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify(body)

});


alert("Verification submitted");


};


</script>


</body>

</html>

HTML



echo "Updating public profile badge..."


python - <<'PY'

p="public/public-business-profile.html"

try:

 s=open(p).read()

 s=s.replace(
 "${p.verification_status==\"verified\"?\n\"✅ Verified Business\":\n\"⏳ Verification Pending\"}",
 "${p.verification_status==\"verified\"?\n\"🏆 Verified Business\":\n\"⏳ Verification Pending\"}"
 )

 open(p,"w").write(s)

except Exception as e:
 print(e)

PY



git add .

git commit -m "Add business verification and trust badge system" || true

git push


echo "======================================"
echo " Verification System Added"
echo "======================================"

