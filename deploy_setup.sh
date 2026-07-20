#!/data/data/com.termux/files/usr/bin/bash

echo "Preparing Learn & Earn Hub for deployment..."


# Git ignore

cat > .gitignore <<'GIT'
node_modules/
.env
uploads/
*.log
GIT



# Production package check

node -e "
let p=require('./package.json');
p.scripts.start='node server.js';
require('fs').writeFileSync(
'package.json',
JSON.stringify(p,null,2)
)
"



# README

cat > README.md <<'MD'
# Learn & Earn Hub

Learn skills, advertise services, and connect with people.

## Features

- Urdu + English support
- User accounts
- Learning content
- Marketplace ads
- User profiles
- Reviews
- Supabase database

## Technology

- Node.js
- Express
- Supabase PostgreSQL

## Run locally

npm install

npm start

MD



# Environment example

cat > .env.example <<'ENV'
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_anon_key
PORT=3000
ENV



# Render configuration

cat > render.yaml <<'YAML'
services:

- type: web
  name: learn-earn-hub
  env: node
  buildCommand: npm install
  startCommand: npm start
  plan: free
YAML



# Git initialize

git init

git add .

git commit -m "Learn Earn Hub first release"


echo ""
echo "================================"
echo "Deployment preparation complete"
echo "================================"

echo ""
echo "Next:"
echo "1. Create GitHub repository"
echo "2. Run git remote add origin YOUR_URL"
echo "3. git push -u origin main"

