
let deals=[];


async function loadDeals(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client
.from("business_deal_requests")
.select("*")
.eq("status","approved")
.order("created_at",{ascending:false});


if(error){

document.getElementById("deals").innerHTML=
error.message;

return;

}


deals=data||[];

displayDeals(deals);

}



function displayDeals(list){

document.getElementById("deals").innerHTML=

list.map(d=>`

<div class="card">

<h2>
🏢 ${d.request_type}
</h2>


<p>
Industry:
${d.industry||"Not specified"}
</p>


<p>
${d.description||""}
</p>


<p>
Expected Value:
${d.expected_value||"Contact platform"}
</p>


<button onclick="sendInterest(${d.id})">
Request Introduction
</button>


</div>

`).join("");

}



async function sendInterest(id){

const user=
JSON.parse(localStorage.getItem("user")||"null");


if(!user){

alert("Login required");

return;

}



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client
.from("business_interest_requests")
.insert({

deal_request_id:id,

interested_party_id:user.id,

message:"Interested through platform"

});



alert(
error ? error.message :
"Request sent. Identity remains hidden."
);


}


document.addEventListener(
"DOMContentLoaded",
loadDeals
);

