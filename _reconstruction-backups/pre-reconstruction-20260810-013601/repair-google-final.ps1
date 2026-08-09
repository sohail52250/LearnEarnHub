Write-Host "=== LearnEarnHub Final Google OAuth Repair ===" -ForegroundColor Cyan

$public="public"

# Backup
$backup="backup-google-repair-$(Get-Date -Format yyyyMMdd-HHmmss)"
Copy-Item $public $backup -Recurse
Write-Host "Backup created: $backup"


# Fix broken Supabase CDN quotes
Get-ChildItem $public -Recurse -Filter *.html | ForEach-Object {

    $file=$_.FullName
    $content=Get-Content $file -Raw

    $content=$content -replace 'src=""https://cdn.jsdelivr.net/npm/@supabase/supabase-js/dist/supabase.min.js""',
    'src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"'


    # Remove old google oauth calls
    $content=$content -replace `
    "supabase\.auth\.signIn\(\{\s*provider:\s*['""]google['""]\s*\}\);",
    "googleLogin();"


    Set-Content $file $content
}


# Ensure auth pages load config + auth system
$pages=@(
"public\login-v2.html",
"public\signup-v2.html",
"public\forgot-password.html"
)

foreach($page in $pages){

if(Test-Path $page){

$content=Get-Content $page -Raw


if($content -notmatch "config.js"){

$content=$content -replace "</body>",
'
<script src="/config.js"></script>
<script src="/auth-system.js"></script>
</body>'

}


Set-Content $page $content

}

}


# Create Google login function if missing
$auth="public\auth-system.js"

if(Test-Path $auth){

$content=Get-Content $auth -Raw


if($content -notmatch "googleLogin"){

Add-Content $auth @'

async function googleLogin(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

await client.auth.signInWithOAuth({
provider:"google",
options:{
redirectTo:window.location.origin
}
});

}

window.googleLogin=googleLogin;

'@

}

}


Write-Host ""
Write-Host "DONE - Google OAuth cleanup completed" -ForegroundColor Green
Write-Host ""
Write-Host "Next:"
Write-Host "1. Supabase Dashboard -> Authentication -> Providers -> Google ON"
Write-Host "2. Add Client ID"
Write-Host "3. Add Client Secret"
Write-Host "4. Callback:"
Write-Host "https://srarnaqyoiqotdntzsyc.supabase.co/auth/v1/callback"
