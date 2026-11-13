@echo off
chcp 65001 >nul 2>&1
title ROCK GYM AI PRO - تشغيل مع نفق ngrok للموبايل
cd /d "%~dp0"

if exist "%ProgramFiles%\nodejs\node.exe" set "PATH=%ProgramFiles%\nodejs;%PATH%"
if exist "%ProgramFiles(x86)%\nodejs\node.exe" set "PATH=%ProgramFiles(x86)%\nodejs;%PATH%"

netstat -ano | findstr :5500 | findstr LISTENING >nul 2>&1
if %errorlevel% neq 0 (
    start "ROCK GYM AI SERVER" /min node server/server.js
    timeout /t 2 /nobreak >nul 2>&1
)

start http://localhost:5500

echo ====================================================================
echo  تم تشغيل السيرفر! يمكنك إدارة وتفعيل ngrok مباشرة من شاشة الإعدادات.
echo ====================================================================
timeout /t 3 /nobreak >nul 2>&1
exit /b 0
