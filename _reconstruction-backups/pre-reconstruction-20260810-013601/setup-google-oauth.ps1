$ErrorActionPreference="Stop"

Write-Host "=== LearnEarnHub Google OAuth Setup ===" -ForegroundColor Cyan

$supabaseUrl = Read-Host "Supabase URL"
$supabaseKey = Read-Host "Supabase ANON KEY"

$googleClientId = Read-Host "Google Client ID"
$googleSecret = Read-Host "Google Client Secret"


# Update config.js

$config = @"
const SUPABASE_URL = "$supabaseUrl";
const SUPABASE_ANON_KEY = "$supabaseKey";

const GOOGLE_CLIENT_ID = "$googleClientId";
"@

$config | Out-File "public\config.js" -Encoding utf8


# Create oauth config notes

$oauth = @"
GOOGLE OAUTH CONFIG

Client ID:
$googleClientId

Client Secret:
$googleSecret

Supabase Callback URL:

$supabaseUrl/auth/v1/callback

JavaScript Origin:

$supabaseUrl
"@

$oauth | Out-File "google-oauth-config.txt" -Encoding utf8


# Verify auth-system.js

$auth="public\auth-system.js"

if(Test-Path $auth){

$content=Get-Content $auth -Raw


if($content -notmatch "googleLogin"){

Add-Content $auth @'

async function googleLogin(){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signInWithOAuth({

provider:"google",

options:{
redirectTo:
window.location.origin+"/dashboard-router.html"
}

});


if(error){

alert(error.message);

}

return data;

}


window.googleLogin=googleLogin;

'@

}

}


Write-Host ""
Write-Host "DONE" -ForegroundColor Green
Write-Host ""
Write-Host "Required Supabase callback:"
Write-Host "$supabaseUrl/auth/v1/callback"
