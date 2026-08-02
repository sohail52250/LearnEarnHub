#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Certificate Download System ==="

mkdir -p public services api



cat > services/certificate-download-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createCertificate(user_id,course_id){


const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course_id);



const {count:done}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true);



if(total!==done){

return {
success:false,
message:"Course not completed"
};

}



const code=
"LEH-"+Date.now();



const {data,error}=await db
.from("certificates")
.upsert({

user_id,

course_id,

certificate_code:code,

issued_at:new Date()

},{
onConflict:"user_id,course_id"
})
.select()
.single();



if(error) throw error;



return {

success:true,

certificate:data

};


}



async function getCertificate(user_id){


const {data,error}=await db
.from("certificates")
.select(`
*,
courses(title_en)
`)
.eq("user_id",user_id);



if(error) throw error;


return data||[];

}



module.exports={
createCertificate,
getCertificate
};

JS



cat > api/certificate-download.js <<'JS'
const service=require("../services/certificate-download-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createCertificate(
req.body.user_id,
req.body.course_id
)
);

}



if(req.query.user_id){

return res.json(
await service.getCertificate(
req.query.user_id
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



if ! grep -q "certificate-download" server.js
then

cat >> server.js <<'JS'


// Certificate Download API

const certificateDownload=require("./api/certificate-download");

app.post(
"/api/certificate-download",
certificateDownload
);

app.get(
"/api/certificate-download",
certificateDownload
);

JS

fi



cat > public/certificates.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Certificates</title>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.card{
background:white;
padding:20px;
margin:15px;
border-radius:12px;
box-shadow:0 3px 10px #ccc;
}

</style>

</head>


<body>


<h1>🏆 My Certificates</h1>


<div id="list">

Loading...

</div>



<script>


const user_id=
new URLSearchParams(location.search)
.get("user_id");



async function load(){


const res=await fetch(
"/api/certificate-download?user_id="+user_id
);


const data=await res.json();



list.innerHTML=
data.length?

data.map(c=>`

<div class="card">

<h2>
${c.courses?.title_en || "Course"}
</h2>

<p>
Certificate Code:
${c.certificate_code}
</p>

<p>
Issued:
${c.issued_at}
</p>

</div>

`).join("")

:

"No certificates yet";


}


load();


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Certificate download system ready"

echo ""
echo "Page:"
echo "/certificates.html?user_id=USER_ID"


