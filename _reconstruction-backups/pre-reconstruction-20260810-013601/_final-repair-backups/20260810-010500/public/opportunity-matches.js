async function loadMatches(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("opportunity_matches")
.select("*")
.order(
"created_at",
{ascending:false}
);



const box=document.getElementById(
"match-list"
);



if(!data || !data.length){

box.innerHTML=
"No matches yet.";

return;

}



box.innerHTML=data.map(m=>`

<div class="card">

<h2>
🤝 Match Found
</h2>


<p>
Match Score:
${m.match_score}%
</p>


<p>
Status:
${m.status}
</p>


</div>

`).join("");

}



document.addEventListener(
"DOMContentLoaded",
loadMatches
);
