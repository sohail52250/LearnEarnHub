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


if(!needs || !offers){

document.getElementById("result").innerHTML =
"No data available";

return;

}


let count=0;


for(const need of needs){

for(const offer of offers){


const needText =
(
(need.need_title || "")+
" "+
(need.category || "")
).toLowerCase();


const offerText =
(
(offer.offer || "")+
" "+
(offer.provide || "")+
" "+
(offer.category || "")
).toLowerCase();



if(
needText.includes(offer.category?.toLowerCase()) ||
offerText.includes(need.category?.toLowerCase())
){


await client
.from("opportunity_matches")
.insert({

need_id:need.id,

offer_id:offer.id,

match_score:80,

status:"matched"

});


count++;

}


}


}


document.getElementById("result").innerHTML =
"Matches created: "+count;


}


window.checkNewMatches=checkNewMatches;
