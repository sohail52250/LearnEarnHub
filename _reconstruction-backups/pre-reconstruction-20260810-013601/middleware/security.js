const db=require("../database");


async function logSecurity(user_id,action,details){

try{

await db
.from("security_audit_logs")
.insert([{

user_id,
action,
details

}]);

}catch(e){

console.log("Security log error");

}

}



function requireRole(role){

return async(req,res,next)=>{


let userRole=req.headers["x-user-role"];


if(!userRole){

return res.status(401).json({

error:"Authentication required"

});

}



if(userRole!==role && userRole!=="super_admin"){

return res.status(403).json({

error:"Permission denied"

});

}


await logSecurity(

null,

"ACCESS",

"Role checked: "+role

);


next();


};


}



module.exports={

requireRole,

logSecurity

};
