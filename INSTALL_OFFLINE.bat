@echo off
chcp 65001 >nul 2>&1
title ROCK GYM AI PRO - معالج التثبيت وتهيئة النظام
color 0A
cls

echo ====================================================================
echo        ROCK GYM AI PRO - معالج التثبيت والتهيئة للعمل أوفلاين
echo                   (يعمل 100%% بدون الحاجة لإنترنت)
echo ====================================================================
echo حقوق البرمجة والتطوير: مهندس سلامه حسن • 01001191793
echo ====================================================================
echo.

cd /d "%~dp0"

if exist "%~dp0bin\node.exe" set "PATH=%~dp0bin;%PATH%"
if exist "%ProgramFiles%\nodejs\node.exe" set "PATH=%ProgramFiles%\nodejs;%PATH%"
if exist "%ProgramFiles(x86)%\nodejs\node.exe" set "PATH=%ProgramFiles(x86)%\nodejs;%PATH%"

where node >nul 2>&1
if %errorlevel% equ 0 goto node_ready

echo [!] بيئة تشغيل Node.js غير مثبتة على هذا الجهاز.
echo [*] جاري تشغيل مثبت Node.js تلقائياً من مجلد installers...
echo.

if not exist "%~dp0installers\node-setup.msi" goto missing_msi

start "" /wait msiexec /i "%~dp0installers\node-setup.msi"
echo [OK] تم الانتهاء من تشغيل مثبت Node.js.

if exist "%~dp0bin\node.exe" set "PATH=%~dp0bin;%PATH%"
if exist "%ProgramFiles%\nodejs\node.exe" set "PATH=%ProgramFiles%\nodejs;%PATH%"
if exist "%ProgramFiles(x86)%\nodejs\node.exe" set "PATH=%ProgramFiles(x86)%\nodejs;%PATH%"

where node >nul 2>&1
if %errorlevel% neq 0 goto need_restart

:node_ready
echo [OK] بيئة تشغيل Node.js جاهزة ونشطة!
echo.
echo [*] جاري فحص المكتبات وتهيئة قاعدة البيانات وتفعيل التشغيل التلقائي...
echo.

node server/setup_offline.js

echo.
echo ====================================================================
echo [OK] اكتمل التثبيت والتهيئة بنجاح 100%%!
echo تم إنشاء اختصار البرنامج على سطح المكتب: ROCK GYM AI PRO
echo وتم تفعيل التشغيل التلقائي بمجرد تشغيل الجهاز
echo ====================================================================
echo.
pause
exit /b 0

:missing_msi
echo.
echo [X] لم يتم العثور على ملف installers\node-setup.msi!
echo يرجى التأكد من وجود مجلد installers كاملاً.
echo.
pause
exit /b 1

:need_restart
echo.
echo [!] تم التثبيت، يرجى إعادة تشغيل هذا الملف مرة أخرى لتأكيد التفعيل.
echo.
pause
exit /b 1
