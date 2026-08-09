
const client=supabaseClient;

async function loadLeaderboards(){

// Top learners by XP

const {data:learners}=await client
.from("learner_stats")
.select("*")
.order("xp",{ascending:false})
.limit(10);


document.getElementById("top-learners").innerHTML=

(learners||[]).map((l,i)=>`

<p>

${i+1}.
Level ${l.level}
-
XP ${l.xp}

</p>

`).join("")

||
"No learner data";



// Top businesses by trust score

const {data:businesses}=await client
.from("business_trust_scores")
.select("*")
.order("trust_score",{ascending:false})
.limit(10);


document.getElementById("top-businesses").innerHTML=

(businesses||[]).map((b,i)=>`

<p>

${i+1}.
Trust Score:
${b.trust_score}

</p>

`).join("")

||
"No business data";

}

document.addEventListener(
"DOMContentLoaded",
loadLeaderboards
);

