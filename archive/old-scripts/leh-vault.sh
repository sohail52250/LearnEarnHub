#!/data/data/com.termux/files/usr/bin/bash

VAULT="$HOME/.leh_vault"

mkdir -p "$HOME"

if [ ! -f "$VAULT" ]; then
touch "$VAULT"
chmod 600 "$VAULT"
fi

get_secret() {
KEY="$1"

VALUE=$(grep "^${KEY}=" "$VAULT" 2>/dev/null | cut -d= -f2-)

if [ -z "$VALUE" ]; then
echo
read -p "Enter $KEY: " VALUE
echo "${KEY}=${VALUE}" >> "$VAULT"
fi

echo "$VALUE"
}

case "$1" in

github)
get_secret GITHUB_TOKEN
;;

vercel)
get_secret VERCEL_TOKEN
;;

supabase-url)
get_secret SUPABASE_URL
;;

supabase-key)
get_secret SUPABASE_SERVICE_KEY
;;

email)
get_secret EMAIL
;;

all)
echo "EMAIL=$(get_secret EMAIL)"
echo "GITHUB_TOKEN=$(get_secret GITHUB_TOKEN)"
echo "VERCEL_TOKEN=$(get_secret VERCEL_TOKEN)"
echo "SUPABASE_URL=$(get_secret SUPABASE_URL)"
echo "SUPABASE_SERVICE_KEY=$(get_secret SUPABASE_SERVICE_KEY)"
;;

*)
echo "Usage:"
echo "./leh-vault.sh github"
echo "./leh-vault.sh vercel"
echo "./leh-vault.sh supabase-url"
echo "./leh-vault.sh supabase-key"
echo "./leh-vault.sh email"
echo "./leh-vault.sh all"
;;
esac
