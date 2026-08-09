
async function loadAIReviews(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data,error}=await client

.from("ai_course_reviews")

.select("*")

.order(
"created_at",
{
ascending:false
}
);



if(error){

document.getElementById(
"ai-reviews"
).innerHTML="Unable to load AI reviews";

return;

}



let approved=0;
let improve=0;


(data || []).forEach(r=>{

if(r.recommendation==="approve")
approved++;

else
improve++;

});



document.getElementById(
"ai-summary"
).innerHTML=`

<div class="card">

<h2>
AI Summary
</h2>


<p>
✅ Recommended:
${approved}
</p>


<p>
⚠️ Needs Improvement:
${improve}
</p>


</div>

`;



document.getElementById(
"ai-reviews"
).innerHTML=(data || []).map(r=>`


<div class="card">


<h2>
Course:
${r.course_id}
</h2>


<p>
⭐ Overall Score:
${r.overall_score}/100
</p>


<p>
Content:
${r.content_score}
</p>


<p>
Structure:
${r.structure_score}
</p>


<p>
Skill Match:
${r.skill_score}
</p>


<p>
Difficulty:
${r.difficulty_score}
</p>


<p>
Recommendation:
${r.recommendation}
</p>


<p>
${r.ai_notes || ""}
</p>


</div>


`).join("");



}



document.addEventListener(
"DOMContentLoaded",
loadAIReviews
);

