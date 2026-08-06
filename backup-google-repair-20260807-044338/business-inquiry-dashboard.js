
async function loadInquiries(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


const {data}=await client
.from("business_inquiries")
.select("*")
.eq("business_id",user.id)
.order(
"created_at",
{ascending:false}
);



document.getElementById("inquiries").innerHTML =

(data||[]).map(i=>`

<div class="card">

<p>
${i.message}
</p>


<p>
Status:
${i.status}
</p>


<button onclick="reportInquiry(${i.id})">
🚩 Report
</button>

</div>

`).join("")
||
"No inquiries";

}



async function reportInquiry(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("business_reports")
.insert({

inquiry_id:id,

reason:"User reported inquiry",

status:"pending",

created_at:new Date()

});


alert(
"Report submitted"
);

}



document.addEventListener(
"DOMContentLoaded",
loadInquiries
);

