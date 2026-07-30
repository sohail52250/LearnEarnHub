async function loadProgress(){

const { data:{ user } } = await supabase.auth.getUser();

if(!user){
 document.getElementById("courses").innerHTML="Please login first";
 return;
}

const userId=user.id;

try{

const res=await fetch(
"/api/course-progress?user_id="+userId
);

const data=await res.json();

let box=document.getElementById("courses");

if(!data.success){
box.innerHTML="No progress found";
return;
}


box.innerHTML="";

data.courses.forEach(c=>{

let div=document.createElement("div");

div.className="card";

div.innerHTML=
`
<h3>${c.title_en || "Course"}</h3>
<p>Status: ${c.unlocked ? "Unlocked ✅":"Locked 🔒"}</p>
`;

box.appendChild(div);

});

}catch(e){

console.log(e);

}

}

loadProgress();
