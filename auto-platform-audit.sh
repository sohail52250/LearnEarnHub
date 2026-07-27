#!/data/data/com.termux/files/usr/bin/bash

echo "================================="
echo " LEARNEARNHUB PLATFORM AUDIT"
echo "================================="

mkdir -p reports

echo "[1] Extracting Supabase tables..."

grep -R '\.from("' public api \
  --include="*.js" \
  --include="*.html" 2>/dev/null \
| sed -n 's/.*\.from("\([^"]*\)".*/\1/p' \
| sort -u > reports/tables.txt

echo
echo "Tables Found:"
cat reports/tables.txt

echo
echo "[2] Counting tables..."
wc -l reports/tables.txt

echo
echo "[3] Generating SQL skeleton..."

cat > reports/generated_schema.sql <<'SQL'
-- Auto Generated Schema Skeleton
SQL

while read table
do
cat >> reports/generated_schema.sql <<SQL

CREATE TABLE IF NOT EXISTS $table (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT NOW()
);

SQL
done < reports/tables.txt

echo
echo "[4] Building readiness report..."

cat > reports/platform-readiness.txt <<REPORT
LearnEarnHub Readiness Report

Tables Found:
$(wc -l < reports/tables.txt)

Core Learning:
$(grep -E "courses|lesson_progress|quiz_results|certificates" reports/tables.txt | wc -l)

Marketplace:
$(grep -E "jobs|applications|opportunities" reports/tables.txt | wc -l)

Business:
$(grep -E "business_" reports/tables.txt | wc -l)

Referral:
$(grep -E "referral" reports/tables.txt | wc -l)

Instructor:
$(grep -E "instructor" reports/tables.txt | wc -l)

Admin:
$(grep -E "admin" reports/tables.txt | wc -l)
REPORT

echo
echo "[5] Searching compliance modules..."

grep -Ri \
"kyc\|verification\|audit\|government\|compliance\|investor\|holding-company" \
public api > reports/compliance-scan.txt

echo
echo "[6] Finding missing compliance tables..."

cat > reports/recommended-tables.txt <<LIST
learner_kyc
business_verification
investor_verification
company_due_diligence
government_requests
audit_logs
entity_verification
payment_transactions
compliance_cases
LIST

echo
echo "================================="
echo " AUDIT COMPLETE"
echo "================================="
echo

echo "Generated:"
echo "reports/tables.txt"
echo "reports/generated_schema.sql"
echo "reports/platform-readiness.txt"
echo "reports/compliance-scan.txt"
echo "reports/recommended-tables.txt"
