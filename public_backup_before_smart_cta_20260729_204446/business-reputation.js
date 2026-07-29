
async function loadBusinessReputation(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("business_reviews")
.select("*")
.eq("business_id",id);


let total=0;

(data||[]).forEach(
r=> total+=r.rating
);


let score =
data && data.length
?
Math.round(total/data.length*20)
:
0;


return score;

}


window.loadBusinessReputation=
loadBusinessReputation;

