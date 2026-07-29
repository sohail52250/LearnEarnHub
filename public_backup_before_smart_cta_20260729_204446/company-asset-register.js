
async function addAsset(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client
.from("company_assets")
.insert({

company_id:
document.getElementById("company_id").value,

asset_name:
document.getElementById("asset_name").value,

asset_type:
document.getElementById("asset_type").value,

estimated_value:
Number(document.getElementById("value").value),

details:
document.getElementById("details").value,

status:"active"

});



document.getElementById("message")
.innerHTML=

error ? error.message :
"✅ Asset added";

}


