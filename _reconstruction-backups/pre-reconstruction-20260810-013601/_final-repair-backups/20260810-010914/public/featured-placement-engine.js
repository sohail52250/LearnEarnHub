
async function getFeaturedBusinesses(client){

const {data,error}=await client

.from("business_profiles")

.select(`
*,
business_premium_features(
feature_name,
status
)
`)

.eq("verified",true);



if(error){

console.log(error);

return [];

}



return (data || []).sort((a,b)=>{

const aFeatured =
(a.business_premium_features || [])
.some(
f =>
f.status==="active"
);

const bFeatured =
(b.business_premium_features || [])
.some(
f =>
f.status==="active"
);

return Number(bFeatured) - Number(aFeatured);

});

}

