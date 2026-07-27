#!/data/data/com.termux/files/usr/bin/bash

echo "===== KYC / COMPLIANCE AUDIT ====="

echo
echo "HTML Forms:"
grep -R "<form" public --include="*.html" | wc -l

echo
echo "Verification Pages:"
find public -iname "*verification*" | sort

echo
echo "Government Pages:"
find public -iname "*government*" | sort

echo
echo "KYC Pages:"
find public -iname "*kyc*" | sort

echo
echo "Company Pages:"
find public -iname "*company*" | wc -l

echo
echo "Investor Pages:"
find public -iname "*investor*" | wc -l

echo
echo "Business Pages:"
find public -iname "*business*" | wc -l

echo
echo "SQL Files:"
find . -name "*.sql" | sort

echo
echo "Supabase References:"
grep -R "supabase" . \
 --exclude-dir=node_modules \
 --exclude-dir=.git | wc -l

echo
echo "Audit Complete"
