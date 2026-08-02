#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Audit ====="

echo ""
echo "--- Server Syntax ---"
node -c server.js

echo ""
echo "--- APIs ---"
find api -type f 2>/dev/null | sort

echo ""
echo "--- Services ---"
find services -type f 2>/dev/null | sort

echo ""
echo "--- Public Pages ---"
find public -type f | sort

echo ""
echo "--- Setup Scripts ---"
find . -name "*.sh" | sort

echo ""
echo "--- Environment ---"
grep -E "SUPABASE|ADMIN|VERCEL" .env 2>/dev/null | sed 's/=.*$/=***HIDDEN***/'

echo ""
echo "===== Audit Complete ====="
