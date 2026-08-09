
async function runAIAdApproval(adId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:ad,error}=await client
.from("advertisements")
.select("*")
.eq("id",adId)
.single();


if(error || !ad){
return null;
}



let text = `

${ad.title || ""}

${ad.description || ""}

${ad.category || ""}

`;



let blockedWords=[

"fake",
"scam",
"fraud",
"guaranteed money",
"illegal",
"counterfeit",
"hack"

];



let status="approved";
let score=95;
let reason="AI advertisement check passed";



for(let word of blockedWords){

if(text.toLowerCase().includes(word)){

status="rejected";

score=15;

reason="Suspicious advertisement content detected";

break;

}

}



await client
.from("ai_ad_reviews")
.insert({

advertisement_id:adId,

ai_score:score,

ai_status:status,

ai_reason:reason

});



await client
.from("advertisements")
.update({

status:status

})
.eq("id",adId);



return {

status,
score,
reason

};


}


window.runAIAdApproval=
runAIAdApproval;

