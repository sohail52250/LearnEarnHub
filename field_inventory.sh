#!/data/data/com.termux/files/usr/bin/bash

echo "===== INPUT INVENTORY ====="

grep -Rin \
'<input\|<select\|<textarea' \
public \
--include="*.html" \
> all-inputs.txt

echo "Total Inputs:"
wc -l all-inputs.txt

echo
echo "===== INPUT NAMES ====="

grep -Rho \
'name="[^"]*"' \
public \
--include="*.html" \
| sort | uniq -c | sort -nr \
> unique-inputs.txt

head -100 unique-inputs.txt

echo
echo "===== FORMS ====="

grep -Rin "<form" public --include="*.html" \
> forms.txt

cat forms.txt

echo
echo "===== FETCH CALLS ====="

grep -Rin "fetch(" public --include="*.js" \
> fetch-map.txt

wc -l fetch-map.txt

echo
echo "===== FILE UPLOADS ====="

grep -Rin 'type="file"' public --include="*.html" \
> uploads.txt

cat uploads.txt

echo
echo "===== VERIFICATION FIELDS ====="

grep -RiE \
'cnic|passport|verification|document|license|tax|company|investor' \
public \
--include="*.html" \
> verification-fields.txt

wc -l verification-fields.txt

echo
echo "Audit files generated:"
ls -1 \
all-inputs.txt \
unique-inputs.txt \
forms.txt \
fetch-map.txt \
uploads.txt \
verification-fields.txt

