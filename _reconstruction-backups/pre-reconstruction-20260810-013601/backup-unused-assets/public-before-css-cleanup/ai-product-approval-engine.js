
async function runAIProductApproval(productId){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:product,error}=await client
.from("business_products")
.select("*")
.eq("id",productId)
.single();



if(error || !product){
return;
}



let text = `

${product.product_name}

${product.description}

${product.category}

`;



let blockedWords=[

"fake",
"scam",
"fraud",
"illegal",
"weapon",
"counterfeit"

];



let status="approved";
let score=95;
let reason="AI verification passed";



for(let word of blockedWords){

if(text.toLowerCase().includes(word)){

status="rejected";

score=20;

reason="Restricted or suspicious keyword detected";

break;

}

}



await client
.from("ai_product_reviews")
.insert({

product_id:productId,

ai_score:score,

ai_status:status,

ai_reason:reason

});



await client
.from("business_products")
.update({

status:status

})
.eq("id",productId);



return {

status,
score,
reason

};


}



window.runAIProductApproval=
runAIProductApproval;

