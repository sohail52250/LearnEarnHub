
async function loadDashboard(){

const {data:userData}=await supabaseClient.auth.getUser();


if(!userData.user){

location="/login.html";
return;

}


document.getElementById("email").innerText=
userData.user.email;


const response=await fetch(
"/api/dashboard/"+userData.user.id
);


const data=await response.json();



document.getElementById("courses").innerHTML=

data.courses.map(c=>`

<div class="card">

<h3>${c.title}</h3>

<p>
${c.completed_lessons}/${c.total_lessons}
Lessons Completed
</p>


<div class="progress">

<div class="bar"
style="width:${c.percentage}%">
</div>

</div>


<p>${c.percentage}% Complete</p>


</div>

`).join("");


}


loadDashboard();

