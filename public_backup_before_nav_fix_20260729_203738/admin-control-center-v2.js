
async function loadAdminStats(){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


async function count(table){

const {data,error}=await client
.from(table)
.select("*");


if(error){

return "0";

}

return data.length;

}



document.getElementById("users-count").innerText =
await count("users");


document.getElementById("business-count").innerText =
await count("businesses");


document.getElementById("advert-count").innerText =
await count("advertisements");


document.getElementById("report-count").innerText =
await count("reports");


document.getElementById("deal-count").innerText =
await count("business_deals");


}


document.addEventListener(
"DOMContentLoaded",
loadAdminStats
);

