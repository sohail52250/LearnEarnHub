$files = Get-ChildItem public -Recurse -File -Include *.html

foreach($file in $files){

$content = Get-Content $file.FullName -Raw

if($content -match "googleLogin\(\)"){

    if($content -notmatch "/auth-system.js"){

        $inject = @'

<script src="/config.js"></script>
<script src="/auth-system.js"></script>

'@

        $content = $content -replace "</body>", "$inject</body>"

        Set-Content $file.FullName $content

        Write-Host "Fixed:" $file.FullName
    }
}

}

Write-Host "AUTH LOADER CHECK COMPLETE"
