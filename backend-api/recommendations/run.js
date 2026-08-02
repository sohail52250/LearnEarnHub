const engine=require("../../services/ai/recommendation-engine");

module.exports=async function(req,res){

 try{

  await engine();

  res.json({
    success:true,
    message:"AI recommendation completed"
  });

 }catch(e){

  res.status(500).json({
   error:e.message
  });

 }

};
