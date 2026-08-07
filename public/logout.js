async function logout(){

    if(typeof supabase === "undefined"){
        console.error("Supabase missing");
        return;
    }

    const client = supabase.createClient(
        SUPABASE_URL,
        SUPABASE_ANON_KEY
    );

    await client.auth.signOut();

    window.location.href="/login-v2.html";
}

window.logout = logout;
