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
