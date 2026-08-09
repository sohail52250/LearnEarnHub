async function loadAds(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("advertisements")
.select("*")
.order("created_at",{ascending:false});


document.getElementById("ads").innerHTML =
(data||[]).map(ad=>`

<div class="card">

<h3>${ad.package_name}</h3>

<p>
Amount: Rs ${ad.amount}
</p>

<p>
Status: ${ad.status}
</p>


<button onclick="approveAd(${ad.id})">
Approve
</button>

<button onclick="rejectAd(${ad.id})">
Reject
</button>

</div>

`).join("");

}


async function approveAd(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("advertisements")
.update({
status:"approved"
})
.eq("id",id);


loadAds();

}


async function rejectAd(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("advertisements")
.update({
status:"rejected"
})
.eq("id",id);


loadAds();

}


document.addEventListener(
"DOMContentLoaded",
loadAds
);

