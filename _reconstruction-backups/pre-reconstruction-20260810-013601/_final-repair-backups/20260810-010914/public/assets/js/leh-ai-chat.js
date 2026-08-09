(function(){

document.addEventListener("DOMContentLoaded",()=>{

let btn=document.createElement("div");
btn.className="leh-ai-button";
btn.innerHTML="💬";
document.body.appendChild(btn);


let box=document.createElement("div");
box.className="leh-ai-box";

box.innerHTML=`
<div class="leh-ai-header">
🤖 LearnEarnHub AI
</div>

<div class="leh-ai-body" id="leh-ai-messages">
Hello! I am LearnEarnHub AI Assistant.<br>
Ask me about courses, skills, opportunities or business.
</div>

<div class="leh-ai-input">
<input id="leh-ai-text" placeholder="Ask something...">
<button id="leh-ai-send">Send</button>
</div>
`;

document.body.appendChild(box);


btn.onclick=()=>{
box.style.display=
box.style.display==="flex" ? "none":"flex";
};


document.getElementById("leh-ai-send").onclick=()=>{

let input=document.getElementById("leh-ai-text");
let msg=input.value.trim();

if(!msg)return;

let area=document.getElementById("leh-ai-messages");

area.innerHTML+=
"<br><b>You:</b> "+msg;

area.innerHTML+=
"<br><b>AI:</b> I can help you with LearnEarnHub courses, skills, opportunities and business guidance.";

input.value="";

area.scrollTop=area.scrollHeight;

};

});

})();
