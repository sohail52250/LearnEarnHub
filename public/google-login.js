async function googleLogin(){

    if(typeof supabase === "undefined"){
        alert("Supabase library missing");
        return;
    }

    const client = supabase.createClient(
        SUPABASE_URL,
        SUPABASE_ANON_KEY
    );

    const {data,error}=await client.auth.signInWithOAuth({
        provider:"google",
        options:{
            redirectTo:window.location.origin+"/dashboard-router.html"
        }
    });

    if(error){
        console.error(error);
        alert(error.message);
    }
}

window.googleLogin=googleLogin;
