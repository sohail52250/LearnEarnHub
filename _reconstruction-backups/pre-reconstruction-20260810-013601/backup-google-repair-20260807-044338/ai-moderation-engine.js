
async function aiCheckContent(type, content){

let result = {
status:"approved",
risk:"low",
reason:""
};


// basic safety checks

const blockedWords = [
"fraud",
"scam",
"fake",
"illegal"
];


let text =
content.toLowerCase();


for(let word of blockedWords){

if(text.includes(word)){

result.status="review";
result.risk="high";
result.reason="Suspicious keywords detected";

return result;

}

}


// advertisement/business basic check

if(type==="business" && content.length < 20){

result.status="review";
result.reason="Insufficient business information";

}


if(type==="advertisement" && content.length < 30){

result.status="review";
result.reason="Advertisement requires more details";

}


return result;

}



async function saveAIReview(
table,
id,
review
){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from(table)
.update({

ai_status:review.status,

ai_risk:review.risk,

ai_reason:review.reason

})
.eq("id",id);


}



window.aiCheckContent =
aiCheckContent;

window.saveAIReview =
saveAIReview;

