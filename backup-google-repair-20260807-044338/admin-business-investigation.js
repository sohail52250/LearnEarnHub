
async function loadReports(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("business_reports")
.select("*")
.order(
"created_at",
{ascending:false}
);


document.getElementById("reports").innerHTML=

(data||[]).map(r=>`

<div class="card">

<h3>🚩 Report</h3>

<p>
Reason:
${r.reason}
</p>


<p>
Status:
${r.status}
</p>


<button>
Investigate
</button>

</div>

`).join("")
||
"No reports";


}


document.addEventListener(
"DOMContentLoaded",
loadReports
);

