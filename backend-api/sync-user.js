require("dotenv").config();

const {syncUser}=require("../services/user-sync-service");


module.exports=async function(req,res){

try{

const user=await syncUser(req.body);


res.json({

success:true,

user

});


}catch(e){

res.status(500).json({

error:e.message

});

}

};

