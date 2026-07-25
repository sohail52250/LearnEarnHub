alter table business_profiles
add column if not exists verification_status text default 'pending';

alter table business_profiles
add column if not exists verification_type text default 'referral';

alter table business_profiles
add column if not exists trust_score integer default 0;

alter table business_profiles
add column if not exists verified_by uuid;

alter table business_profiles
add column if not exists verified_at timestamp;
