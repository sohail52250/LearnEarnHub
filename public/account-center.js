async function createUserProfile(data) {
    const client = supabase.createClient(
        SUPABASE_URL,
        SUPABASE_ANON_KEY
    );

    const {
        data: sessionData,
        error: sessionError
    } = await client.auth.getSession();

    if (sessionError || !sessionData.session) {
        console.error("No authenticated session:", sessionError);
        return null;
    }

    const user = sessionData.session.user;

    const payload = {
        user_id: user.id,
        full_name: data.full_name || data.name || "",
        profile_type: data.profile_type || "student",
        avatar_url: data.avatar_url || null,
        bio: data.bio || null,
        country: data.country || null,
        language: data.language || "en"
    };

    const {
        data: result,
        error
    } = await client
        .from("user_profiles")
        .upsert(payload, {
            onConflict: "user_id"
        })
        .select()
        .single();

    if (error) {
        console.error("User profile error:", error);
        return null;
    }

    return result;
}

window.createUserProfile = createUserProfile;
