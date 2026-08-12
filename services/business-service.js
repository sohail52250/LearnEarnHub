const { createClient } = require("@supabase/supabase-js");

function client() {
    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_SERVICE_KEY;

    if (!url || !key) {
        throw new Error("Supabase server configuration is missing.");
    }

    return createClient(url, key);
}

function reference(prefix) {
    const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    let out = prefix + "-";

    for (let i = 0; i < 10; i++) {
        out += chars[Math.floor(Math.random() * chars.length)];
    }

    return out;
}

async function createBusiness(payload) {
    const db = client();

    const data = {
        reference_id: reference("LEH-BIZ"),
        owner_id: payload.owner_id || null,
        business_name: payload.business_name,
        legal_name: payload.legal_name || null,
        business_type: payload.business_type || null,
        category: payload.category || null,
        subcategory: payload.subcategory || null,
        description: payload.description || null,
        website: payload.website || null,
        social_links: payload.social_links || {},

        contact_person_name: payload.contact_person_name || null,
        contact_role: payload.contact_role || null,
        contact_email: payload.contact_email || null,
        contact_phone: payload.contact_phone || null,
        contact_whatsapp: payload.contact_whatsapp || null,

        country: payload.country || null,
        city: payload.city || null,
        address: payload.address || null,
        postal_code: payload.postal_code || null,

        business_hours: payload.business_hours || null,
        years_active: payload.years_active || null,
        staff_count: payload.staff_count || null,

        products_services: payload.products_services || null,
        current_activities: payload.current_activities || null,
        operational_needs: payload.operational_needs || null,

        introducer_name: payload.introducer_name || null,
        introducer_relationship: payload.introducer_relationship || null,
        introducer_contact: payload.introducer_contact || null,
        introducer_reference: payload.introducer_reference || null,

        visibility: payload.visibility || "private",
        verification_status: "pending",
        status: "active"
    };

    const { data: row, error } = await db
        .from("businesses")
        .insert(data)
        .select("*")
        .single();

    if (error) throw error;

    return row;
}

async function getBusiness(referenceId) {
    const db = client();

    const { data, error } = await db
        .from("businesses")
        .select("*")
        .eq("reference_id", referenceId)
        .maybeSingle();

    if (error) throw error;

    return data;
}

async function createTask(businessReference, payload) {
    const db = client();

    const { data: business, error: businessError } = await db
        .from("businesses")
        .select("id,reference_id")
        .eq("reference_id", businessReference)
        .single();

    if (businessError) throw businessError;

    const row = {
        business_id: business.id,
        reference_id: reference("LEH-TASK"),
        task_description: payload.task_description,
        payment_amount:
            payload.payment_amount === "" ||
            payload.payment_amount == null
                ? null
                : Number(payload.payment_amount),
        payment_currency: payload.payment_currency || "PKR",
        frequency: payload.frequency || null,
        time_required_minutes:
            payload.time_required_minutes === "" ||
            payload.time_required_minutes == null
                ? null
                : Number(payload.time_required_minutes),
        deadline: payload.deadline || null,
        status: "open"
    };

    const { data, error } = await db
        .from("business_tasks")
        .insert(row)
        .select("*")
        .single();

    if (error) throw error;

    return data;
}

module.exports = {
    createBusiness,
    getBusiness,
    createTask
};
