#!/data/data/com.termux/files/usr/bin/bash

echo "Upgrading admin partnership dashboard..."

cat > public/admin-partnerships.js <<'JS'
async function loadRequests(){

const box=document.getElementById("requests");

let search=document.getElementById("search")?.value || "";
let filter=document.getElementById("filter")?.value || "";


let query=supabaseClient
.from("partnership_requests")
.select("*")
.order("created_at",{ascending:false});


let {data,error}=await query;


if(error){

box.innerHTML="❌ "+error.message;
return;

}


if(filter){

data=data.filter(r=>(r.status||"pending")===filter);

}


if(search){

data=data.filter(r=>
(r.name||"").toLowerCase().includes(search.toLowerCase()) ||
(r.email||"").toLowerCase().includes(search.toLowerCase())
);

}


box.innerHTML=data.map(r=>`

<div class="card">

<h3>🏢 ${r.organization || r.name}</h3>

<p>👤 ${r.name}</p>

<p>📧 ${r.email}</p>

<p>📱 ${r.phone || ""}</p>

<p>🤝 Type: ${r.partnership_type}</p>

<p>${r.details}</p>


<p>
Status:
<b>${r.status || "pending"}</b>
</p>


<textarea id="note-${r.id}" placeholder="Admin notes">${r.admin_notes || ""}</textarea>


<br>

<button onclick="updateRequest('${r.id}','approved')">
✅ Approve
</button>


<button onclick="updateRequest('${r.id}','rejected')">
❌ Reject
</button>


<button onclick="saveNote('${r.id}')">
📝 Save Note
</button>


</div>

`).join("");

}



async function updateRequest(id,status){

await supabaseClient
.from("partnership_requests")
.update({
status,
reviewed_at:new Date()
})
.eq("id",id);


loadRequests();

}



async function saveNote(id){

let note=document.getElementById("note-"+id).value;


await supabaseClient
.from("partnership_requests")
.update({
admin_notes:note
})
.eq("id",id);


alert("Note saved");

}



function exportCSV(){

let rows=[["Name","Email","Status"]];


document.querySelectorAll(".card").forEach(c=>{

rows.push([
c.innerText.replace(/\n/g," "),
"",
""
]);

});


let csv=rows.map(r=>r.join(",")).join("\n");


let blob=new Blob([csv]);

let a=document.createElement("a");

a.href=URL.createObjectURL(blob);

a.download="partnership-requests.csv";

a.click();

}

checkAdmin();

JS


python - <<'PY'
p="public/admin-partnerships.html"

s=open(p).read()

if 'id="search"' not in s:

s=s.replace(
'<div id="requests">',
'''
<input id="search" placeholder="Search company/email" onkeyup="loadRequests()">

<select id="filter" onchange="loadRequests()">
<option value="">All</option>
<option value="pending">Pending</option>
<option value="approved">Approved</option>
<option value="rejected">Rejected</option>
</select>

<button onclick="exportCSV()">Export CSV</button>

<div id="requests">
'''
)

open(p,"w").write(s)

PY


echo "Admin controls added successfully."

