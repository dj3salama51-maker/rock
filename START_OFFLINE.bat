@echo off
chcp 65001 >nul 2>&1
title ROCK GYM AI PRO - تشغيل البرنامج
cd /d "%~dp0"

if exist "%~dp0bin\node.exe" set "PATH=%~dp0bin;%PATH%"
if exist "%ProgramFiles%\nodejs\node.exe" set "PATH=%ProgramFiles%\nodejs;%PATH%"
if exist "%ProgramFiles(x86)%\nodejs\node.exe" set "PATH=%ProgramFiles(x86)%\nodejs;%PATH%"

where node >nul 2>&1
if %errorlevel% neq 0 goto no_node

netstat -ano | findstr :5500 | findstr LISTENING >nul 2>&1
if %errorlevel% neq 0 (
    start "ROCK GYM AI SERVER" /min node server/server.js
    timeout /t 2 /nobreak >nul 2>&1
)

if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app=http://localhost:5500
    goto end
)
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" --app=http://localhost:5500
    goto end
)
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" (
    start "" "%LocalAppData%\Google\Chrome\Application\chrome.exe" --app=http://localhost:5500
    goto end
)
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app=http://localhost:5500
    goto end
)
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app=http://localhost:5500
    goto end
)

start http://localhost:5500
goto end

:no_node
echo.
echo ====================================================================
echo  [X] بيئة تشغيل Node.js غير مثبتة على هذا الجهاز!
echo.
echo  يرجى النقر مرتين أولاً على ملف:
echo  (1-تثبيت_المكتبات_وتهيئة_الجهاز.bat)
echo  ليتم تثبيت بيئة العمل والمكتبات تلقائياً.
echo ====================================================================
echo.
pause
exit /b 1

:end
exit /b 0
