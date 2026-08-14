$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " LEARNEARNHUB — RECONSTRUCTION INTEGRATION + DEPLOYMENT" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$Root = (Get-Location).Path
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$Backup = "$Root-DEPLOY-BACKUP-$Stamp"

Write-Host "`n[1/8] Current Git state..." -ForegroundColor Yellow
git status --short --branch
git log -1 --oneline

Write-Host "`n[2/8] Creating complete filesystem backup..." -ForegroundColor Yellow
if (-not (Test-Path $Backup)) {
    robocopy $Root $Backup /E /XD .git node_modules .vercel /R:1 /W:1 /NFL /NDL /NJH /NJS | Out-Null
}
Write-Host "Backup: $Backup" -ForegroundColor Green

Write-Host "`n[3/8] Checking critical application files..." -ForegroundColor Yellow
$Critical = @(
    "public/index.html",
    "public/login.html",
    "public/register.html",
    "public/courses.html",
    "public/course-player.html",
    "public/lesson.html",
    "public/dashboard.html",
    "server.js",
    "package.json"
)

$Missing = @()
foreach ($File in $Critical) {
    if (-not (Test-Path $File)) {
        $Missing += $File
    }
}

if ($Missing.Count -gt 0) {
    Write-Host "CRITICAL FILES MISSING:" -ForegroundColor Red
    $Missing | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    exit 1
}

Write-Host "Critical files: PASS" -ForegroundColor Green

Write-Host "`n[4/8] Checking JavaScript syntax..." -ForegroundColor Yellow
$JsFiles = Get-ChildItem -Path . -Recurse -File -Filter *.js |
    Where-Object {
        $_.FullName -notmatch "\\node_modules\\" -and
        $_.FullName -notmatch "\\.git\\" -and
        $_.FullName -notmatch "backup"
    }

$SyntaxErrors = 0

foreach ($File in $JsFiles) {
    $Result = & node --check $File.FullName 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "FAIL: $($File.FullName)" -ForegroundColor Red
        $Result | ForEach-Object { Write-Host $_ -ForegroundColor Red }
        $SyntaxErrors++
    }
}

if ($SyntaxErrors -gt 0) {
    Write-Host "`nJavaScript syntax validation FAILED: $SyntaxErrors file(s)." -ForegroundColor Red
    exit 1
}

Write-Host "JavaScript syntax: PASS" -ForegroundColor Green

Write-Host "`n[5/8] Checking API/frontend references..." -ForegroundColor Yellow

$ApiReferences = Get-ChildItem public -Recurse -File -Include *.html,*.js |
    Where-Object {
        $_.FullName -notmatch "\\backup"
    } |
    Select-String -Pattern 'fetch\(["''](/api/|/api)|fetch\(`(/api/|/api)|href=["'']/api/|action=["'']/api/' -AllMatches

Write-Host "API references discovered: $($ApiReferences.Count)" -ForegroundColor Green

Write-Host "`n[6/8] Checking server route inventory..." -ForegroundColor Yellow

if (Test-Path server.js) {
    $Routes = Select-String -Path server.js -Pattern 'app\.(get|post|put|patch|delete)\s*\('
    Write-Host "server.js direct routes: $($Routes.Count)" -ForegroundColor Green
}

if (Test-Path api/index.js) {
    $ApiRoutes = Select-String -Path api/index.js -Pattern 'app\.(get|post|put|patch|delete)\s*\('
    Write-Host "api/index.js direct routes: $($ApiRoutes.Count)" -ForegroundColor Green
}

Write-Host "`n[7/8] Running package checks..." -ForegroundColor Yellow

if (Test-Path package.json) {
    npm run --if-present lint
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Lint failed." -ForegroundColor Red
        exit 1
    }

    npm test --if-present
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Tests failed." -ForegroundColor Red
        exit 1
    }
}

Write-Host "`n[8/8] Creating reconstruction integration checkpoint..." -ForegroundColor Yellow

git add -A

$Diff = git diff --cached --stat
Write-Host $Diff

git commit -m "reconstruct: reconcile frontend with existing API capabilities"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Commit failed." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host " LOCAL INTEGRATION CHECKS PASSED" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host "Backup: $Backup"
Write-Host "Branch:"
git branch --show-current
Write-Host ""
Write-Host "Next command: git push origin reconstruction-integration-20260810"
Write-Host "Deployment is intentionally NOT performed by this script."
