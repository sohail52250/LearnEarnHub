module.exports=(req,res)=>{
res.json({
success:true,
category:req.query.category||"all",
jobs:[
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
]
});
};
