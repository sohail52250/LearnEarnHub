#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Restore certificate API ==="

cp api_disabled/certificate.js api/certificate.js
cp api_disabled/generate-certificate.js api/generate-certificate.js


echo "=== Add certificate security middleware ==="

cat > api/certificate-security.js <<'JS'
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
JS


echo "=== Check files ==="

ls -la api/*certificate*


echo "=== Git save ==="

git add api

git commit -m "Restore secure certificate generation API" || true

git push


echo "DONE"
