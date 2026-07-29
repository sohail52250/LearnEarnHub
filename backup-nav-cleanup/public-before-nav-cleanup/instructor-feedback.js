
async function loadInstructorFeedback(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client

.from("instructor_feedback")

.select("*")

.order(
"created_at",
{
ascending:false
}
);



document.getElementById(
"feedback"
)

.innerHTML=(data||[]).map(f=>`

<div class="card">

<h2>
Quality Score:
${f.quality_score}/100
</h2>


<p>
${f.feedback_message}
</p>


</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadInstructorFeedback
);

