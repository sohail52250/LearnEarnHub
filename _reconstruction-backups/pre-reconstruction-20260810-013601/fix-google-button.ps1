Write-Host "=== Fixing Google Login Button ==="

# Check google-login.js
if (Test-Path "public/google-login.js") {
    Write-Host "google-login.js found"
} else {
    Write-Host "Creating google-login.js"

@"
async function googleLogin(){

    console.log("Google Login Started");

    if(typeof supabase === "undefined"){
        alert("Supabase library missing");
        return;
    }

    if(typeof window.supabaseClient === "undefined"){
        alert("Supabase client missing");
        return;
    }

    const {data,error}=await window.supabaseClient.auth.signInWithOAuth({
        provider:'google',
        options:{
            redirectTo:window.location.origin + '/login-v2.html'
        }
    });

    if(error){
        console.error(error);
        alert(error.message);
    }

}
"@ | Out-File public/google-login.js -Encoding utf8

}


# Repair login button
$files = Get-ChildItem public -Recurse -Filter *.html

foreach($file in $files){

$content = Get-Content $file.FullName -Raw

if($content -match "Sign in with Google"){

$content = $content -replace "Sign in with Google.*?</button>",
'<button type="button" onclick="googleLogin()">Sign in with Google</button>'

Set-Content $file.FullName $content -Encoding utf8

Write-Host "Fixed:" $file.FullName

}

}


# Git deploy
git add .
git commit -m "Fix Google OAuth button"
vercel --prod

Write-Host "=== DONE ==="
