(function () {
  async function googleLogin() {
    try {
      if (typeof supabase === "undefined") {
        console.error("Google Login: Supabase library missing");
        alert("Google Sign-In is temporarily unavailable. Please try again.");
        return;
      }

      const client =
        window.supabaseClient ||
        supabase.createClient(
          window.SUPABASE_URL,
          window.SUPABASE_ANON_KEY
        );

      if (!client) {
        console.error("Google Login: Supabase client unavailable");
        alert("Google Sign-In is temporarily unavailable. Please try again.");
        return;
      }

      const redirectTo =
        window.location.origin + "/dashboard-router.html";

      console.log("Google Login: starting OAuth");
      console.log("Google Login redirect:", redirectTo);

      const { error } = await client.auth.signInWithOAuth({
        provider: "google",
        options: {
          redirectTo: redirectTo
        }
      });

      if (error) {
        console.error("Google Login OAuth error:", error);
        alert("Google Sign-In failed: " + error.message);
      }
    } catch (error) {
      console.error("Google Login unexpected error:", error);
      alert("Google Sign-In failed. Please try again.");
    }
  }

  window.googleLogin = googleLogin;
})();
