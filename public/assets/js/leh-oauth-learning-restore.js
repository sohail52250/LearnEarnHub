(function(global){
"use strict";

async function getClient(){
    var clients=[
        global.supabaseClient,
        global.supabase
    ];

    for(var i=0;i<clients.length;i++){
        var c=clients[i];
        if(c && c.auth && typeof c.auth.getSession==="function"){
            return c;
        }
    }

    return null;
}

async function restore(){
    if(!global.LEHOAuthLearningReturn) return;

    var path=window.location.pathname;

    if(path.indexOf("/auth/sign-in.html")!==0) return;

    var client=await getClient();

    if(!client) return;

    try{
        var result=await client.auth.getSession();

        if(result &&
           result.data &&
           result.data.session){

            var target=global.LEHOAuthLearningReturn.get();

            if(target &&
               target.indexOf("/auth/sign-in.html")!==0){

                global.LEHOAuthLearningReturn.clear();
                window.location.replace(target);
            }
        }
    }catch(error){
        console.warn("OAuth session restoration failed.",error);
    }
}

if(document.readyState==="loading"){
    document.addEventListener("DOMContentLoaded",restore);
}else{
    restore();
}

})(window);
