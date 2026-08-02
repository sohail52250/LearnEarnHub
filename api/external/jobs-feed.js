module.exports = async (req,res)=>{
try{

const jobs=[];

/*
Future sources:
https://himalayas.app/jobs/api
https://jobicy.com/api/v2/remote-jobs
*/

jobs.push({
 source:"External Feed",
 title:"Remote Opportunity Feed Enabled",
 reward:"Variable",
 type:"remote"
});

res.json({
 success:true,
 jobs
});

}catch(e){
 res.status(500).json({error:e.message});
}
};
