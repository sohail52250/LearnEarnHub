
async function verifyCertificate(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


let id=document.getElementById(
"certificate-id"
).value;


const {data,error}=await client

.from("certificates")

.select("*")

.eq("certificate_id",id)

.single();


let box=document.getElementById(
"verification-result"
);


if(error || !data){

box.innerHTML=
"❌ Certificate not found";

return;

}


box.innerHTML=

`
<h3>✅ Valid Certificate</h3>

<p>
Course: ${data.course}
</p>

<p>
Certificate ID:
${data.certificate_id}
</p>

<p>
Issued:
${new Date(data.issued_at).toDateString()}
</p>
`;

}

