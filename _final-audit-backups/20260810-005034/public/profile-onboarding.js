async function saveProfile(){


const user =
JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

alert("Please login first");
return;

}



const roleData =
await fetch(
`${SUPABASE_URL}/rest/v1/user_roles?user_id=eq.${user.id}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
)
.then(r=>r.json());



const role =
roleData[0].role;



let table="";

let data={};



if(role==="learner"){

table="learner_profiles";

data={

user_id:user.id,

full_name:
document.getElementById("name").value,

skills:
document.getElementById("skills").value.split(","),

created_at:new Date()

};

}



if(role==="business"){

table="business_profiles";

data={

owner_id:user.id,

business_name:
document.getElementById("name").value,

category:
document.getElementById("category").value,

products:
document.getElementById("skills").value,

looking_for:
document.getElementById("goal").value

};

}



if(role==="sponsor"){

table="business_profiles";

data={

owner_id:user.id,

business_name:
document.getElementById("name").value,

category:
document.getElementById("category").value,

looking_for:
document.getElementById("goal").value

};

}



if(role==="referral"){

table="business_profiles";

data={

owner_id:user.id,

category:
document.getElementById("category").value,

looking_for:
document.getElementById("goal").value

};

}



await fetch(

`${SUPABASE_URL}/rest/v1/${table}`,

{

method:"POST",

headers:{

apikey:SUPABASE_KEY,

Authorization:`Bearer ${SUPABASE_KEY}`,

"Content-Type":"application/json"

},

body:JSON.stringify(data)

}

);



alert("Profile completed");


location.href="/index.html";


}


window.saveProfile=saveProfile;
