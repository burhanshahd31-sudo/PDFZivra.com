# PowerShell script to push all project files to GitHub
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  Pushing PDFMaster to GitHub (burhanshahd31-sudo/PDFTOOLS.PK)" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

$gitExe = "C:\Users\FTC\AppData\Local\github-copilot-git-2.53.0-4\cmd\git.exe"

if (-not (Test-Path $gitExe)) {
    $cmd = Get-Command git -ErrorAction SilentlyContinue
    if ($cmd) {
        $gitExe = $cmd.Source
    } else {
        Write-Host "[ERROR] Git was not found on this computer." -ForegroundColor Red
        Exit 1
    }
}

Write-Host "Using Git at: $gitExe" -ForegroundColor Gray

# Configure git identity if not present
& $gitExe config user.name "burhanshahd31-sudo"
& $gitExe config user.email "burhanshahd31@users.noreply.github.com"

# Ensure branch is main
& $gitExe branch -M main

# Set remote origin
& $gitExe remote remove origin 2>$null
& $gitExe remote add origin https://github.com/burhanshahd31-sudo/PDFTOOLS.PK.git

Write-Host "[1/2] Adding all updated files..." -ForegroundColor Yellow
& $gitExe add .
& $gitExe commit -m "Update complete working PDFMaster app with responsive filters and Netlify files" 2>$null

Write-Host "[2/2] Pushing to GitHub repository..." -ForegroundColor Yellow
Write-Host "If a GitHub browser prompt appears, please click 'Sign in with your browser'." -ForegroundColor Cyan
& $gitExe push -u origin main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "[SUCCESS] Pushed to GitHub successfully!" -ForegroundColor Green
    Write-Host "Netlify will automatically build and deploy the live site at https://pdftools-gov.netlify.app!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "[NOTE] Push requires browser sign-in. Alternatively, you can drag and drop the 'public' folder into Netlify Deploys tab!" -ForegroundColor Yellow
}
