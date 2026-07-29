#!/data/data/com.termux/files/usr/bin/bash

cat > public/partnerships.js <<'JS'
document
.getElementById("partnerForm")
.addEventListener("submit", async function(e){

e.preventDefault();

const payload = {
    name: document.getElementById("name").value,
    email: document.getElementById("email").value,
    partnership_type: document.getElementById("type").value,
    details: document.getElementById("details").value
};

const { error } = await supabase
.from("partnership_requests")
.insert([payload]);

if(error){
    document.getElementById("status").innerHTML =
    "❌ Error: " + error.message;
    return;
}

document.getElementById("status").innerHTML =
"✅ Partnership request submitted successfully.";

document.getElementById("partnerForm").reset();

});
JS

echo "Supabase partnership integration installed."
