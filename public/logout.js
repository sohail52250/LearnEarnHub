async function logout(){

    try{

        if(window.supabase && window.supabase.auth){

            await window.supabase.auth.signOut();

        }

        localStorage.clear();

        window.location.href="/login-v2.html";

    }catch(error){

        console.error("Logout failed:", error);

    }

}
