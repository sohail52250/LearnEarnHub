#!/data/data/com.termux/files/usr/bin/bash

echo "===== FORMS ====="
grep -R "<form" public --include="*.html"

echo
echo "===== INPUT FIELDS ====="
grep -R "<input\|<select\|<textarea" public --include="*.html" > form-fields.txt
wc -l form-fields.txt

echo
echo "===== FILE UPLOADS ====="
grep -R 'type="file"' public --include="*.html"

echo
echo "===== FETCH CALLS ====="
grep -R "fetch(" public --include="*.js" > fetch-calls.txt
wc -l fetch-calls.txt

echo
echo "===== SUPABASE REFERENCES ====="
grep -R "supabase" . \
  --exclude-dir=node_modules \
  --exclude-dir=.git \
  > supabase-refs.txt

wc -l supabase-refs.txt

echo
echo "===== TABLE REFERENCES ====="
grep -RiE \
"from\\(|insert\\(|update\\(|delete\\(|\\.from\\('" \
public server.js routes 2>/dev/null > table-refs.txt

wc -l table-refs.txt

echo
echo "===== VERIFICATION PAGES ====="
find public -iname "*verification*" | sort

echo
echo "===== PAYMENT PAGES ====="
find public -iname "*payment*" | sort

echo
echo "===== BUSINESS PAGES ====="
find public -iname "*business*" | sort | wc -l

echo
echo "===== COMPANY PAGES ====="
find public -iname "*company*" | sort | wc -l

echo
echo "===== INVESTOR PAGES ====="
find public -iname "*investor*" | sort | wc -l

echo
echo "===== DEAL PAGES ====="
find public -iname "*deal*" | sort | wc -l

echo
echo "Audit completed."
