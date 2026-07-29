#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Opportunity Management Upgrade ==="

cp public/business-dashboard.js public/business-dashboard.js.bak 2>/dev/null


cat >> public/business-dashboard.js <<'JS'


async function editOpportunity(id){

const title = prompt("New title:");

if(!title) return;


const {error}=await client
.from("business_opportunities")
.update({
title:title
})
.eq("id",id)
.eq("business_id",user.id);



if(error){

alert(error.message);

return;

}


loadOpportunities();

}



async function deleteOpportunity(id){


if(!confirm("Delete this opportunity?"))
return;



const {error}=await client
.from("business_opportunities")
.delete()
.eq("id",id)
.eq("business_id",user.id);



if(error){

alert(error.message);

return;

}


loadOpportunities();

}



async function changeOpportunityStatus(id,status){


const {error}=await client
.from("business_opportunities")
.update({
status:status
})
.eq("id",id)
.eq("business_id",user.id);



if(error){

alert(error.message);

return;

}


loadOpportunities();

}



async function addOpportunity(){


const payload={

business_id:user.id,

title:
document.getElementById("job_title").value,

description:
document.getElementById("job_description").value,

status:"active"

};



const {error}=await client
.from("business_opportunities")
.insert(payload);



if(error){

alert(error.message);

return;

}


alert("Opportunity added");

loadOpportunities();

}

JS



echo "=== Opportunity management added ==="

