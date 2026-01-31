# GitHub Profile Validation Script
Write-Host "Starting GitHub Profile Validation..." -ForegroundColor Green

# Check if README.md exists
if (-not (Test-Path "README.md")) {
    Write-Host "ERROR: README.md not found!" -ForegroundColor Red
    exit 1
}

Write-Host "SUCCESS: README.md found" -ForegroundColor Green

# Read README content
$readmeContent = Get-Content "README.md" -Raw

# Basic validation checks
$passedChecks = 0
$totalChecks = 5

if ($readmeContent -match "Manish Kudtarkar") {
    Write-Host "SUCCESS: Profile header with name" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Profile header missing" -ForegroundColor Red
}

if ($readmeContent -match "Technology Stack") {
    Write-Host "SUCCESS: Technology stack section" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Technology stack section missing" -ForegroundColor Red
}

if (($readmeContent -match "linkedin.com") -and ($readmeContent -match "github.com")) {
    Write-Host "SUCCESS: Social media links" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Social media links missing" -ForegroundColor Red
}

if ($readmeContent -match "github-readme-stats") {
    Write-Host "SUCCESS: GitHub statistics widgets" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: GitHub statistics widgets missing" -ForegroundColor Red
}

if ($readmeContent -match "readme-typing-svg") {
    Write-Host "SUCCESS: Dynamic typing animations" -ForegroundColor Green
    $passedChecks++
} else {
    Write-Host "ERROR: Dynamic typing animations missing" -ForegroundColor Red
}

Write-Host ""
Write-Host "Validation Results: $passedChecks/$totalChecks checks passed" -ForegroundColor Cyan

if ($passedChecks -eq $totalChecks) {
    Write-Host "All validations passed! Your GitHub profile is ready!" -ForegroundColor Green
} else {
    Write-Host "Some validations failed. Please review the issues above." -ForegroundColor Yellow
}

# Check workflow file
if (Test-Path ".github\workflows\snake.yml") {
    Write-Host "SUCCESS: GitHub Actions workflow found" -ForegroundColor Green
    $workflowContent = Get-Content ".github\workflows\snake.yml" -Raw
    
    if ($workflowContent -match "permissions:") {
        Write-Host "SUCCESS: Workflow has proper permissions configured" -ForegroundColor Green
    } else {
        Write-Host "WARNING: Workflow might need permissions configuration" -ForegroundColor Yellow
    }
} else {
    Write-Host "ERROR: GitHub Actions workflow not found" -ForegroundColor Red
}

Write-Host ""
Write-Host "Profile validation complete!" -ForegroundColor Cyan