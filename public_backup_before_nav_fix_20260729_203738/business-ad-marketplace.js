
let advertisements=[];


async function loadAdvertisements(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client
.from("advertisements")
.select("*")
.eq("status","approved")
.order("created_at",{ascending:false});


if(error){

document.getElementById("ads-list").innerHTML=
"Unable to load advertisements";

return;

}


advertisements=data || [];

displayAds(advertisements);

}



function displayAds(list){

document.getElementById("ads-list").innerHTML =

list.map(ad=>`

<div class="card">

<h2>
⭐ ${ad.package_name}
</h2>


<p>
Business Advertisement
</p>


<p>
Category:
${ad.category || "General"}
</p>


<p>
${ad.description || ""}
</p>


<button onclick="contactBusiness(${ad.id})">
Send Inquiry
</button>


</div>

`).join("")
||
"No advertisements available";

}



function filterAds(){

let category=
document.getElementById("categoryFilter").value;


if(!category){

displayAds(advertisements);
return;

}


displayAds(

advertisements.filter(
a=>a.category===category
)

);


}



async function contactBusiness(id){

alert(
"Your inquiry request has been recorded."
);

}


document.addEventListener(
"DOMContentLoaded",
loadAdvertisements
);

