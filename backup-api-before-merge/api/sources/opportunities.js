const sources = [

{
name:"LearnEarnHub Partners",
type:"internal",
enabled:true,
jobs:[
{
title:"Remote Digital Task",
category:"online",
reward:"Variable",
url:""
}
]
},

{
name:"RSS/API Sources",
type:"external",
enabled:false,
jobs:[]
}

];


module.exports=async(req,res)=>{

try{


let all=[];


sources.forEach(source=>{

if(source.enabled){

source.jobs.forEach(job=>{

all.push({

...job,

source:source.name

});

});

}

});


let unique=[];

let seen=new Set();


all.forEach(job=>{

let key=
job.title+"-"+job.source;


if(!seen.has(key)){

seen.add(key);
unique.push(job);

}

});


res.json({

success:true,

sources:sources.length,

count:unique.length,

jobs:unique

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
