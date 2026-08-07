async function logout(){

    if(typeof supabase === "undefined"){
        console.error("Supabase library missing");
        return;
    }

    const client = supabase.createClient(
        SUPABASE_URL,
        SUPABASE_ANON_KEY
    );

    const { error } = await client.auth.signOut();

    if(error){
        console.error(error);
        alert(error.message);
        return;
    }

    window.location.href = "/login-v2.html";
}

window.logout = logout;
