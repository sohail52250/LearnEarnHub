const service=require("../services/dashboard-service");


module.exports=async function(req,res){

try{


const data=
await service.getDashboard(
req.query.user_id
);


res.json(data);



}catch(e){

res.status(500).json({

error:e.message

});

}


};

