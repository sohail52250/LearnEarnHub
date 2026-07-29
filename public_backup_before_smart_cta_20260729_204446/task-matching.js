
async function matchLearners(taskId, requiredSkill){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("learner_profiles")
.select("*");



let matches=(data||[]).map(l=>{

let skills=l.skills||[];

let score =
skills.includes(requiredSkill)
? 100
: 0;


return {

learner_id:l.user_id,

match_score:score,

ai_reason:
score
?"Skill matched"
:"Skill not matched"

};

});



for(const m of matches){

await client
.from("task_matches")
.insert({

task_id:taskId,

learner_id:m.learner_id,

match_score:m.match_score,

ai_reason:m.ai_reason

});

}


return matches;

}


window.matchLearners=matchLearners;

