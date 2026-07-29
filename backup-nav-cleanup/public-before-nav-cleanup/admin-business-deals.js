
async function loadBusinessDeals(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client
.from("business_deal_requests")
.select("*")
.order("created_at",{ascending:false});


if(error){

document.getElementById("requests").innerHTML=
error.message;

return;

}



document.getElementById("requests").innerHTML=

(data||[]).map(item=>`

<div class="card">

<h3>
${item.company_name}
</h3>


<p>
Type:
${item.request_type}
</p>


<p>
Status:
${item.status}
</p>


<button onclick="approveDeal(${item.id})">
Approve
</button>


<button onclick="rejectDeal(${item.id})">
Reject
</button>


</div>

`).join("");

}



async function updateStatus(id,status){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("business_deal_requests")
.update({
status:status
})
.eq("id",id);


loadBusinessDeals();

}



function approveDeal(id){

updateStatus(id,"approved");

}


function rejectDeal(id){

updateStatus(id,"rejected");

}



document.addEventListener(
"DOMContentLoaded",
loadBusinessDeals
);

