
async function loadPublishingQueue(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data}=await client

.from("course_submissions")

.select("*")

.eq("status","pending_review");



document.getElementById(
"submissions"
)

.innerHTML=(data||[]).map(c=>`

<div class="card">

<h2>
Course ID:
${c.course_id}
</h2>


<p>
Status:
${c.status}
</p>


<button onclick="updateCourseStatus('${c.id}','approved')">

✅ Approve

</button>


<button onclick="updateCourseStatus('${c.id}','rejected')">

❌ Reject

</button>


</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadPublishingQueue
);

