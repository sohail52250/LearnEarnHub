

async function loadInstructors(){


const client=supabase.createClient(

SUPABASE_URL,

SUPABASE_ANON_KEY

);



const {data}=await client

.from("instructors")

.select("*")

.eq("verified",true);



document.getElementById("list")

.innerHTML=data.map(i=>`


<div class="card">


<h2>
🎓 ${i.full_name}
</h2>


<p>
${i.title || "Verified Instructor"}
</p>


<p>
Skills:
${i.skills || ""}
</p>


<p>
⭐ Quality Score:
${i.quality_score}
</p>


<p>
Courses:
${i.courses_created}
</p>


</div>


`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadInstructors
);


