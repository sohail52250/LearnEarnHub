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

async function listOpportunities(options = {}) {
    const db = client();

    const requestedLimit = Number(options.limit || 100);

    const limit = Math.min(
        Math.max(requestedLimit, 1),
        100
    );

    const { data, error } = await db
        .from("business_tasks")
        .select(`
            *,
            businesses!inner(
                reference_id,
                business_name,
                visibility,
                verification_status,
                status
            )
        `)
        .eq("status", "open")
        .eq("businesses.visibility", "public")
        .eq("businesses.verification_status", "approved")
        .eq("businesses.status", "active")
        .order("created_at", { ascending: false })
        .limit(limit);

    if (error) throw error;

    return (data || []).map(task => ({
        ...task,
        business_reference:
            task.businesses?.reference_id || null,
        business_name:
            task.businesses?.business_name || null
    }));
}

async function getOpportunity(referenceId) {
    const db = client();

    const reference = String(referenceId || '').trim();

    if (!reference) {
        return null;
    }

    const { data, error } = await db
        .from("business_tasks")
        .select(`
            id,
            reference_id,
            task_description,
            payment_amount,
            payment_currency,
            frequency,
            time_required_minutes,
            deadline,
            required_skills,
            status,
            created_at,
            updated_at,
            businesses!inner(
                reference_id,
                business_name,
                business_type,
                category,
                description,
                website,
                country,
                city,
                visibility,
                verification_status,
                status
            )
        `)
        .eq("reference_id", reference)
        .eq("status", "open")
        .eq("businesses.visibility", "public")
        .eq("businesses.verification_status", "approved")
        .eq("businesses.status", "active")
        .maybeSingle();

    if (error) throw error;

    if (!data) {
        return null;
    }

    return {
        id: data.id,
        reference_id: data.reference_id,
        task_description: data.task_description,
        payment_amount: data.payment_amount,
        payment_currency: data.payment_currency,
        frequency: data.frequency,
        time_required_minutes: data.time_required_minutes,
        deadline: data.deadline,
        required_skills: Array.isArray(data.required_skills)
            ? data.required_skills
            : [],
        status: data.status,
        created_at: data.created_at,
        updated_at: data.updated_at,
        business: data.businesses
            ? {
                reference_id:
                    data.businesses.reference_id || null,
                business_name:
                    data.businesses.business_name || null,
                business_type:
                    data.businesses.business_type || null,
                category:
                    data.businesses.category || null,
                description:
                    data.businesses.description || null,
                website:
                    data.businesses.website || null,
                country:
                    data.businesses.country || null,
                city:
                    data.businesses.city || null
            }
            : null
    };
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
        required_skills: [
            ...new Set(
                (
                    Array.isArray(payload.required_skills)
                        ? payload.required_skills
                        : String(payload.required_skills || "").split(",")
                )
                    .map(value => String(value || "").trim().toLowerCase())
                    .filter(Boolean)
            )
        ],
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
    createTask,
    getOpportunity,
    listOpportunities
};
