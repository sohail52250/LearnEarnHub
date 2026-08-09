
fetch("/language-selector.html")
.then(r=>r.text())
.then(t=>{

let box=document.getElementById(
"language-selector"
);

if(box){

box.innerHTML=t;

}

});


