@echo off
title Push PDFMaster to GitHub
cd /d "%~dp0"
echo ========================================================
echo   Pushing PDFMaster to GitHub (burhanshahd31-sudo/PDFTOOLS.PK)
echo ========================================================
echo.

set "GIT_EXE=C:\Users\FTC\AppData\Local\github-copilot-git-2.53.0-4\cmd\git.exe"

if not exist "%GIT_EXE%" (
    where git >nul 2>&1
    if %errorlevel% equ 0 (
        set "GIT_EXE=git"
    ) else (
        echo [ERROR] Git was not found!
        pause
        exit /b 1
    )
)

echo [1/3] Checking Git Status...
"%GIT_EXE%" status --short

echo.
echo [2/3] Adding changes and committing...
"%GIT_EXE%" add .
"%GIT_EXE%" commit -m "Update complete working PDFMaster app with responsive filters and Netlify files" 2>nul

echo.
echo [3/3] Pushing to GitHub (origin main)...
echo If a GitHub login window appears, please click 'Sign in with your browser'.
"%GIT_EXE%" push -u origin main --force

echo.
echo ========================================================
if %errorlevel% equ 0 (
    echo [SUCCESS] Pushed to GitHub successfully!
    echo Netlify will now automatically build and update pdftools-gov.netlify.app!
) else (
    echo [NOTE] If push was canceled, you can also drag and drop the 'public' folder into Netlify Deploys!
)
echo ========================================================
echo.
pause

