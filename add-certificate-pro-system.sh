#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Install packages ==="

npm install qrcode pdfkit --save


echo "=== Create certificate generator service ==="

cat > api/certificate-pdf.js <<'JS'
const PDFDocument=require("pdfkit");
const QRCode=require("qrcode");


async function createCertificatePDF(cert,res){

const verifyURL=
"https://learn-earnhub.vercel.app/verify-certificate.html?code="
+cert.certificate_code;


const qr=
await QRCode.toDataURL(verifyURL);


const doc=new PDFDocument();


res.setHeader(
"Content-Type",
"application/pdf"
);


res.setHeader(
"Content-Disposition",
`attachment; filename=${cert.certificate_code}.pdf`
);


doc.pipe(res);


doc
.fontSize(28)
.text(
"LearnEarnHub Certificate",
{
align:"center"
}
);


doc.moveDown();


doc
.fontSize(18)
.text(
cert.certificate_title || 
"Course Completion Certificate",
{
align:"center"
}
);


doc.moveDown();


doc
.fontSize(14)
.text(
"Certificate Code: "+
cert.certificate_code
);


doc.moveDown();


doc
.fontSize(12)
.text(
"Verification URL:"
);


doc.text(verifyURL);


const image =
Buffer.from(
qr.split(",")[1],
"base64"
);


doc.image(
image,
{
width:120,
align:"center"
}
);


doc.end();

}


module.exports={
createCertificatePDF
};
JS


echo "=== Create QR download API ==="

cat > api/download-certificate.js <<'JS'
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
JS


echo "=== Update certificate frontend ==="

python3 <<'PY'
p="public/verify-certificate.html"

try:
    with open(p,encoding="utf8") as f:
        s=f.read()

    if "download-certificate" not in s:

        s=s.replace(
        "</body>",
        '''
        <script>
        function downloadCertificate(code){
        window.location="/api/download-certificate?code="+code;
        }
        </script>
        </body>
        '''
        )

    with open(p,"w",encoding="utf8") as f:
        f.write(s)

except Exception as e:
    print(e)

PY


echo "=== Save ==="

git add .

git commit -m "Add QR verified PDF certificate system" || true

git push


echo "DONE"
