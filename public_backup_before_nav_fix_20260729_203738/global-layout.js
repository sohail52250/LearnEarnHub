
async function loadPart(id,file){

let el=document.getElementById(id);

if(!el)return;


let r=await fetch(file);

el.innerHTML=await r.text();

}


loadPart(
"global-header",
"/global-header.html"
);


loadPart(
"global-footer",
"/global-footer.html"
);

