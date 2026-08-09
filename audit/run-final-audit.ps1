$ErrorActionPreference = "Stop"

$Project = "F:\Projects\lehup\LearnEarnHub"

if (-not (Test-Path -LiteralPath $Project)) {
    throw "LearnEarnHub project not found: $Project"
}

Set-Location -LiteralPath $Project

$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$AuditDir = Join-Path $Project "audit"
$BackupRoot = Join-Path $Project "_final-audit-backups"
$BackupDir = Join-Path $BackupRoot $Stamp
$ReportFile = Join-Path $AuditDir "final-application-audit-$Stamp.txt"
$JsonFile = Join-Path $AuditDir "final-application-audit-$Stamp.json"
$ServerOut = Join-Path $AuditDir "server-smoke-$Stamp.out.log"
$ServerErr = Join-Path $AuditDir "server-smoke-$Stamp.err.log"

New-Item -ItemType Directory -Force -Path $AuditDir | Out-Null
New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null

$failures = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$checks = [ordered]@{}

function Pass($Message) {
    Write-Host "PASS  $Message" -ForegroundColor Green
}

function Warn($Message) {
    Write-Host "WARN  $Message" -ForegroundColor Yellow
    $warnings.Add($Message)
}

function Fail($Message) {
    Write-Host "FAIL  $Message" -ForegroundColor Red
    $failures.Add($Message)
}

function Resolve-LocalTarget {
    param(
        [string]$Reference,
        [string]$SourceDirectory
    )

    if ([string]::IsNullOrWhiteSpace($Reference)) {
        return $null
    }

    $clean = $Reference.Split("?")[0].Split("#")[0]

    if ([string]::IsNullOrWhiteSpace($clean)) {
        return $null
    }

    if ($clean -match '^(https?:|mailto:|tel:|javascript:|data:|blob:|#)') {
        return $null
    }

    if ($clean.StartsWith("/")) {
        $relative = $clean.TrimStart("/").Replace("/", "\")
        return (Join-Path $Project "public\$relative")
    }

    return (Join-Path $SourceDirectory ($clean.Replace("/", "\")))
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " LEARNEARNHUB  FINAL APPLICATION-LEVEL AUDIT" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project : $Project"
Write-Host "Time    : $(Get-Date)"
Write-Host ""

# ------------------------------------------------------------
# 1. GIT BASELINE
# ------------------------------------------------------------

Write-Host "[1/16] Git baseline..." -ForegroundColor Yellow

$branch = (git branch --show-current 2>$null).Trim()
$commit = (git log -1 --format="%H" 2>$null).Trim()
$gitStatus = @(git status --short 2>$null)

$checks.branch = $branch
$checks.commit = $commit
$checks.git_changes = $gitStatus.Count

Write-Host "Branch : $branch"
Write-Host "Commit : $commit"

if ($gitStatus.Count -gt 0) {
    Warn "Working tree contains $($gitStatus.Count) changed/untracked item(s)."
} else {
    Pass "Git working tree is clean."
}

# ------------------------------------------------------------
# 2. SAFETY BACKUP
# ------------------------------------------------------------

Write-Host ""
Write-Host "[2/16] Creating safety backup..." -ForegroundColor Yellow

$backupItems = @(
    "server.js",
    "app.js",
    "package.json",
    "package-lock.json",
    "routes",
    "services",
    "public"
)

foreach ($item in $backupItems) {
    if (Test-Path -LiteralPath $item) {
        $destination = Join-Path $BackupDir $item
        $parent = Split-Path -Parent $destination

        if ($parent) {
            New-Item -ItemType Directory -Force -Path $parent | Out-Null
        }

        if ((Get-Item -LiteralPath $item).PSIsContainer) {
            Copy-Item -LiteralPath $item -Destination $destination -Recurse -Force
        } else {
            Copy-Item -LiteralPath $item -Destination $destination -Force
        }
    }
}

$checks.backup = $BackupDir
Pass "Safety backup created: $BackupDir"

# ------------------------------------------------------------
# 3. REQUIRED STRUCTURE
# ------------------------------------------------------------

Write-Host ""
Write-Host "[3/16] Required project structure..." -ForegroundColor Yellow

$required = @(
    "server.js",
    "app.js",
    "package.json",
    "public",
    "routes",
    "services"
)

foreach ($item in $required) {
    if (Test-Path -LiteralPath $item) {
        Pass $item
    } else {
        Fail "Required project item missing: $item"
    }
}

# ------------------------------------------------------------
# 4. PACKAGE VALIDATION
# ------------------------------------------------------------

Write-Host ""
Write-Host "[4/16] Package validation..." -ForegroundColor Yellow

try {
    $nodeVersion = (node --version).Trim()
    $npmVersion = (npm --version).Trim()

    Write-Host "Node : $nodeVersion"
    Write-Host "npm  : $npmVersion"

    npm install --package-lock-only --ignore-scripts --no-audit

    if ($LASTEXITCODE -ne 0) {
        throw "npm package-lock validation failed."
    }

    $package = Get-Content -LiteralPath "package.json" -Raw | ConvertFrom-Json

    $checks.node = $nodeVersion
    $checks.npm = $npmVersion
    $checks.package_main = $package.main
    $checks.package_start = $package.scripts.start

    Pass "package.json parsed successfully."

    if ($package.main -ne "server.js") {
        Fail "package.json main is '$($package.main)' instead of server.js."
    }

    if ($package.scripts.start -ne "node server.js") {
        Fail "package.json start script is '$($package.scripts.start)' instead of node server.js."
    }

    if ($package.main -eq "server.js" -and $package.scripts.start -eq "node server.js") {
        Pass "Production entrypoint is server.js."
    }
}
catch {
    Fail "Package validation failed: $($_.Exception.Message)"
}

# ------------------------------------------------------------
# 5. SERVER / APP SYNTAX
# ------------------------------------------------------------

Write-Host ""
Write-Host "[5/16] Core server syntax..." -ForegroundColor Yellow

$coreJs = @(
    "server.js",
    "app.js"
)

foreach ($file in $coreJs) {
    if (-not (Test-Path -LiteralPath $file)) {
        continue
    }

    node --check $file 2>$null

    if ($LASTEXITCODE -ne 0) {
        Fail "JavaScript syntax error: $file"
    } else {
        Pass "JavaScript syntax: $file"
    }
}

# ------------------------------------------------------------
# 6. ACTIVE JAVASCRIPT SYNTAX
# ------------------------------------------------------------

Write-Host ""
Write-Host "[6/16] Active JavaScript syntax audit..." -ForegroundColor Yellow

$jsFiles = @(
    Get-ChildItem -LiteralPath $Project -Recurse -Filter "*.js" -File -ErrorAction SilentlyContinue |
    Where-Object {
        $_.FullName -notmatch "\\node_modules\\" -and
        $_.FullName -notmatch "\\_backup\\" -and
        $_.FullName -notmatch "\\backup-" -and
        $_.FullName -notmatch "\\cleanup-quarantine\\" -and
        $_.FullName -notmatch "\\_final-audit-backups\\" -and
        $_.FullName -notmatch "\\audit\\"
    }
)

$syntaxFailures = @()

foreach ($file in $jsFiles) {
    node --check $file.FullName 2>$null

    if ($LASTEXITCODE -ne 0) {
        $syntaxFailures += $file.FullName
    }
}

$checks.javascript_files = $jsFiles.Count
$checks.javascript_syntax_failures = $syntaxFailures.Count

if ($syntaxFailures.Count -eq 0) {
    Pass "$($jsFiles.Count) active JavaScript files passed syntax validation."
} else {
    foreach ($file in $syntaxFailures) {
        Fail "JavaScript syntax error: $file"
    }
}

# ------------------------------------------------------------
# 7. HTML INVENTORY
# ------------------------------------------------------------

Write-Host ""
Write-Host "[7/16] Active HTML inventory..." -ForegroundColor Yellow

$htmlFiles = @(
    Get-ChildItem -LiteralPath (Join-Path $Project "public") -Recurse -Filter "*.html" -File -ErrorAction SilentlyContinue |
    Where-Object {
        $_.FullName -notmatch "\\_backup\\" -and
        $_.FullName -notmatch "\\backup-" -and
        $_.FullName -notmatch "\\cleanup-quarantine\\" -and
        $_.FullName -notmatch "\\_final-audit-backups\\"
    }
)

$checks.html_files = $htmlFiles.Count

Write-Host "HTML files: $($htmlFiles.Count)"

if ($htmlFiles.Count -eq 0) {
    Fail "No active HTML files found in public."
} else {
    Pass "Active HTML inventory detected."
}

# ------------------------------------------------------------
# 8. FRONTEND REFERENCES
# ------------------------------------------------------------

Write-Host ""
Write-Host "[8/16] Frontend CSS / JS reference audit..." -ForegroundColor Yellow

$cssRefs = [System.Collections.Generic.HashSet[string]]::new(
    [System.StringComparer]::OrdinalIgnoreCase
)

$jsRefs = [System.Collections.Generic.HashSet[string]]::new(
    [System.StringComparer]::OrdinalIgnoreCase
)

foreach ($file in $htmlFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw

    $cssMatches = [regex]::Matches(
        $content,
        '(?i)<link[^>]+href=["'']([^"'']+\.css[^"'']*)["'']'
    )

    foreach ($m in $cssMatches) {
        [void]$cssRefs.Add($m.Groups[1].Value)
    }

    $jsMatches = [regex]::Matches(
        $content,
        '(?i)<script[^>]+src=["'']([^"'']+\.js[^"'']*)["'']'
    )

    foreach ($m in $jsMatches) {
        [void]$jsRefs.Add($m.Groups[1].Value)
    }
}

$cssRefsArray = @($cssRefs | Sort-Object)
$jsRefsArray = @($jsRefs | Sort-Object)

$checks.css_references = $cssRefsArray.Count
$checks.js_references = $jsRefsArray.Count

Write-Host "CSS references: $($cssRefsArray.Count)"
Write-Host "JS references : $($jsRefsArray.Count)"

# ------------------------------------------------------------
# 9. FRONTEND ASSET VALIDATION
# ------------------------------------------------------------

Write-Host ""
Write-Host "[9/16] Frontend asset existence..." -ForegroundColor Yellow

$assetFailures = @()

foreach ($ref in ($cssRefsArray + $jsRefsArray)) {
    if ($ref -match '^https?://') {
        continue
    }

    $candidate = Resolve-LocalTarget -Reference $ref -SourceDirectory $Project

    if ($null -ne $candidate -and -not (Test-Path -LiteralPath $candidate)) {
        $assetFailures += $ref
        Fail "Missing frontend asset: $ref"
    }
}

$checks.missing_assets = $assetFailures.Count

if ($assetFailures.Count -eq 0) {
    Pass "All referenced local CSS/JS assets exist."
}

# ------------------------------------------------------------
# 10. DUPLICATE CSS REFERENCES
# ------------------------------------------------------------

Write-Host ""
Write-Host "[10/16] Duplicate CSS reference audit..." -ForegroundColor Yellow

$duplicateCss = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw

    $refs = @(
        [regex]::Matches(
            $content,
            '(?i)<link[^>]+href=["'']([^"'']+\.css[^"'']*)["'']'
        ) |
        ForEach-Object {
            $_.Groups[1].Value.Split("?")[0]
        }
    )

    $groups = @(
        $refs |
        Group-Object |
        Where-Object { $_.Count -gt 1 }
    )

    foreach ($group in $groups) {
        $duplicateCss += "$($file.FullName) => $($group.Name) x $($group.Count)"
    }
}

$checks.duplicate_css = $duplicateCss.Count

if ($duplicateCss.Count -eq 0) {
    Pass "No duplicate CSS references detected."
} else {
    foreach ($item in $duplicateCss) {
        Warn "Duplicate CSS reference: $item"
    }
}

# ------------------------------------------------------------
# 11. INTERNAL HTML LINKS
# ------------------------------------------------------------

Write-Host ""
Write-Host "[11/16] Internal HTML link audit..." -ForegroundColor Yellow

$linkFailures = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw

    $links = [regex]::Matches(
        $content,
        '(?i)(?:href|action)=["'']([^"'']+)["'']'
    ) |
    ForEach-Object {
        $_.Groups[1].Value
    }

    foreach ($link in $links) {
        if ([string]::IsNullOrWhiteSpace($link)) {
            continue
        }

        if ($link -match '^(https?:|mailto:|tel:|javascript:|data:|blob:|#)') {
            continue
        }

        $target = $link.Split("?")[0].Split("#")[0]

        if ([string]::IsNullOrWhiteSpace($target)) {
            continue
        }

        if ($target -notmatch '\.(html|htm)$') {
            continue
        }

        $candidate = Resolve-LocalTarget `
            -Reference $target `
            -SourceDirectory $file.DirectoryName

        if ($null -eq $candidate -or -not (Test-Path -LiteralPath $candidate)) {
            $linkFailures += "$($file.FullName) -> $link"
        }
    }
}

$checks.broken_html_links = $linkFailures.Count

if ($linkFailures.Count -eq 0) {
    Pass "No broken internal HTML targets detected."
} else {
    foreach ($item in $linkFailures) {
        Fail "Broken internal HTML link: $item"
    }
}

# ------------------------------------------------------------
# 12. EXPRESS ROUTE INVENTORY
# ------------------------------------------------------------

Write-Host ""
Write-Host "[12/16] Express route inventory..." -ForegroundColor Yellow

$routeFiles = @(
    Get-ChildItem -LiteralPath (Join-Path $Project "routes") -Filter "*.js" -File -ErrorAction SilentlyContinue
)

$routeInventory = @()

foreach ($file in $routeFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw

    $matches = [regex]::Matches(
        $content,
        '(?i)\.(get|post|put|patch|delete|use)\s*\(\s*["'']([^"'']+)'
    )

    foreach ($m in $matches) {
        $routeInventory += [pscustomobject]@{
            File = $file.Name
            Method = $m.Groups[1].Value.ToUpper()
            Path = $m.Groups[2].Value
        }
    }
}

$checks.route_files = $routeFiles.Count
$checks.routes_detected = $routeInventory.Count

Write-Host "Route files : $($routeFiles.Count)"
Write-Host "Routes found: $($routeInventory.Count)"

if ($routeFiles.Count -eq 0) {
    Fail "No route files found."
}

if ($routeInventory.Count -eq 0) {
    Warn "No Express routes detected by static scan."
} else {
    Pass "Express route inventory detected."
}

# ------------------------------------------------------------
# 13. SELECT FREE LOCAL PORT
# ------------------------------------------------------------

Write-Host ""
Write-Host "[13/16] Selecting free local test port..." -ForegroundColor Yellow

$listener = [System.Net.Sockets.TcpListener]::new(
    [System.Net.IPAddress]::Loopback,
    0
)

$listener.Start()
$testPort = ([System.Net.IPEndPoint]$listener.LocalEndpoint).Port
$listener.Stop()

$checks.test_port = $testPort

Write-Host "Selected port: $testPort"
Pass "Free local test port selected."

# ------------------------------------------------------------
# 14. SERVER STARTUP + HTTP SMOKE TEST
# ------------------------------------------------------------

Write-Host ""
Write-Host "[14/16] Server startup and HTTP smoke test..." -ForegroundColor Yellow

$serverProcess = $null
$serverStarted = $false
$httpPassed = $false
$healthPassed = $false

try {
    $serverProcess = Start-Process `
        -FilePath "node" `
        -ArgumentList @("server.js") `
        -WorkingDirectory $Project `
        -RedirectStandardOutput $ServerOut `
        -RedirectStandardError $ServerErr `
        -PassThru `
        -WindowStyle Hidden

    $env:PORT = "$testPort"

    $deadline = (Get-Date).AddSeconds(15)

    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Milliseconds 500

        if ($serverProcess.HasExited) {
            break
        }

        try {
            $response = Invoke-WebRequest `
                -Uri "http://127.0.0.1:$testPort/" `
                -UseBasicParsing `
                -TimeoutSec 2 `
                -ErrorAction Stop

            if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 500) {
                $serverStarted = $true
                $httpPassed = $true
                break
            }
        }
        catch {
            continue
        }
    }

    if ($serverProcess.HasExited) {
        $stderr = ""

        if (Test-Path -LiteralPath $ServerErr) {
            $stderr = Get-Content -LiteralPath $ServerErr -Raw
        }

        Fail "server.js exited during startup. See $ServerErr"

        if (-not [string]::IsNullOrWhiteSpace($stderr)) {
            $shortError = $stderr.Trim()
            if ($shortError.Length -gt 2000) {
                $shortError = $shortError.Substring(0, 2000)
            }

            Fail "Server startup error: $shortError"
        }
    }
    elseif ($serverStarted) {
        Pass "server.js started successfully."
        Pass "HTTP root endpoint responded on port $testPort."
    }
    else {
        Fail "server.js did not produce an HTTP response within 15 seconds."
    }

    # Try common health/status endpoints only if root worked.
    if ($httpPassed) {
        $healthPaths = @(
            "/api/status",
            "/api/health",
            "/health"
        )

        foreach ($path in $healthPaths) {
            try {
                $healthResponse = Invoke-WebRequest `
                    -Uri "http://127.0.0.1:$testPort$path" `
                    -UseBasicParsing `
                    -TimeoutSec 3 `
                    -ErrorAction Stop

                if ($healthResponse.StatusCode -ge 200 -and $healthResponse.StatusCode -lt 400) {
                    $healthPassed = $true
                    Pass "Health/status endpoint responded: $path ($($healthResponse.StatusCode))."
                    break
                }
            }
            catch {
                continue
            }
        }

        if (-not $healthPassed) {
            Warn "No standard health endpoint returned a successful response. Root HTTP response is still valid."
        }
    }
}
catch {
    Fail "Server smoke test failed: $($_.Exception.Message)"
}
finally {
    if ($null -ne $serverProcess) {
        try {
            if (-not $serverProcess.HasExited) {
                Stop-Process -Id $serverProcess.Id -Force
                Start-Sleep -Milliseconds 500
            }
        }
        catch {}
    }
}

$checks.server_started = $serverStarted
$checks.http_root = $httpPassed
$checks.health_endpoint = $healthPassed

# ------------------------------------------------------------
# 15. SERVER LOG / SUSPICIOUS ARTIFACT REVIEW
# ------------------------------------------------------------

Write-Host ""
Write-Host "[15/16] Runtime and repository artifact review..." -ForegroundColor Yellow

if (Test-Path -LiteralPath $ServerErr) {
    $errContent = Get-Content -LiteralPath $ServerErr -Raw

    if (-not [string]::IsNullOrWhiteSpace($errContent)) {
        Warn "Server produced stderr during smoke test. Review $ServerErr"
    } else {
        Pass "Server stderr log is clean."
    }
}

$suspiciousFiles = @(
    "erver.js",
    "audit-learning-flow.js"
)

foreach ($item in $suspiciousFiles) {
    if (Test-Path -LiteralPath $item) {
        Warn "Suspicious artifact exists: $item"
    }
}

$backupDirectories = @(
    Get-ChildItem -LiteralPath $Project -Directory -ErrorAction SilentlyContinue |
    Where-Object {
        $_.Name -match '^_backup$' -or
        $_.Name -match '^backup-' -or
        $_.Name -match '^_final-audit-backups$' -or
        $_.Name -match '^cleanup-quarantine$'
    }
)

$checks.backup_directories = $backupDirectories.Count

if ($backupDirectories.Count -gt 0) {
    Write-Host "Protected backup/quarantine directories present: $($backupDirectories.Count)"
}

Pass "Runtime/repository artifact review completed."

# ------------------------------------------------------------
# 16. FINAL DECISION + REPORTS
# ------------------------------------------------------------

Write-Host ""
Write-Host "[16/16] Final production-readiness decision..." -ForegroundColor Yellow

$checks.failures = $failures.Count
$checks.warnings = $warnings.Count

$ready = ($failures.Count -eq 0)

if ($ready) {
    $decision = "BASELINE PASS  no blocking application-level audit failures detected."
} else {
    $decision = "NOT READY  blocking application-level failures remain. DO NOT DEPLOY."
}

$result = [ordered]@{
    timestamp = (Get-Date).ToString("s")
    project = $Project
    branch = $branch
    commit = $commit
    backup = $BackupDir
    decision = $decision
    ready_for_deployment = $ready
    checks = $checks
    failures = @($failures)
    warnings = @($warnings)
    reports = [ordered]@{
        text = $ReportFile
        json = $JsonFile
        server_stdout = $ServerOut
        server_stderr = $ServerErr
    }
}

$reportLines = @()

$reportLines += "LEARNEARNHUB  FINAL APPLICATION-LEVEL AUDIT"
$reportLines += "============================================================"
$reportLines += "Timestamp : $($result.timestamp)"
$reportLines += "Project   : $Project"
$reportLines += "Branch    : $branch"
$reportLines += "Commit    : $commit"
$reportLines += "Backup    : $BackupDir"
$reportLines += ""

$reportLines += "INVENTORY"
$reportLines += "HTML files       : $($htmlFiles.Count)"
$reportLines += "CSS references   : $($cssRefsArray.Count)"
$reportLines += "JS references    : $($jsRefsArray.Count)"
$reportLines += "JS files         : $($jsFiles.Count)"
$reportLines += "Route files      : $($routeFiles.Count)"
$reportLines += "Routes detected  : $($routeInventory.Count)"
$reportLines += ""

$reportLines += "VALIDATION"
$reportLines += "Syntax failures  : $($syntaxFailures.Count)"
$reportLines += "Missing assets   : $($assetFailures.Count)"
$reportLines += "Broken HTML      : $($linkFailures.Count)"
$reportLines += "Duplicate CSS    : $($duplicateCss.Count)"
$reportLines += "Test port        : $testPort"
$reportLines += "Server started   : $serverStarted"
$reportLines += "HTTP root        : $httpPassed"
$reportLines += "Health endpoint  : $healthPassed"
$reportLines += ""

$reportLines += "FAILURES"

if ($failures.Count -eq 0) {
    $reportLines += "None"
} else {
    foreach ($failure in $failures) {
        $reportLines += "- $failure"
    }
}

$reportLines += ""
$reportLines += "WARNINGS"

if ($warnings.Count -eq 0) {
    $reportLines += "None"
} else {
    foreach ($warning in $warnings) {
        $reportLines += "- $warning"
    }
}

$reportLines += ""
$reportLines += "DECISION"
$reportLines += $decision
$reportLines += ""
$reportLines += "SAFETY"
$reportLines += "This audit NEVER deploys to Vercel or production."
$reportLines += "Deployment must be a separate deliberate operation after reviewing this report."

Set-Content `
    -LiteralPath $ReportFile `
    -Value ($reportLines -join "`r`n") `
    -Encoding UTF8

$result | ConvertTo-Json -Depth 12 |
    Set-Content -LiteralPath $JsonFile -Encoding UTF8

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan

if ($ready) {
    Write-Host " FINAL RESULT: BASELINE PASS" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "No deployment was performed." -ForegroundColor Green
    Write-Host "The project passed the blocking application-level audit." -ForegroundColor Green
} else {
    Write-Host " FINAL RESULT: NOT READY  DO NOT DEPLOY" -ForegroundColor Red
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Blocking failures:" -ForegroundColor Red

    foreach ($failure in $failures) {
        Write-Host " - $failure" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Text report : $ReportFile"
Write-Host "JSON report : $JsonFile"
Write-Host "Backup      : $BackupDir"
Write-Host "Server log  : $ServerOut"
Write-Host "Server err  : $ServerErr"
Write-Host ""

if (-not $ready) {
    Write-Host "DEPLOYMENT BLOCKED." -ForegroundColor Red
    exit 2
}

Write-Host "AUDIT COMPLETE  NO DEPLOYMENT PERFORMED." -ForegroundColor Green
exit 0
