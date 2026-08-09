const requests={};


function rateLimit(req,res,next){


const ip=
req.headers["x-forwarded-for"] ||
req.socket.remoteAddress;



requests[ip]=(requests[ip]||0)+1;



if(requests[ip]>100){


return res.status(429).json({

error:"Too many requests"

});

}



next();


}



module.exports=rateLimit;

