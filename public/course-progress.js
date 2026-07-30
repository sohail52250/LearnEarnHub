async function loadProgress(){

const userId="bef3e115-d642-412b-b034-a84c1a19d1ee";

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
