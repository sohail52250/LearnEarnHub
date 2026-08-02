#!/data/data/com.termux/files/usr/bin/bash

echo "=== Running LearnEarnHub Learning SQL ==="

if ! grep -q "DATABASE_URL=" .env; then
echo "❌ DATABASE_URL missing in .env"
echo ""
echo "Add this line:"
echo "DATABASE_URL=postgresql://postgres:PASSWORD@db.srarnaqyoiqotdntzsyc.supabase.co:5432/postgres"
exit 1
fi

source .env

psql "$DATABASE_URL" -f database/learning-system.sql

if [ $? -eq 0 ]; then
echo "✅ Learning system tables created"
else
echo "❌ SQL execution failed"
fi

