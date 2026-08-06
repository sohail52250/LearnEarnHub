$project = Get-Location

Write-Host "=== LearnEarnHub Supabase Google Auth Repair ===" -ForegroundColor Cyan

$SUPABASE_URL = Read-Host "Enter your Supabase Project URL (example: https://xxxxx.supabase.co)"

$SUPABASE_KEY = Read-Host "Enter your Supabase ANON public key"


$configPath = "public\config.js"


if (!(Test-Path $configPath)) {

@"
const SUPABASE_URL = "$SUPABASE_URL";
const SUPABASE_ANON_KEY = "$SUPABASE_KEY";
"@ | Out-File $configPath -Encoding utf8

Write-Host "Created config.js"

}
else {

Write-Host "Updating config.js"

@"
const SUPABASE_URL = "$SUPABASE_URL";
const SUPABASE_ANON_KEY = "$SUPABASE_KEY";
"@ | Out-File $configPath -Encoding utf8

}



$authPath="public\auth-system.js"


if(Test-Path $authPath){

$content = Get-Content $authPath -Raw


if($content -notmatch "googleLogin"){

Add-Content $authPath @"


async function googleLogin(){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signInWithOAuth({

provider:"google",

options:{
redirectTo:window.location.origin+"/dashboard-router.html"
}

});


if(error){

alert(error.message);

}

return data;

}


window.googleLogin=googleLogin;

"@

Write-Host "Added googleLogin()"

}

}



Write-Host ""
Write-Host "Replacing old Supabase Google OAuth snippets..." -ForegroundColor Yellow


Get-ChildItem public -Recurse -File -Include *.html | ForEach-Object {


$file=$_.FullName

$text=Get-Content $file -Raw


$text=$text -replace `
"supabase\.auth\.signIn\(\{\s*provider:\s*['""]google['""]\s*\}\);",
"googleLogin();"


$text=$text -replace `
"const supabase = supabase\.createClient\('seKey'\);",
""


Set-Content $file $text -Encoding utf8

}



Write-Host ""
Write-Host "Repair completed." -ForegroundColor Green

Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Enable Google Provider in Supabase Dashboard"
Write-Host "2. Add Google Client ID and Secret"
Write-Host "3. Add redirect URL:"
Write-Host "$SUPABASE_URL/auth/v1/callback"

