
async function loadAnalytics(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);



const {data}=await client
.from("advertisement_analytics")
.select("*")
.eq("business_id",user.id);



let views=0;
let clicks=0;


(data||[]).forEach(a=>{

views += a.views || 0;

clicks += a.clicks || 0;

});


document.getElementById("stats").innerHTML=

`

<div class="card">

<h2>👁 Views</h2>

<p>${views}</p>


<h2>🖱 Clicks</h2>

<p>${clicks}</p>


</div>

`;

}


document.addEventListener(
"DOMContentLoaded",
loadAnalytics
);

