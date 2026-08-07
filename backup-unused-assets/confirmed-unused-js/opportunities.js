async function loadOpportunities(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("opportunities")
.select("*")
.order("created_at",{ascending:false});



const box=document.getElementById(
"opportunity-list"
);



if(!data || !data.length){

box.innerHTML=
"No opportunities available.";

return;

}



box.innerHTML=data.map(o=>`

<div class="card">

<h2>
${o.title}
</h2>


<p>
📌 ${o.type}
</p>


<p>
🛠 ${o.skills}
</p>


<p>
${o.description}
</p>


<p>
💰 ${o.reward || "Contact employer"}
</p>


<button>
Apply
</button>


</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadOpportunities
);
