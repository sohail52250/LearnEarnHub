
const adminEmail="it03347543200@gmail.co";


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user || user.email!==adminEmail){

document.body.innerHTML=
"<h2>Access denied</h2>";

throw new Error("Not admin");

}



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



async function loadBusinesses(){


const {data,error}=await client

.from("business_profiles")

.select("*")

.eq("verified",false);



if(error){

document.getElementById("business-list").innerHTML=
error.message;

return;

}



document.getElementById("business-list").innerHTML=

(data||[]).map(b=>`

<div class="card">

<h3>${b.company_name}</h3>

<p>${b.description||""}</p>

<p>${b.category||""}</p>


<button onclick="approve('${b.id}')">

✅ Approve

</button>


</div>

`).join("");

}



async function approve(id){


const {error}=await client

.from("business_profiles")

.update({

verified:true

})

.eq("id",id);



if(error){

alert(error.message);

return;

}


alert("Business verified");

loadBusinesses();


}



document.addEventListener(
"DOMContentLoaded",
loadBusinesses
);

