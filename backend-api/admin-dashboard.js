const service=require("../services/admin-dashboard-service");


module.exports=async function(req,res){

try{

res.json(
await service.stats()
);


}catch(e){

res.status(500).json({

error:e.message

});

}

};

