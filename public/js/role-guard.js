(function(){

const token = localStorage.getItem("token");

const path = window.location.pathname.toLowerCase();

if(!token){

const protectedPatterns = [
"/admin",
"/dashboard",
"/enterprise",
"/instructor",
"/sponsor",
"/seller",
"/notifications",
"/investment"
];

for(const p of protectedPatterns){
    if(path.includes(p)){
        window.location="/auth/sign-in.html";
        return;
    }
}

}

})();
