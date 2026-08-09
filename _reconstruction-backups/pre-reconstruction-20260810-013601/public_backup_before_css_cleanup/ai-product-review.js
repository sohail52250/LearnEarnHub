async function aiReviewProduct(product){

let text = `
${product.product_name}
${product.description}
${product.category}
`;

let blocked=[
"fake",
"scam",
"weapon",
"illegal"
];

let result="approved";
let reason="AI approved";

for(let word of blocked){
 if(text.toLowerCase().includes(word)){
   result="rejected";
   reason="Blocked keyword detected";
 }
}

return {
 status:result,
 reason:reason,
 score: result==="approved" ? 95 : 20
};

}

window.aiReviewProduct=aiReviewProduct;
