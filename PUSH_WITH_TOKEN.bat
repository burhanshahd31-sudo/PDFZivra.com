@echo off
title Push to GitHub with Token
cd /d "%~dp0"
echo ========================================================
echo   Push PDFMaster to GitHub using Personal Access Token
echo ========================================================
echo.
echo GitHub requires a Personal Access Token (PAT) instead of your password.
echo If you don't have one, get it here: https://github.com/settings/tokens
echo.
set /p GITHUB_TOKEN="Paste your GitHub Token (starts with ghp_) and press Enter: "

if "%GITHUB_TOKEN%"=="" (
    echo [ERROR] Token cannot be empty!
    pause
    exit /b 1
)

set "GIT_EXE=C:\Users\FTC\AppData\Local\github-copilot-git-2.53.0-4\cmd\git.exe"

echo.
echo [1/2] Staging and committing any pending changes...
"%GIT_EXE%" add .
"%GIT_EXE%" commit -m "Deploy latest PDFMaster with full responsive filters and Netlify files" 2>nul

echo.
echo [2/2] Pushing to GitHub (burhanshahd31-sudo/PDFTOOLS.PK)...
"%GIT_EXE%" push https://burhanshahd31-sudo:%GITHUB_TOKEN%@github.com/burhanshahd31-sudo/PDFTOOLS.PK.git main --force

echo.
echo ========================================================
if %errorlevel% equ 0 (
    echo [SUCCESS] Pushed to GitHub successfully!
    echo Netlify is now automatically building and deploying to https://pdftools-gov.netlify.app
) else (
    echo [ERROR] Push failed. Please check your token permissions (must have 'repo' scope).
)
echo ========================================================
echo.
pause

