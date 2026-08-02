#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Admin Email Setup ==="

read -p "Enter admin email: " ADMIN_EMAIL


if [ -z "$ADMIN_EMAIL" ]; then

echo "❌ Email cannot be empty"

exit 1

fi


# Remove old ADMIN_EMAILS line
sed -i '/^ADMIN_EMAILS=/d' .env


# Add new admin email
echo "" >> .env
echo "# Admin emails separated by comma" >> .env
echo "ADMIN_EMAILS=$ADMIN_EMAIL" >> .env


echo ""
echo "✅ Admin email saved"

grep ADMIN_EMAILS .env


