#!/data/data/com.termux/files/usr/bin/bash

echo "Adding business verification system..."

# Create SQL file for Supabase

cat > business-verification.sql <<'SQL'
alter table partnership_requests
add column if not exists verified boolean default false;

alter table partnership_requests
add column if not exists company_description text;

alter table partnership_requests
add column if not exists logo_url text;

create table if not exists business_profiles (
id uuid default gen_random_uuid() primary key,
owner_id uuid references auth.users(id),
company_name text,
email text,
phone text,
website text,
description text,
verified boolean default false,
created_at timestamptz default now()
);

alter table business_profiles enable row level security;

create policy "Public view verified businesses"
on business_profiles
for select
to public
using (verified=true);

create policy "Authenticated business insert"
on business_profiles
for insert
to authenticated
with check (true);

SQL


# Create business profile page

cat > public/business-profile.html <<'HTML'
<!DOCTYPE html>
<html>

<head>
<title>Business Profile - LearnEarnHub</title>
<link rel="stylesheet" href="/style.css">
</head>

<body>

<div id="global-header"></div>

<div class="card">

<h1>🏢 Business Profile</h1>

<div id="profile">
Loading...
</div>

</div>


<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

<script src="/business-profile.js"></script>

</body>
</html>
HTML


cat > public/business-profile.js <<'JS'

async function loadBusinesses(){

let {data,error}=await supabaseClient
.from("business_profiles")
.select("*")
.eq("verified",true);


if(error){

document.getElementById("profile").innerHTML=error.message;
return;

}


document.getElementById("profile").innerHTML=data.map(b=>`

<div class="card">

<h2>
${b.company_name}
${b.verified ? "✅ Verified" : ""}
</h2>

<p>${b.description || ""}</p>

<p>${b.email}</p>

<a href="${b.website || '#'}">
${b.website || ""}
</a>

</div>

`).join("");

}


loadBusinesses();

JS


echo "Business verification files created."
echo "Run SQL from business-verification.sql in Supabase dashboard."

