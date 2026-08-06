#!/data/data/com.termux/files/usr/bin/bash

echo "=== BUSINESS ECOSYSTEM AUDIT ==="
echo

echo "=== Business Pages ==="
ls public/business*.html 2>/dev/null | sort

echo
echo "=== Business JS Files ==="
ls public/business*.js 2>/dev/null | sort

echo
echo "=== Applications References ==="
grep -Rni "job_applications\|applications" public/business* 2>/dev/null | head -50

echo
echo "=== Profile References ==="
grep -Rni "business_profiles" public/business* 2>/dev/null | head -50

echo
echo "=== Opportunities References ==="
grep -Rni "business_opportunities\|job_opportunities" public/business* 2>/dev/null | head -50

echo
echo "=== Verification References ==="
grep -Rni "verified" public/business* public/admin* 2>/dev/null | head -50

echo
echo "=== AUDIT COMPLETE ==="
