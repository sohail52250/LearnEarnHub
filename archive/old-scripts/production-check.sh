#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Production Check ==="

echo ""
echo "=== Required Pages ==="

for page in \
index.html \
business-register.html \
business-marketplace.html \
business-dashboard.html \
login.html \
register.html \
admin-business-verification.html
do

if [ -f "public/$page" ]; then
echo "✅ $page exists"
else
echo "❌ Missing $page"
fi

done


echo ""
echo "=== Business Links Check ==="

grep -Rni "business-register.html" public/global-header.html
grep -Rni "business-marketplace.html" public/global-header.html


echo ""
echo "=== Supabase References ==="

grep -Rni "supabase-config.js" public/business*.html


echo ""
echo "=== RLS Related Tables ==="

echo "Check Supabase dashboard manually:"
echo "- business_profiles"
echo "- business_opportunities"
echo "- partnership_requests"


echo ""
echo "=== Git Status ==="

git status


echo ""
echo "=== Check Complete ==="

