#!/data/data/com.termux/files/usr/bin/bash

mkdir -p public/forms

############################
# LEARNER KYC
############################
cat > public/learner-kyc.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Learner Verification</title>
</head>
<body>
<h1>Learner Verification</h1>

<form id="learnerKyc">

<h3>Public Profile</h3>
<input name="display_name" placeholder="Display Name"><br>
<textarea name="skills" placeholder="Skills"></textarea><br>
<textarea name="career_summary" placeholder="Career Summary"></textarea><br>

<h3>Private Information</h3>
<input name="legal_name" placeholder="Legal Name"><br>
<input name="email" type="email" placeholder="Email"><br>
<input name="phone" placeholder="Phone"><br>
<input name="dob" type="date"><br>
<input name="country" placeholder="Country"><br>

<label>ID Document</label><br>
<input type="file" name="id_document"><br>

<button type="submit">Submit</button>

</form>
</body>
</html>
HTML

############################
# BUSINESS REGISTRATION
############################
cat > public/business-registration-v2.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Business Registration</title>
</head>
<body>

<h1>Business Registration</h1>

<form>

<h3>Public Business Information</h3>

<input name="business_name" placeholder="Business Name"><br>
<input name="industry" placeholder="Industry"><br>
<textarea name="description"></textarea><br>

<h3>Private Information</h3>

<input name="owner_name" placeholder="Owner Name"><br>
<input name="registration_number" placeholder="Registration Number"><br>
<input name="address" placeholder="Address"><br>

<label>Business Registration Document</label><br>
<input type="file"><br>

<button type="submit">Register</button>

</form>

</body>
</html>
HTML

############################
# INVESTOR VERIFICATION
############################
cat > public/investor-verification.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Investor Verification</title>
</head>
<body>

<h1>Investor Verification</h1>

<form>

<input placeholder="Investor Name"><br>
<input placeholder="Country"><br>
<textarea placeholder="Investment Interests"></textarea><br>

<label>Identity Document</label><br>
<input type="file"><br>

<label>Proof of Funds</label><br>
<input type="file"><br>

<button>Submit</button>

</form>

</body>
</html>
HTML

############################
# COMPANY DUE DILIGENCE
############################
cat > public/company-due-diligence.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Due Diligence Vault</title>
</head>
<body>

<h1>Due Diligence Vault</h1>

<form>

<input placeholder="Company Name"><br>
<input placeholder="Company Registration Number"><br>

<label>Financial Statements</label><br>
<input type="file"><br>

<label>Ownership Documents</label><br>
<input type="file"><br>

<label>Legal Documents</label><br>
<input type="file"><br>

<button>Upload</button>

</form>

</body>
</html>
HTML

############################
# GOVERNMENT REQUEST PORTAL
############################
cat > public/government-request-portal.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Government Request Portal</title>
</head>
<body>

<h1>Government Request Portal</h1>

<form>

<input placeholder="Department Name"><br>
<input placeholder="Officer Name"><br>
<input placeholder="Official Email"><br>
<input placeholder="Case Number"><br>
<input placeholder="Court Order Reference"><br>

<textarea placeholder="Requested Information"></textarea><br>

<label>Upload Court Order</label><br>
<input type="file"><br>

<button>Submit Request</button>

</form>

</body>
</html>
HTML

echo "Created:"
echo "public/learner-kyc.html"
echo "public/business-registration-v2.html"
echo "public/investor-verification.html"
echo "public/company-due-diligence.html"
echo "public/government-request-portal.html"

