
const client = supabaseClient;


const user =
JSON.parse(localStorage.getItem("user") || "null");


if(!user){

location.href="/login.html";

}



async function createOpportunity(){


const payload={

business_id:user.id,

title:title.value,

description:description.value,

category:category.value,

skill_required:skill_required.value,

status:"open"

};



const {error}=await client

.from("job_opportunities")

.insert(payload);



if(error){

alert(error.message);

return;

}


alert("Opportunity created");

loadOpportunities();

}




async function loadOpportunities(){


const {data,error}=await client

.from("job_opportunities")

.select("*")

.eq("business_id",user.id)

.order("created_at",{ascending:false});



if(error){

list.innerHTML=error.message;

return;

}



list.innerHTML=(data||[]).map(item=>`


<div class="card">

<h3>
${item.title}
</h3>


<p>
${item.description || ""}
</p>


<p>
Status: ${item.status}
</p>


<button onclick="deleteOpportunity('${item.id}')">
Delete
</button>


</div>


`).join("");

}





async function deleteOpportunity(id){


if(!confirm("Delete this opportunity?"))
return;


const {error}=await client

.from("job_opportunities")

.delete()

.eq("id",id)

.eq("business_id",user.id);



if(error){

alert(error.message);

return;

}


loadOpportunities();


}



loadOpportunities();

