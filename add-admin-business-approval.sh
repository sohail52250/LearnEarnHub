#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Admin Business Approval Panel"
echo "======================================"


cat > api/admin-business-verification.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const {data,error}=await db

.from("business_verifications")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

data,

error

});


}



if(req.method==="POST"){


const {

id,

status,

trust_score,

admin_note

}=req.body;


const {data,error}=await db

.from("business_verifications")

.update({

status,

trust_score,

admin_note,

updated_at:new Date()

})

.eq("id",id)

.select();


if(status==="approved"){

await db

.from("business_profiles_complete")

.update({

verification_status:"verified"

})

.eq("user_id",data[0].user_id);

}


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



cat > public/admin-business-approval.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Admin Business Approval</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
}

button{
margin:5px;
padding:8px;
}

</style>

</head>


<body>


<h1>
Business Verification Requests
</h1>


<div id="list">
Loading...
</div>


<script>


fetch("/api/admin-business-verification")

.then(r=>r.json())

.then(d=>{


list.innerHTML=(d.data||[])

.map(b=>`

<div class="card">

<h3>
${b.company_name}
</h3>


<p>
Registration:
${b.registration_number}
</p>


<p>
Status:
${b.status}
</p>


<button onclick="approve('${b.id}')">
Approve
</button>


<button onclick="reject('${b.id}')">
Reject
</button>


</div>

`)

.join("");


});



async function approve(id){

await update(id,"approved",100);

alert("Business Approved");

location.reload();

}



async function reject(id){

await update(id,"rejected",0);

alert("Business Rejected");

location.reload();

}



async function update(id,status,score){


await fetch("/api/admin-business-verification",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

id,

status,

trust_score:score,

admin_note:"Reviewed by admin"

})

});


}


</script>


</body>

</html>
HTML



git add .

git commit -m "Add admin business verification approval panel" || true

git push


echo "======================================"
echo " Admin Approval Panel Added"
echo "======================================"

