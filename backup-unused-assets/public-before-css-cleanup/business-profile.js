
async function loadBusinesses(){

let {data,error}=await supabaseClient
.from("business_profiles")
.select("*")
.eq("verified",true);


if(error){

document.getElementById("profile").innerHTML=error.message;
return;

}


document.getElementById("profile").innerHTML=data.map(b=>`

<div class="card">

<h2>
${b.company_name}
${b.verified ? "✅ Verified" : ""}
</h2>

<p>${b.description || ""}</p>

<p>${b.email}</p>

<a href="${b.website || '#'}">
${b.website || ""}
</a>

</div>

`).join("");

}


loadBusinesses();

