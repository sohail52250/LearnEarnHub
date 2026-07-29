#!/data/data/com.termux/files/usr/bin/bash

echo "=== Upgrading LearnEarnHub Business Dashboard ==="

cat > public/business-dashboard.js <<'JS'
const user = JSON.parse(localStorage.getItem("user") || "null");

if(!user){
    location.href="/login.html";
}

const client = supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY
);


async function loadBusiness(){

    const {data,error}=await client
    .from("business_profiles")
    .select("*")
    .eq("owner_id",user.id)
    .single();


    if(error){
        document.getElementById("business-status").innerHTML =
        "Create your business profile first.";
        return;
    }


    document.getElementById("company_name").value=data.company_name || "";
    document.getElementById("logo_url").value=data.logo_url || "";
    document.getElementById("description").value=data.description || "";
    document.getElementById("category").value=data.category || "";

    loadOpportunities();

}



async function saveBusiness(){

const payload={
company_name:
document.getElementById("company_name").value,

logo_url:
document.getElementById("logo_url").value,

description:
document.getElementById("description").value,

category:
document.getElementById("category").value,

owner_id:user.id
};


const {error}=await client
.from("business_profiles")
.upsert(payload);


document.getElementById("business-status").innerHTML =
error ? "❌ "+error.message :
"✅ Business profile saved";

}



async function loadOpportunities(){

const {data}=await client
.from("business_opportunities")
.select("*")
.eq("business_id",user.id)
.order("created_at",{ascending:false});


document.getElementById("opportunities").innerHTML =
(data||[]).map(o=>`

<div class="card">

<h3>${o.title}</h3>

<p>${o.description||""}</p>

<p>Status: ${o.status}</p>

</div>

`).join("");

}



async function addOpportunity(){

const payload={

business_id:user.id,

title:
document.getElementById("job_title").value,

description:
document.getElementById("job_description").value

};


const {error}=await client
.from("business_opportunities")
.insert(payload);


alert(
error ? error.message :
"Opportunity added"
);


loadOpportunities();

}



document.addEventListener(
"DOMContentLoaded",
loadBusiness
);
JS


echo "Dashboard JS updated"
echo "=== Completed ==="

