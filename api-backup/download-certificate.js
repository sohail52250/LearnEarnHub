const db=require("../database");
const {
createCertificatePDF
}=require("./certificate-pdf");


module.exports=async(req,res)=>{


const {code}=req.query;


if(!code){

return res.status(400).json({
error:"Certificate code required"
});

}


const {data,error}=await db
.from("certificates")
.select("*")
.eq("certificate_code",code)
.single();


if(error || !data){

return res.status(404).json({
error:"Certificate not found"
});

}


return createCertificatePDF(data,res);


};
