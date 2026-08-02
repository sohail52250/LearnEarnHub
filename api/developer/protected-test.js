module.exports=async(req,res)=>{

 res.json({
  success:true,
  message:"Protected API access granted",
  developer:req.apiKey?.name || null,
  key_id:req.apiKey?.id || null,
  time:new Date()
 });

};
