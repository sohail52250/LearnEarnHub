#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub PDF Certificate Setup ==="


mkdir -p services api public/certificates



echo "Checking PDF package..."

if ! npm list pdfkit >/dev/null 2>&1
then
npm install pdfkit
fi



cat > services/pdf-certificate-service.js <<'JS'
require("dotenv").config();

const PDFDocument=require("pdfkit");
const fs=require("fs");
const path=require("path");

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function generateCertificate(user_id,course_id){


const {data:cert}=await db
.from("certificates")
.select(`
*,
courses(title_en),
users(email)
`)
.eq("user_id",user_id)
.eq("course_id",course_id)
.single();



if(!cert){

throw new Error("Certificate not found");

}



const filename=
`certificate-${cert.certificate_code}.pdf`;


const filepath=
path.join(
"public/certificates",
filename
);



const doc=new PDFDocument();


doc.pipe(
fs.createWriteStream(filepath)
);



doc.fontSize(30)
.text(
"LearnEarnHub",
{
align:"center"
}
);



doc.moveDown();



doc.fontSize(24)
.text(
"Certificate of Completion",
{
align:"center"
}
);



doc.moveDown(2);



doc.fontSize(18)
.text(
`This certificate is awarded to`,
{
align:"center"
}
);



doc.moveDown();



doc.fontSize(22)
.text(
cert.users?.email || "Learner",
{
align:"center"
}
);



doc.moveDown();



doc.fontSize(18)
.text(
`For successfully completing`,
{
align:"center"
}
);



doc.moveDown();



doc.fontSize(20)
.text(
cert.courses?.title_en || "Course",
{
align:"center"
}
);



doc.moveDown(2);



doc.fontSize(14)
.text(
`Certificate ID: ${cert.certificate_code}`,
{
align:"center"
}
);



doc.end();



return {

file:
"/certificates/"+filename

};


}



module.exports={
generateCertificate
};

JS



cat > api/pdf-certificate.js <<'JS'
const service=require("../services/pdf-certificate-service");


module.exports=async function(req,res){

try{


const result=
await service.generateCertificate(
req.body.user_id,
req.body.course_id
);


res.json(result);



}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "pdf-certificate" server.js
then

cat >> server.js <<'JS'


// PDF Certificate API

const pdfCertificate=require("./api/pdf-certificate");

app.post(
"/api/pdf-certificate",
pdfCertificate
);

JS

fi



node -c server.js


echo ""
echo "✅ PDF certificate generator created"

echo ""
echo "API:"
echo "POST /api/pdf-certificate"

echo ""
echo "Output folder:"
echo "public/certificates"


