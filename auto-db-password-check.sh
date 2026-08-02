#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub DATABASE URL CHECK ==="

if ! grep -q "DATABASE_URL=" .env; then
echo "❌ DATABASE_URL missing"
exit 1
fi

DB=$(grep DATABASE_URL .env)

if echo "$DB" | grep -q "YOUR_DATABASE_PASSWORD"; then
echo "❌ Database password not added yet"
echo ""
echo "Supabase requires the DB password."
echo "Open:"
echo "Supabase Dashboard → Settings → Database → Database Password"
echo ""
echo "After copying password run:"
echo "./auto-db-password-check.sh"
exit 1
fi

echo "✅ Database URL ready"

psql "$DB" -c "SELECT version();" 2>/dev/null

if [ $? -eq 0 ]; then
echo "✅ PostgreSQL connection working"
echo ""
echo "Creating learning tables..."
psql "$DB" -f database/learning-system.sql
echo "✅ Learning system installed"
else
echo "❌ PostgreSQL connection failed"
fi

