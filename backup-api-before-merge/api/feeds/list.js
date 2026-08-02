const fs=require("fs");
const path=require("path");

module.exports=async(req,res)=>{

try{

const file=path.join(
process.cwd(),
"api/feeds/feed-cache.json"
);


if(!fs.existsSync(file)){

return res.json({
success:true,
jobs:[]
});

}


let data=JSON.parse(
fs.readFileSync(file)
);


let category=req.query.category;


let jobs=data.jobs||[];


if(category){

jobs=jobs.filter(
j=>j.category===category
);

}


res.json({

success:true,
updated:data.updated,
jobs

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
