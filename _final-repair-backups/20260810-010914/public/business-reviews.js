
async function loadReviews(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("business_reviews")
.select("*")
.order("created_at",{ascending:false});

document.getElementById("reviews").innerHTML=
(data||[]).map(r=>`

<div class="card">

<h2>${r.business_name || "Business"}</h2>

<p>
⭐ ${r.rating || 0}/5
</p>

<p>
${r.review_text || ""}
</p>

</div>

`).join("");

}

document.addEventListener(
"DOMContentLoaded",
loadReviews
);

