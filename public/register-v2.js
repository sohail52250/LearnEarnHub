async function registerUser() {
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const passwordElement = document.getElementById("password");
    const password = passwordElement ? passwordElement.value : "";
    const roleElement = document.getElementById("role");
    const role = roleElement ? roleElement.value : "student";

    if (!name || !email || !password) {
        alert("Please enter your name, email and password.");
        return;
    }

    const client = supabase.createClient(
        SUPABASE_URL,
        SUPABASE_ANON_KEY
    );

    const { data, error } = await client.auth.signUp({
        email,
        password,
        options: {
            data: {
                name,
                full_name: name,
                role
            }
        }
    });

    if (error) {
        console.error("Registration error:", error);
        alert(error.message);
        return;
    }

    if (!data.user) {
        alert("Registration started. Please check your email to confirm your account.");
        return;
    }

    /*
     * The database trigger creates:
     *   profiles
     *   user_profiles
     *   user_roles
     *
     * automatically after auth.users is created.
     */

    localStorage.setItem(
        "user",
        JSON.stringify({
            id: data.user.id,
            role
        })
    );

    if (data.session) {
        window.location.href = "/dashboard-router.html";
    } else {
        alert("Registration successful. Please check your email to confirm your account.");
    }
}

window.registerUser = registerUser;
