
async function loadAds(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("advertisements")
.select("*")
.eq("status","approved");

document.getElementById("ads").innerHTML=
(data||[]).map(ad=>`

<div class="card">

<h2>${ad.title}</h2>

<p>${ad.description || ""}</p>

<p>
Views:
${ad.views || 0}
</p>

<p>
Clicks:
${ad.clicks || 0}
</p>

</div>

`).join("");

}

document.addEventListener(
"DOMContentLoaded",
loadAds
);

