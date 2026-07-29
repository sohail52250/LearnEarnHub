function saveSession(data){

    if(data.token){
        localStorage.setItem(
            "token",
            data.token
        );
    }

    if(data.user){

        localStorage.setItem(
            "user",
            JSON.stringify(data.user)
        );

        localStorage.setItem(
            "role",
            data.user.role || "learner"
        );
    }

}


function logout(){

    localStorage.removeItem("token");
    localStorage.removeItem("user");
    localStorage.removeItem("role");

    location.href="/index.html";
}


function getUser(){

    try{
        return JSON.parse(
            localStorage.getItem("user")
        );
    }catch(e){
        return null;
    }

}
