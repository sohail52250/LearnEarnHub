#!/data/data/com.termux/files/usr/bin/bash

echo "=== Local Supabase URL ==="
grep SUPABASE_URL .env 2>/dev/null || echo "No local .env SUPABASE_URL found"

echo
echo "=== Vercel Environment Variables ==="
vercel env ls

echo
echo "=== Current API Table References ==="
grep -R 'from("developer_keys")' api/developer || true

echo
echo "=== Git Latest Commit ==="
git log -1 --oneline

echo
echo "Check complete."
