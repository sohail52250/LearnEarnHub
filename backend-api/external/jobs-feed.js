module.exports=async(req,res)=>{

try{

const category=req.query.category || "all";


const jobs=[

{
source:"External Feed",
title:"Remote Data Entry Opportunities",
category:"data-entry",
type:"remote",
reward:"Variable",
apply_url:""
},

{
source:"External Feed",
title:"Freelance Digital Tasks",
category:"freelance",
type:"online",
reward:"Variable",
apply_url:""
},

{
source:"External Feed",
title:"Online Marketing Tasks",
category:"marketing",
type:"remote",
reward:"Variable",
apply_url:""
}

];


let result=
category==="all"
?
jobs
:
jobs.filter(j=>j.category===category);


res.json({
success:true,
category,
jobs:result
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
