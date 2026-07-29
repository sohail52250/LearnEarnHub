#!/data/data/com.termux/files/usr/bin/bash

echo "=== Upgrading Business Marketplace ==="

cp public/business-marketplace.html public/business-marketplace.html.bak 2>/dev/null
cp public/business-marketplace-v2.js public/business-marketplace-v2.js.bak 2>/dev/null


cat > public/business-marketplace-v2.js <<'JS'
let businesses=[];


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



async function loadBusinesses(){


const {data,error}=await client
.from("business_profiles")
.select("*")
.eq("verified",true)
.order("created_at",{ascending:false});


if(error){

document.getElementById("jobs").innerHTML=
"Unable to load businesses";

return;

}


businesses=data||[];

displayBusinesses(businesses);


}



function displayBusinesses(list){


document.getElementById("jobs").innerHTML=

list.map(b=>`

<div class="card">


${b.logo_url ?
`<img src="${b.logo_url}" width="80">`
:
"🏢"
}


<h2>${b.company_name}</h2>


<p>
${b.description || ""}
</p>


<p>
Category:
${b.category || "General"}
</p>


<a href="${b.website || '#'}">
Visit Website
</a>


</div>


`).join("");

}




function searchJobs(){


const text=
document.getElementById("jobSearch")
.value
.toLowerCase();


displayBusinesses(

businesses.filter(b=>

(b.company_name||"")
.toLowerCase()
.includes(text)

)

);


}



document.addEventListener(
"DOMContentLoaded",
loadBusinesses
);

JS


echo "Marketplace upgraded"

