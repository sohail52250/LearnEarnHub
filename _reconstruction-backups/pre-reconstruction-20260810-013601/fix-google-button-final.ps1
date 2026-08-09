Write-Host "=== Fix Google Login Button ===" -ForegroundColor Cyan

# Check config
if (!(Test-Path "public\config.js")) {
    Write-Host "Missing config.js" -ForegroundColor Red
    exit
}

# Create final google auth function
@'
async function googleLogin(){

    if(typeof supabase === "undefined"){
        alert("Supabase library missing");
        return;
    }

    const client = supabase.createClient(
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
        console.error(error);
        alert(error.message);
    }
}

window.googleLogin=googleLogin;
'@ | Out-File "public\google-login.js" -Encoding utf8


# Add loader after auth-system.js
Get-ChildItem public -Recurse -File -Include *.html | ForEach-Object {

    $file=$_.FullName
    $content=Get-Content $file -Raw

    if($content -match "googleLogin\(\)"){

        if($content -notmatch "google-login.js"){

            $content=$content -replace `
            "</body>",`
            '<script src="/google-login.js"></script>`r`n</body>'

            Set-Content $file $content -Encoding utf8

            Write-Host "Updated $file"
        }
    }
}


Write-Host "Deploying..."

vercel --prod

Write-Host "=== DONE ===" -ForegroundColor Green
