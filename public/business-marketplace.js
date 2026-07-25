async function loadBusinessOffers(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("business_offers")
.select("*")
.order(
"created_at",
{ascending:false}
);



const box=document.getElementById(
"business-list"
);



if(!data || !data.length){

box.innerHTML=
"No business opportunities yet.";

return;

}



box.innerHTML=data.map(b=>`

<div class="card">

<h2>
🏢 ${b.business_name}
</h2>


<p>
Category:
${b.category}
</p>


<p>
Selling:
${b.offer}
</p>


<p>
Stock:
${b.stock}
</p>


<p>
Need:
${b.need}
</p>


<p>
Provide:
${b.provide}
</p>


<p>
${b.details}
</p>


</div>


`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadBusinessOffers
);
