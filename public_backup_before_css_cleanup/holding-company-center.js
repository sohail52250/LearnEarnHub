
async function createHoldingCompany(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user")||"null"
);


if(!user){
alert("Login required");
return;
}



const {error}=await client
.from("holding_companies")
.insert({

owner_id:user.id,

company_name:
document.getElementById("company_name").value,

description:
document.getElementById("description").value,

status:"active"

});



document.getElementById("message")
.innerHTML=

error ? error.message :
"✅ Holding company created";


loadHoldingCompanies();

}




async function loadHoldingCompanies(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user")||"null"
);



const {data}=await client
.from("holding_companies")
.select("*")
.eq("owner_id",user.id);



document.getElementById("companies")
.innerHTML=

(data||[]).map(c=>`

<div class="card">

<h3>
🏢 ${c.company_name}
</h3>

<p>
${c.description||""}
</p>

<p>
Status:
${c.status}
</p>


</div>

`).join("")
||
"No holding companies";


}



document.addEventListener(
"DOMContentLoaded",
loadHoldingCompanies
);


