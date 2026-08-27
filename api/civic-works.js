const { createClient } = require('@supabase/supabase-js');

const STAGES = ['need_reported','problem_identified','site_verified','work_designed','cost_estimated','budget_approved','procurement_contracted','work_completed','measurement_inspected','payment_completed'];
const TIMESTAMP_FIELDS = { problem_identified:'problem_identified_at', site_verified:'site_verified_at', work_designed:'work_designed_at', cost_estimated:'cost_estimated_at', budget_approved:'budget_approved_at', procurement_contracted:'procurement_contracted_at', work_completed:'work_completed_at', measurement_inspected:'measurement_inspected_at', payment_completed:'payment_completed_at' };

function db() {
  if (!process.env.SUPABASE_URL || !process.env.SUPABASE_SERVICE_KEY) throw new Error('Supabase server configuration is missing.');
  return createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);
}
function ref() { return `LEH-CIV-${Date.now().toString(36).toUpperCase()}-${Math.random().toString(36).slice(2,7).toUpperCase()}`; }
function clean(value,max=5000) { return String(value ?? '').trim().slice(0,max); }
function adminAuthorized(req) { return Boolean(process.env.CIVIC_ADMIN_KEY) && req.headers?.['x-civic-admin-key'] === process.env.CIVIC_ADMIN_KEY; }

module.exports = async function(req,res) {
  try {
    const client=db();
    if(req.method==='GET') {
      const reference=clean(req.query?.reference,80);
      if(!reference) return res.status(400).json({success:false,error:'Request reference is required.'});
      const {data,error}=await client.from('civic_requests').select('reference_id,location_text,category,description,status,created_at,updated_at,civic_workflow(*)').eq('reference_id',reference).maybeSingle();
      if(error) throw error;
      if(!data) return res.status(404).json({success:false,error:'Civic request not found.'});
      return res.status(200).json({success:true,request:data,stages:STAGES});
    }
    if(req.method!=='POST') return res.status(405).json({success:false,error:'Method not allowed.'});
    const body=req.body||{};
    const action=clean(body.action,40)||'report';

    if(action==='advance') {
      if(!adminAuthorized(req)) return res.status(403).json({success:false,error:'Civic administrator authorization required.'});
      const reference=clean(body.reference_id,80), stage=clean(body.stage,50);
      if(!reference || !STAGES.includes(stage) || stage==='need_reported') return res.status(400).json({success:false,error:'Valid reference and workflow stage are required.'});
      const {data:request,error:requestError}=await client.from('civic_requests').select('id,reference_id,status').eq('reference_id',reference).maybeSingle();
      if(requestError) throw requestError;
      if(!request) return res.status(404).json({success:false,error:'Civic request not found.'});
      const currentIndex=STAGES.indexOf(request.status), nextIndex=STAGES.indexOf(stage);
      if(nextIndex!==currentIndex+1) return res.status(409).json({success:false,error:`Stage must advance sequentially from ${request.status}.`});

      const workflowUpdate={updated_at:new Date().toISOString()};
      const timestampField=TIMESTAMP_FIELDS[stage];
      workflowUpdate[timestampField]=new Date().toISOString();
      for(const field of ['estimated_cost','approved_budget','contract_amount','measured_amount','paid_amount']) {
        if(body[field]!==undefined) {
          const n=Number(body[field]);
          if(!Number.isFinite(n) || n<0) return res.status(400).json({success:false,error:`Invalid ${field}.`});
          workflowUpdate[field]=n;
        }
      }
      if(body.currency!==undefined) workflowUpdate.currency=clean(body.currency,10)||'PKR';
      if(body.note!==undefined) workflowUpdate.notes=clean(body.note,5000)||null;

      const {error:workflowError}=await client.from('civic_workflow').update(workflowUpdate).eq('request_id',request.id);
      if(workflowError) throw workflowError;
      const {error:statusError}=await client.from('civic_requests').update({status:stage,updated_at:new Date().toISOString()}).eq('id',request.id);
      if(statusError) throw statusError;
      const {error:eventError}=await client.from('civic_workflow_events').insert({request_id:request.id,stage,action:'completed',note:clean(body.note,5000)||null});
      if(eventError) throw eventError;
      return res.status(200).json({success:true,reference_id:reference,status:stage,message:`Workflow advanced to ${stage}.`});
    }

    if(action!=='report') return res.status(400).json({success:false,error:'Invalid civic action.'});
    if(clean(body.website_url,200)) return res.status(400).json({success:false,error:'Invalid submission.'});
    const description=clean(body.description), location=clean(body.location_text,1000), category=clean(body.category,100);
    if(!description || description.length<10) return res.status(400).json({success:false,error:'Please provide a meaningful problem description.'});
    if(!location) return res.status(400).json({success:false,error:'Location is required.'});
    if(!category) return res.status(400).json({success:false,error:'Category is required.'});
    const request={reference_id:ref(),citizen_name:clean(body.citizen_name,150)||null,citizen_contact:clean(body.citizen_contact,200)||null,location_text:location,latitude:body.latitude===''||body.latitude==null?null:Number(body.latitude),longitude:body.longitude===''||body.longitude==null?null:Number(body.longitude),category,description,status:'need_reported'};
    if(![request.latitude,request.longitude].every(v=>v===null||Number.isFinite(v))) return res.status(400).json({success:false,error:'Invalid coordinates.'});
    const {data,error}=await client.from('civic_requests').insert(request).select('*').single();
    if(error) throw error;
    const {error:workflowError}=await client.from('civic_workflow').insert({request_id:data.id});
    if(workflowError) throw workflowError;
    const {error:eventError}=await client.from('civic_workflow_events').insert({request_id:data.id,stage:'need_reported',action:'completed',note:'Citizen need reported.'});
    if(eventError) throw eventError;
    return res.status(201).json({success:true,reference_id:data.reference_id,status:data.status,message:'Citizen need recorded for verification.'});
  } catch(error) {
    console.error('CIVIC WORKS API ERROR:',error);
    return res.status(500).json({success:false,error:error?.message||'Civic workflow operation failed.'});
  }
};
