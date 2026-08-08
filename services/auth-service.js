require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

if (!SUPABASE_URL) {
    console.warn("WARNING: SUPABASE_URL is not configured.");
}

async function signup(email, password) {
    const adminClient = createClient(
        SUPABASE_URL,
        SUPABASE_SERVICE_KEY
    );

    const { data, error } = await adminClient.auth.admin.createUser({
        email,
        password,
        email_confirm: true
    });

    if (error) {
        throw error;
    }

    return data?.user || null;
}

async function login(email, password) {
    const client = createClient(
        SUPABASE_URL,
        SUPABASE_ANON_KEY
    );

    const { data, error } = await client.auth.signInWithPassword({
        email,
        password
    });

    if (error) {
        throw error;
    }

    return data;
}

module.exports = {
    signup,
    login
};
