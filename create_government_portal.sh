#!/data/data/com.termux/files/usr/bin/bash

mkdir -p public
mkdir -p database

cat > public/government-portal.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Government Portal</title>
</head>
<body>
<h1>Government & Legal Authority Portal</h1>

<form id="govRequestForm">

<label>Department Name</label><br>
<input type="text" name="department" required><br><br>

<label>Officer Name</label><br>
<input type="text" name="officer_name" required><br><br>

<label>Officer ID</label><br>
<input type="text" name="officer_id" required><br><br>

<label>Official Email</label><br>
<input type="email" name="official_email" required><br><br>

<label>Country</label><br>
<input type="text" name="country" required><br><br>

<label>Request Type</label><br>
<select name="request_type">
<option>User Information</option>
<option>Business Information</option>
<option>Company Information</option>
<option>Fraud Investigation</option>
<option>Other</option>
</select><br><br>

<label>Case Reference</label><br>
<input type="text" name="case_reference"><br><br>

<label>Legal Basis</label><br>
<textarea name="legal_basis"></textarea><br><br>

<label>Upload Court Order</label><br>
<input type="file" name="court_order"><br><br>

<button type="submit">Submit Request</button>

</form>

</body>
</html>
HTML

cat > database/government_requests.sql <<'SQL'
create table if not exists government_requests (
 id bigint generated always as identity primary key,
 department_name text,
 officer_name text,
 officer_id text,
 official_email text,
 country text,
 request_type text,
 case_reference text,
 legal_basis text,
 request_status text default 'pending',
 created_at timestamptz default now()
);

create table if not exists government_accounts (
 id bigint generated always as identity primary key,
 department_name text,
 officer_name text,
 officer_id text,
 official_email text,
 verified boolean default false,
 created_at timestamptz default now()
);

create table if not exists compliance_audit_logs (
 id bigint generated always as identity primary key,
 actor text,
 action text,
 details text,
 created_at timestamptz default now()
);
SQL

cat > public/legal-request-center.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Legal Request Center</title>
</head>
<body>

<h1>Legal Request Center</h1>

<ul>
<li>Government Requests</li>
<li>Compliance Review</li>
<li>Audit Logs</li>
<li>Verification Queue</li>
<li>Evidence Vault</li>
</ul>

</body>
</html>
HTML

echo "Government Portal Created"
echo "SQL Created"
echo "Legal Request Center Created"

