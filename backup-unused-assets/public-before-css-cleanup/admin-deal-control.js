
async function loadDeals(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client
.from("deal_rooms")
.select("*")
.order("created_at",{ascending:false});


if(error){

document.getElementById("deals").innerHTML=
error.message;

return;

}


document.getElementById("deals").innerHTML=

(data||[]).map(d=>`

<div class="card">

<h3>
Deal Room #${d.id}
</h3>

<p>
Status:
${d.status}
</p>

<p>
Payment:
${d.fee_status}
</p>


<button onclick="approveDeal(${d.id})">
Approve
</button>


<button onclick="flagDeal(${d.id})">
Flag Risk
</button>


</div>

`).join("");

}



async function approveDeal(id){

alert(
"Deal approved: "+id
);

}



async function flagDeal(id){

alert(
"Risk review started for deal "+id
);

}



document.addEventListener(
"DOMContentLoaded",
loadDeals
);

