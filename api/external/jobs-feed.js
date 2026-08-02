module.exports=async(req,res)=>{
try{

const jobs=[];

const feeds=[
 "https://himalayas.app/jobs/api?limit=20",
 "https://jobicy.com/api/v2/remote-jobs?count=20"
];

for(const url of feeds){

 try{

  const r=await fetch(url);
  const data=await r.json();

  if(url.includes("himalayas")){
   (data.jobs||[]).forEach(j=>{
    jobs.push({
      source:"Himalayas",
      title:j.title,
      company:j.companyName,
      apply:j.applicationLink
    });
   });
  }

  if(url.includes("jobicy")){
   (data.jobs||[]).forEach(j=>{
    jobs.push({
      source:"Jobicy",
      title:j.jobTitle||j.title,
      company:j.companyName,
      apply:j.url
    });
   });
  }

 }catch(e){
  console.log(e.message);
 }

}

res.json({
 success:true,
 total:jobs.length,
 jobs
});

}catch(e){
 res.status(500).json({
  error:e.message
 });
}
};
