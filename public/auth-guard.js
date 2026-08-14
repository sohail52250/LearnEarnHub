(function(){

const token = localStorage.getItem("token");

if(!token){
    window.location="/auth/sign-in.html";
}

})();
