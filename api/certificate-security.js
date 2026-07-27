const crypto=require("crypto");


function createCertificateCode(){

return "LEH-CERT-" +
Date.now().toString(36).toUpperCase()
+
"-"+
crypto.randomBytes(3)
.toString("hex")
.toUpperCase();

}


function createHash(data){

return crypto
.createHash("sha256")
.update(JSON.stringify(data))
.digest("hex");

}


module.exports={
createCertificateCode,
createHash
};
