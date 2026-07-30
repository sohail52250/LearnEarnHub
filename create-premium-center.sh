
#!/data/data/com.termux/files/usr/bin/bash

cat > public/premium-center.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Premium Center</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>

<body>

<h1>💎 Premium Center</h1>

<h2>Business Packages</h2>

<div id="packages">
Loading...
</div>

<script src="/premium-center.js"></script>

</body>

</html>
HTML



cat > public/premium-center.js <<'JS'

const client=supabaseClient;



async function loadPackages(){


const {data,error}=await client

.from("business_packages")

.select("*")

.eq("status","active")

.order("price");



if(error){

console.log(error);

return;

}



document.getElementById("packages").innerHTML=

(data||[])
.map(p=>`

<div class="card">

<h2>
${p.package_name}
</h2>

<p>
Price:
${p.price}
</p>

<p>
${p.features}
</p>

<button onclick="buyPackage('${p.package_name}',${p.price})">

Purchase

</button>

</div>

`)
.join("")

||
"No packages available";


}



async function buyPackage(name,price){


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

alert("Please login");

return;

}



await client

.from("business_payments")

.insert({

user_id:user.id,

package_name:name,

amount:price,

currency:"PKR",

payment_status:"pending"

});


alert(
"Package request created"
);


}



document.addEventListener(

"DOMContentLoaded",

loadPackages

);

JS


echo "Premium Center Created"

