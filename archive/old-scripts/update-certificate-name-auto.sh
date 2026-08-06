#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Certificate Name Update ==="


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


const {data:cert,error}=await db
.from("certificates")
.select(`
*,
courses(title_en)
`)
.eq("user_id",user_id)
.eq("course_id",course_id)
.single();


if(error) throw error;



const {data:profile}=await db
.from("profiles")
.select("full_name,avatar_url")
.eq("user_id",user_id)
.single();



const learnerName=
profile?.full_name || "LearnEarnHub Learner";



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



doc.fontSize(32)
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
"This certificate is proudly awarded to",
{
align:"center"
}
);



doc.moveDown();



doc.fontSize(26)
.text(
learnerName,
{
align:"center"
}
);



doc.moveDown();



doc.fontSize(18)
.text(
`For completing ${cert.courses.title_en}`,
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



doc.fontSize(12)
.text(
"Learn • Earn • Grow",
{
align:"center"
}
);



doc.end();



return {

success:true,

file:
"/certificates/"+filename,

learner:
learnerName

};


}



module.exports={
generateCertificate
};

JS



node -c services/pdf-certificate-service.js


echo ""
echo "✅ Certificate updated"
echo "Now PDF uses profile full_name"

