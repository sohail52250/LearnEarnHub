
-- Enable security
alter table ai_deal_requests enable row level security;


-- Remove old policies if they exist
drop policy if exists "public_insert_ai_deals" on ai_deal_requests;
drop policy if exists "admin_read_ai_deals" on ai_deal_requests;
drop policy if exists "admin_update_ai_deals" on ai_deal_requests;


-- Anyone can submit a request
create policy "public_insert_ai_deals"
on ai_deal_requests
for insert
with check (true);


-- Only authenticated admin can view
create policy "admin_read_ai_deals"
on ai_deal_requests
for select
using (
auth.jwt()->>'role' = 'admin'
);


-- Only admin can approve
create policy "admin_update_ai_deals"
on ai_deal_requests
for update
using (
auth.jwt()->>'role' = 'admin'
);


