
function generatePlatformID(type){

let prefix="ENT";

if(type==="company")
prefix="BIZ";

if(type==="investor")
prefix="INV";

if(type==="individual")
prefix="PER";


let number=
Math.floor(
100000 + Math.random()*900000
);


return "LEH-"+prefix+"-"+number;

}



async function submitVerification(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const user=
JSON.parse(
localStorage.getItem("user") || "null"
);



if(!user){

document.getElementById("result").innerHTML=
"Please login first";

return;

}



const type=
document.getElementById("entity_type").value;



const platformID=
generatePlatformID(type);



const {error}=await client
.from("entity_verifications")
.insert({

user_id:user.id,

entity_name:
document.getElementById("entity_name").value,

entity_type:type,

platform_id:platformID,

verification_status:"pending"

});



document.getElementById("result").innerHTML=

error ?

error.message :

"✅ Submitted<br>Your Platform ID: "+platformID;


}


