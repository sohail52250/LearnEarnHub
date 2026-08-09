async function loadBusinesses(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("business_profiles")
.select("*")
.eq("verified",true);



const box=document.getElementById(
"business-list"
);


if(!data || !data.length){

box.innerHTML=
"No verified businesses yet.";

return;

}



box.innerHTML=data.map(b=>`

<div class="card">

<h2>
🏢 ${b.business_name}
</h2>


<p>
${b.business_type || ""}
</p>


<p>
${b.industry || ""}
</p>


<p>
${b.description || ""}
</p>


</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadBusinesses
);
