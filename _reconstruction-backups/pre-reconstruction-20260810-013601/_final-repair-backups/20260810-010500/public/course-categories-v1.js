

async function loadCategories(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data,error}=await client

.from("course_categories")

.select("*")

.order("id");



if(error){

document.getElementById("categories").innerHTML=
"Unable to load categories";

return;

}



document.getElementById("categories").innerHTML=


data.map(category=>`


<div class="card">


<h2>

${category.icon}

${category.name}

</h2>


<p>

${category.description}

</p>


<a href="/courses.html?category=${encodeURIComponent(category.name)}">

<button>

Explore Courses

</button>

</a>


</div>


`).join("");



}



document.addEventListener(
"DOMContentLoaded",
loadCategories
);


