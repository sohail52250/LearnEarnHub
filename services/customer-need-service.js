require("dotenv").config();
const { createClient } = require("@supabase/supabase-js");

const db = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);

async function createCustomerNeed(input) {
  const payload = {
    person_type: input.person_type,
    request_type: input.request_type,
    title: input.title,
    problem_description: input.problem_description,
    desired_outcome: input.desired_outcome || null,
    urgency: input.urgency || "normal",
    location: input.location || null,
    budget: input.budget || null,
    contact_name: input.contact_name || null,
    contact_email: input.contact_email || null,
    contact_phone: input.contact_phone || null,
    preferred_contact: input.preferred_contact || null,
    attachment_url: input.attachment_url || null,
    status: "new",
    source: "public-need-form"
  };

  const { data, error } = await db
    .from("customer_needs")
    .insert(payload)
    .select("id, reference_id, created_at, status")
    .single();

  if (error) throw error;
  return data;
}

module.exports = { createCustomerNeed };
