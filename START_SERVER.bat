@echo off
title PDF Master Server - Port 9000
color 0B
cd /d "%~dp0"

echo ===============================================================
echo               PDF MASTER - SAAS LOCAL SERVER
echo ===============================================================
echo.

echo [1/3] Checking MySQL database service...
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo [OK] MySQL is already running.
) else (
    echo [*] Starting XAMPP MySQL server...
    if exist "C:\xampp\mysql\bin\mysqld.exe" (
        start "" /B "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" --standalone
        timeout /t 2 /nobreak >nul
        echo [OK] MySQL started.
    ) else (
        echo [!] Notice: Please ensure MySQL is running in XAMPP Control Panel.
    )
)

echo.
echo [2/3] Checking PHP environment...
set PHP_BIN=php
where php >nul 2>nul
if %ERRORLEVEL% neq 0 (
    if exist "C:\xampp\php\php.exe" (
        set PHP_BIN=C:\xampp\php\php.exe
    ) else if exist "C:\php\php.exe" (
        set PHP_BIN=C:\php\php.exe
    ) else (
        echo [ERROR] PHP executable not found! Please install PHP or XAMPP.
        pause
        exit /b 1
    )
)
echo [OK] Using PHP: %PHP_BIN%

echo.
echo [3/3] Starting PDF Master on Port 9000...
echo.
echo ===============================================================
echo   WEBSITE URL : http://localhost:9000
echo   ADMIN LOGIN : http://localhost:9000/login
echo   EMAIL       : admin@pdfmaster.com
echo   PASSWORD    : admin123456
echo ===============================================================
echo.
echo Opening browser to http://localhost:9000 ...

:: Automatically open default browser after 2 seconds
start "" cmd /c "timeout /t 2 /nobreak >nul && start http://localhost:9000"

:: Start Laravel server on port 9000
"%PHP_BIN%" artisan serve --host=127.0.0.1 --port=9000

echo.
echo Server stopped.
pause
