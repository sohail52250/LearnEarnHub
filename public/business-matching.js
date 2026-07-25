async function loadBusinessMatches(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:offers}=await client
.from("business_offers")
.select("*")
.eq("verified",true);



const box=document.getElementById(
"matches"
);



if(!offers || !offers.length){

box.innerHTML=
"No verified opportunities available.";

return;

}



box.innerHTML=offers.map(o=>`

<div class="card">

<h2>
🏢 ${o.business_name}
</h2>


<p>
Offers:
${o.offer || ""}
</p>


<p>
Needs:
${o.need || ""}
</p>


<p>
Provides:
${o.provide || ""}
</p>


<button>
Connect Opportunity
</button>


</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadBusinessMatches
);
