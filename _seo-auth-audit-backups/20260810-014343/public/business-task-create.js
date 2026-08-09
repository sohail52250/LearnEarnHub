
const client=supabaseClient;



async function createTask(){


const user=JSON.parse(
localStorage.getItem("user") || "null"
);



if(!user){

alert("Please login");

return;

}



const task={

creator_id:user.id,

title:
document.getElementById("title").value,

description:
document.getElementById("description").value,


required_skill:
document.getElementById("skill").value,


reward_amount:
Number(
document.getElementById("reward").value
),


currency:
document.getElementById("currency").value,


status:"active"

};



const {error}=await client

.from("earning_tasks")

.insert(task);



if(error){

alert(error.message);

return;

}



alert(
"✅ Task created successfully"
);


}



