
document.addEventListener(
"DOMContentLoaded",
async()=>{

const allowed =
await checkAdminAccess();


if(!allowed){

return;

}


console.log(
"Admin verified"
);


});

