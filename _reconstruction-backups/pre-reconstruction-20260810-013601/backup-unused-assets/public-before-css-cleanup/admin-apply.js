
async function submitAdminApplication(){


const vacancy_id =
new URLSearchParams(location.search)
.get("id");



const result =
await fetch("/api/admin-apply",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

vacancy_id,

name:
document.getElementById("name").value,

email:
document.getElementById("email").value,

experience:
document.getElementById("experience").value,

skills:
document.getElementById("skills").value

})

});



if(result.ok){

alert(
"Application submitted"
);

}


}

