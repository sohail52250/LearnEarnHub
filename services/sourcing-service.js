const { createClient } = require('@supabase/supabase-js');

function db() {
  const url = process.env.SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_KEY;
  if (!url || !key) throw new Error('Supabase server configuration is missing.');
  return createClient(url, key);
}

function ref(prefix) {
  return `${prefix}-${Date.now().toString(36).toUpperCase()}-${Math.random().toString(36).slice(2, 7).toUpperCase()}`;
}

function bearer(req) {
  const value = req.headers?.authorization || req.headers?.Authorization || '';
  return value.startsWith('Bearer ') ? value.slice(7) : '';
}

async function userFromRequest(req) {
  const token = bearer(req);
  if (!token) return null;
  const client = db();
  const { data, error } = await client.auth.getUser(token);
  if (error) return null;
  return data?.user || null;
}

async function listSuppliers(options = {}) {
  const limit = Math.min(Math.max(Number(options.limit) || 30, 1), 100);
  const client = db();
  const { data, error } = await client.from('businesses')
    .select('id,reference_id,business_name,legal_name,business_type,category,subcategory,description,website,country,city,address,contact_person_name,contact_role,contact_email,contact_phone,contact_whatsapp')
    .eq('status','active').eq('visibility','public').eq('verification_status','approved')
    .order('created_at',{ascending:false}).limit(limit);
  if (error) throw error;
  return data || [];
}

async function createRequest(req, payload) {
  const user = await userFromRequest(req);
  if (!user) throw Object.assign(new Error('Sign in is required to create a sourcing request.'), { status: 401 });
  const product = String(payload.product_service || '').trim();
  const location = String(payload.delivery_location || '').trim();
  if (!product || !location) throw Object.assign(new Error('Product/service and delivery location are required.'), { status: 400 });
  const quantity = Number(payload.quantity || 1);
  if (!Number.isFinite(quantity) || quantity <= 0) throw Object.assign(new Error('Quantity must be greater than zero.'), { status: 400 });

  const client = db();
  const row = {
    reference_id: ref('LEH-SRC'), customer_id: user.id, product_service: product,
    quantity, specifications: payload.specifications || null, delivery_location: location,
    needed_by: payload.needed_by || null, budget: payload.budget === '' || payload.budget == null ? null : Number(payload.budget),
    budget_currency: payload.budget_currency || 'PKR', condition: payload.condition || 'New',
    customer_name: payload.customer_name || user.user_metadata?.full_name || null,
    customer_email: payload.customer_email || user.email || null, customer_phone: payload.customer_phone || null,
    customer_whatsapp: payload.customer_whatsapp || null, status: 'open'
  };
  const { data, error } = await client.from('sourcing_requests').insert(row).select('*').single();
  if (error) throw error;
  return data;
}

async function listMyRequests(req) {
  const user = await userFromRequest(req);
  if (!user) throw Object.assign(new Error('Sign in is required.'), { status: 401 });
  const client = db();
  const { data, error } = await client.from('sourcing_requests').select('*,sourcing_quotations(*)').eq('customer_id',user.id).order('created_at',{ascending:false}).limit(100);
  if (error) throw error;
  return data || [];
}

async function createQuote(req, payload) {
  const user = await userFromRequest(req);
  if (!user) throw Object.assign(new Error('Sign in is required to submit a quotation.'), { status: 401 });
  const requestId = String(payload.request_id || '').trim();
  const businessId = String(payload.supplier_business_id || '').trim();
  const unitPrice = Number(payload.unit_price);
  if (!requestId || !businessId || !Number.isFinite(unitPrice) || unitPrice < 0) throw Object.assign(new Error('Request, supplier business and valid unit price are required.'), { status: 400 });
  const client = db();
  const { data: business, error: bErr } = await client.from('businesses').select('id,owner_id,contact_person_name,contact_email,contact_phone,contact_whatsapp').eq('id',businessId).single();
  if (bErr || !business || business.owner_id !== user.id) throw Object.assign(new Error('You can only quote as the owner of the supplier business.'), { status: 403 });
  const { data: request, error: rErr } = await client.from('sourcing_requests').select('id,quantity,status').eq('id',requestId).single();
  if (rErr || !request || request.status !== 'open') throw Object.assign(new Error('Sourcing request is not available for quotation.'), { status: 404 });
  const quantity = Number(payload.quantity || request.quantity || 1);
  const row = {
    reference_id: ref('LEH-QTE'), request_id: requestId, supplier_business_id: businessId,
    supplier_contact_name: payload.supplier_contact_name || business.contact_person_name || null,
    supplier_contact_email: payload.supplier_contact_email || business.contact_email || null,
    supplier_contact_phone: payload.supplier_contact_phone || business.contact_phone || null,
    supplier_contact_whatsapp: payload.supplier_contact_whatsapp || business.contact_whatsapp || null,
    unit_price: unitPrice, quantity, delivery_cost: Number(payload.delivery_cost || 0), currency: payload.currency || 'PKR',
    estimated_delivery_days: payload.estimated_delivery_days == null || payload.estimated_delivery_days === '' ? null : Number(payload.estimated_delivery_days),
    valid_until: payload.valid_until || null, terms: payload.terms || null, status: 'submitted'
  };
  const { data, error } = await client.from('sourcing_quotations').insert(row).select('*').single();
  if (error) throw error;
  return data;
}

module.exports = { listSuppliers, createRequest, listMyRequests, createQuote, userFromRequest };
