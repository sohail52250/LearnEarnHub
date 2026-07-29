
async function submitPayment(){

const user=
JSON.parse(localStorage.getItem("user")||"null");


if(!user){

alert("Login required");

return;

}



let pkg=
document.getElementById("package").value;


let amount={

starter:1000,

professional:5000,

enterprise:15000

}[pkg];



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client
.from("business_payments")
.insert({

user_id:user.id,

package_name:pkg,

amount:amount,

payment_status:"pending"

});



document.getElementById("message").innerHTML=

error ?

error.message :

"Payment request submitted";

}


