#!/data/data/com.termux/files/usr/bin/bash

echo "Paste Supabase service_role key:"
read -r KEY

sed -i '/SUPABASE_SERVICE_KEY=/d' .env

echo "SUPABASE_SERVICE_KEY=$KEY" >> .env

echo "Service key saved."

node -e '
require("dotenv").config();
console.log(
process.env.SUPABASE_SERVICE_KEY ? 
"Service key loaded ✅" :
"Service key missing ❌"
)
'
