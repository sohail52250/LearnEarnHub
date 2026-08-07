
async function loadBusinessAnalytics(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data}=await client
.from("business_analytics")
.select("*");



console.log(data);


}


document.addEventListener(
"DOMContentLoaded",
loadBusinessAnalytics
);

