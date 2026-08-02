const https=require("https");


function fetchJSON(url){

return new Promise((resolve,reject)=>{

https.get(url,res=>{

let data="";

res.on("data",c=>data+=c);

res.on("end",()=>{

try{

resolve(JSON.parse(data));

}catch(e){

resolve([]);

}

});

}).on("error",reject);

});

}



module.exports=async(req,res)=>{

try{


let feeds=[];


/*
Add external feeds here:

Example:

feeds.push(
 await fetchJSON("YOUR_API_URL")
)

*/


let opportunities=[

{
source:"LearnEarnHub Feed",
title:"Remote Work Opportunities",
type:"remote",
category:"online",
reward:"Variable"
}

];


res.json({

success:true,

updated_at:new Date(),

feeds:feeds.length,

jobs:opportunities

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
