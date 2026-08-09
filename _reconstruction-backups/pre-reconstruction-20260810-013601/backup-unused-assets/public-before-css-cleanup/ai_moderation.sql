
alter table businesses
add column if not exists ai_status text default 'pending',
add column if not exists ai_risk text default 'low',
add column if not exists ai_reason text;


alter table advertisements
add column if not exists ai_status text default 'pending',
add column if not exists ai_risk text default 'low',
add column if not exists ai_reason text;


alter table business_deals
add column if not exists ai_status text default 'pending',
add column if not exists ai_risk text default 'low',
add column if not exists ai_reason text;

