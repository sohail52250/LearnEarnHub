Write-Host "=== LearnEarnHub Vercel + Google OAuth Final Setup ===" -ForegroundColor Cyan

# Ask required values
$vercelUrl = Read-Host "Enter Vercel production URL (example: https://learn-earnhub.vercel.app)"
$supabaseUrl = Read-Host "Enter Supabase Project URL"
$googleClientId = Read-Host "Enter Google Client ID"

if ([string]::IsNullOrWhiteSpace($vercelUrl)) {
    Write-Host "Vercel URL missing" -ForegroundColor Red
    exit
}

if ([string]::IsNullOrWhiteSpace($supabaseUrl)) {
    Write-Host "Supabase URL missing" -ForegroundColor Red
    exit
}

# Normalize URLs
$vercelUrl = $vercelUrl.TrimEnd("/")
$supabaseUrl = $supabaseUrl.TrimEnd("/")

# Create OAuth config
$config = @"
window.GOOGLE_CLIENT_ID = "$googleClientId";
window.SUPABASE_URL = "$supabaseUrl";
"@

$config | Out-File "public\config.js" -Encoding utf8

Write-Host "Created public/config.js"

# Update Supabase callback documentation file
@"
LearnEarnHub OAuth Configuration

Site URL:
$vercelUrl

Supabase Callback:
$supabaseUrl/auth/v1/callback

Google Origin:
$vercelUrl
"@ | Out-File "google-oauth-config.txt" -Encoding utf8


# Protect secrets
if (!(Select-String -Path ".gitignore" -Pattern "google-oauth-config.txt" -Quiet)) {
    Add-Content .gitignore "google-oauth-config.txt"
}

Write-Host "Updated .gitignore"


# Search broken old OAuth snippets
Write-Host ""
Write-Host "Scanning old Google OAuth code..."

Get-ChildItem public -Recurse -File -Include *.html |
Select-String -Pattern "signIn\(\{ provider: 'google' \}|signInWithOAuth" |
ForEach-Object {
    Write-Host $_.Path
}


# Git status
Write-Host ""
Write-Host "Git status:"
git status


# Deploy
Write-Host ""
Write-Host "Deploying to Vercel production..." -ForegroundColor Yellow

vercel --prod


Write-Host ""
Write-Host "=== COMPLETE ===" -ForegroundColor Green

Write-Host ""
Write-Host "Configure these URLs:"
Write-Host ""
Write-Host "Supabase Site URL:"
Write-Host $vercelUrl
Write-Host ""
Write-Host "Supabase Redirect:"
Write-Host "$supabaseUrl/auth/v1/callback"
Write-Host ""
Write-Host "Google Authorized Origin:"
Write-Host $vercelUrl
