async function createOpportunityMatch(
need,
offer
){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const needText =
(
need.need_title +
" " +
need.category
).toLowerCase();



const offerText =
(
offer.offer +
" " +
offer.provide +
" " +
offer.category
).toLowerCase();



let score=0;


const words =
needText.split(" ");



words.forEach(word=>{

if(
word.length > 3 &&
offerText.includes(word)
){

score += 20;

}

});


if(score >= 20){

await client
.from("opportunity_matches")
.insert({

need_id:need.id,

offer_id:offer.id,

match_score:score,

status:"matched",

created_at:new Date()

});


}

}



async function checkNewMatches(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:needs}=await client
.from("business_needs")
.select("*")
.eq("status","open");



const {data:offers}=await client
.from("business_offers")
.select("*")
.eq("verified",true);



if(!needs || !offers)
return;



for(const need of needs){

for(const offer of offers){

await createOpportunityMatch(
need,
offer
);

}

}


}


window.checkNewMatches=
checkNewMatches;
