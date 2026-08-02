#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Database Auto Setup ==="

DBLINE=$(grep "^DATABASE_URL=" .env)

if [ -z "$DBLINE" ]; then
echo "DATABASE_URL missing. Creating..."
echo "DATABASE_URL=postgresql://postgres:DBPASSWORD@db.srarnaqyoiqotdntzsyc.supabase.co:5432/postgres" >> .env
fi

DBURL=$(grep "^DATABASE_URL=" .env | cut -d '=' -f2-)

if echo "$DBURL" | grep -q "YOUR_DATABASE_PASSWORD\|DBPASSWORD"; then
    echo ""
    read -s -p "Enter Supabase Database Password: " PASSWORD
    echo ""

    sed -i "s/YOUR_DATABASE_PASSWORD/$PASSWORD/g; s/DBPASSWORD/$PASSWORD/g" .env

    echo "✅ Password updated"
fi

DBURL=$(grep "^DATABASE_URL=" .env | cut -d '=' -f2-)

echo "Testing PostgreSQL connection..."

psql "$DBURL" -c "SELECT current_database();" 

if [ $? -ne 0 ]; then
    echo "❌ Connection failed"
    exit 1
fi

echo "✅ Database connected"

echo "Creating learning tables..."

psql "$DBURL" -f database/learning-system.sql

if [ $? -eq 0 ]; then
    echo "✅ Learning system tables created"
else
    echo "❌ SQL failed"
fi
