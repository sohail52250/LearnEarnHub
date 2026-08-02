#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Business Logo Upload Setup ==="

# Backup
cp public/business-dashboard.html public/business-dashboard.html.bak 2>/dev/null
cp public/business-dashboard.js public/business-dashboard.js.bak 2>/dev/null


# Add logo input to dashboard if missing

grep -q "logo-file" public/business-dashboard.html || \
sed -i '/business-area/a\
<input type="file" id="logo-file" accept="image/*">\
<button onclick="uploadLogo()">Upload Logo</button>\
<div id="logo-status"></div>' public/business-dashboard.html



# Add upload function

cat >> public/business-dashboard.js <<'JS'


async function uploadLogo(){


const file =
document.getElementById("logo-file").files[0];


if(!file){

alert("Select logo first");

return;

}


const fileName =
Date.now()+"-"+file.name;



const {data,error}=await client
.storage
.from("business-logos")
.upload(fileName,file);



if(error){

document.getElementById("logo-status").innerHTML=
"❌ "+error.message;

return;

}



const {data:urlData}=client
.storage
.from("business-logos")
.getPublicUrl(fileName);



const logoUrl=urlData.publicUrl;



const {error:updateError}=await client

.from("business_profiles")

.update({

logo_url:logoUrl

})

.eq("owner_id",user.id);



if(updateError){

document.getElementById("logo-status").innerHTML=
"❌ "+updateError.message;

return;

}



document.getElementById("logo-status").innerHTML=
"✅ Logo uploaded successfully";


}

JS



echo ""
echo "=== Files updated ==="
echo ""
echo "IMPORTANT:"
echo "Create Supabase Storage bucket:"
echo "business-logos"
echo "Set it as Public"
echo ""

