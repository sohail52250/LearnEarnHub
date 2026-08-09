
async function loadAdminVacancies(){


const response =
await fetch("/api/admin-vacancies");


const data =
await response.json();



document.getElementById("vacancies")

.innerHTML=(data||[]).map(v=>`


<div class="card">

<h2>
${v.title}
</h2>


<p>
${v.department || ""}
</p>


<p>
${v.description || ""}
</p>


<p>
Requirements:
${v.requirements || ""}
</p>


<a href="/admin-apply.html?id=${v.id}">

<button>
Apply
</button>

</a>


</div>


`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadAdminVacancies
);

