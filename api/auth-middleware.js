const jwt = require("jsonwebtoken");

function requireAuth(req,res,next){

    const auth = req.headers.authorization;

    if(!auth){
        return res.status(401).json({
            error:"Login required"
        });
    }

    const token = auth.replace("Bearer ","");

    try{

        const user = jwt.verify(
            token,
            process.env.JWT_SECRET || "learn-earnhub-secret"
        );

        req.user=user;
        next();

    }catch(e){

        return res.status(401).json({
            error:"Invalid token"
        });

    }
}


function requireRole(...roles){

    return (req,res,next)=>{

        if(!req.user){
            return res.status(401).json({
                error:"Unauthorized"
            });
        }

        if(
            req.user.role==="admin" ||
            roles.includes(req.user.role)
        ){
            return next();
        }

        return res.status(403).json({
            error:"Access denied"
        });

    };

}


module.exports={
 requireAuth,
 requireRole
};
