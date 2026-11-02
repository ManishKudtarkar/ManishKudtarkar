# GitHub Profile Validation Script (Windows PowerShell)
# Mirrors validate.js — keep both in sync when changing README structure.
Write-Host "Starting GitHub Profile Validation..." -ForegroundColor Green

# Check if README.md exists
if (-not (Test-Path "README.md")) {
    Write-Host "ERROR: README.md not found!" -ForegroundColor Red
    exit 1
}

Write-Host "SUCCESS: README.md found" -ForegroundColor Green

# Read README content
$readmeContent = Get-Content "README.md" -Raw

$totalChecks = 7
$passedChecks = 0

# 1. Profile identity
if ($readmeContent -match "Manish Kudtarkar") {
    Write-Host "SUCCESS: Profile identity (name present)" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Profile header missing" -ForegroundColor Red
}

# 2. Technology stack section
if ($readmeContent -match "(?i)stack|technologies") {
    Write-Host "SUCCESS: Technology stack section" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Technology stack section missing" -ForegroundColor Red
}

# 3. Contact / social links
if (($readmeContent -match "linkedin\.com") -and ($readmeContent -match "github\.com")) {
    Write-Host "SUCCESS: Social media links" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Social media links missing" -ForegroundColor Red
}

# 4. GitHub stats widgets
if ($readmeContent -match "github-readme-stats") {
    Write-Host "SUCCESS: GitHub statistics widgets" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: GitHub statistics widgets missing" -ForegroundColor Red
}

# 5. Live/auto-updating data section
if (($readmeContent -match "START_SECTION:waka") -or ($readmeContent -match "readme-typing-svg")) {
    Write-Host "SUCCESS: Live/auto-updating data section" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Live data section missing" -ForegroundColor Red
}

# 6. Featured projects
if (($readmeContent -match "axflo\.in") -or ($readmeContent -match "industrial-smart-grid")) {
    Write-Host "SUCCESS: Featured projects present" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Featured projects missing" -ForegroundColor Red
}

# 7. Contribution visualization
if ($readmeContent -match "github-contribution-grid-snake") {
    Write-Host "SUCCESS: Contribution snake animation" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Contribution snake animation missing" -ForegroundColor Red
}

Write-Host ""
Write-Host "Validation Results: $passedChecks/$totalChecks checks passed" -ForegroundColor Cyan

if ($passedChecks -eq $totalChecks) {
    Write-Host "All validations passed! Your GitHub profile is ready!" -ForegroundColor Green
} else {
    Write-Host "Some validations failed. Please review the issues above." -ForegroundColor Yellow
}

# Workflow files
if (Test-Path ".github\workflows\snake.yml") {
    Write-Host "SUCCESS: Snake animation workflow found" -ForegroundColor Green
    $workflowContent = Get-Content ".github\workflows\snake.yml" -Raw
    if ($workflowContent -match "permissions:") {
        Write-Host "SUCCESS: Workflow has proper permissions configured" -ForegroundColor Green
    } else {
        Write-Host "WARNING: Workflow might need permissions configuration" -ForegroundColor Yellow
    }
} else {
    Write-Host "ERROR: Snake animation workflow not found" -ForegroundColor Red
}

if (Test-Path ".github\workflows\waka.yml") {
    Write-Host "SUCCESS: WakaTime stats workflow found" -ForegroundColor Green
} else {
    Write-Host "WARNING: WakaTime workflow not found - coding stats will not auto-update" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Profile validation complete!" -ForegroundColor Cyan
