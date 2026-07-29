document.getElementById("partnerForm").addEventListener("submit", function(e){
e.preventDefault();

const data = {
name: document.getElementById("name").value,
email: document.getElementById("email").value,
type: document.getElementById("type").value,
details: document.getElementById("details").value,
date: new Date().toISOString()
};

let requests = JSON.parse(localStorage.getItem("partnership_requests") || "[]");
requests.push(data);
localStorage.setItem("partnership_requests", JSON.stringify(requests));

document.getElementById("status").innerHTML =
"<p>✅ Partnership request submitted successfully.</p>";

document.getElementById("partnerForm").reset();
});
