const fs=require("fs");
const path=require("path");

const cacheFile=path.join(
process.cwd(),
"api/feeds/feed-cache.json"
);


module.exports=async(req,res)=>{

try{


let jobs=[

{
id:"remote-001",
title:"Remote Work Opportunity",
category:"remote",
source:"External Feed",
reward:"Variable"
},

{
id:"task-001",
title:"Online Digital Task",
category:"tasks",
source:"External Feed",
reward:"Variable"
}

];


// remove duplicates

let unique=[];

let ids=new Set();

jobs.forEach(j=>{

if(!ids.has(j.id)){

ids.add(j.id);
unique.push(j);

}

});


// save cache

fs.writeFileSync(
cacheFile,
JSON.stringify({
updated:new Date(),
jobs:unique
},null,2)
);


res.json({

success:true,
message:"Feed refreshed",
count:unique.length,
jobs:unique

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
