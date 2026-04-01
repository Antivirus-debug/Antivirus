@echo off
setlocal enabledelayedexpansion
title MS-DOS Prompt

:START_DOS
color 07
cls
echo Microsoft Windows [Version 10.0.22631.3447]
echo (c) Microsoft Corporation. All rights reserved.
echo.

:PROMPT_DOS
:: Simulating C:\> prompt
set /p "cmd_input=C:\Users\%USERNAME%>"

:: Check if the user typed Antivirus.exe
if /i "%cmd_input%"=="Antivirus.exe" (
    goto RUN_ANTIVIRUS
) else (
    echo '%cmd_input%' is not recognized as an internal or external command,
    echo operable program or batch file.
    echo.
    goto PROMPT_DOS
)

:RUN_ANTIVIRUS
cls
color 0A
echo [!] INITIALIZING TERMUX SYSTEM CHECK...
echo.

:: --- FETCH REAL SYSTEM INFO ---
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| findstr /C:" SSID" /C:" Profile"') do set "wifi_name=%%a"
if not defined wifi_name set "wifi_name= Ethernet / Not connected"

for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get EstimatedChargeRemaining /value 2^>nul') do set "battery=%%a%%"
if not defined battery set "battery=AC Power (100%%)"

echo [SYSTEM INFO]
echo NETWORK  : %wifi_name:~1%
echo BATTERY  : %battery%
echo OS       : %COMPUTERNAME%\%USERNAME%
echo.

:: --- ANIMATED DOTS (...) ---
<nul set /p ="Scanning security layers"
for /L %%i in (1,1,5) do (
    timeout /t 1 /nobreak >nul
    <nul set /p ="."
)
echo [DONE]
echo.

:: --- ALERT AND BEEP SOUND ---
color 0C
echo  
echo [CRITICAL] HACK DETECTED ON NETWORK: %wifi_name:~1%
echo [CRITICAL] INTRUSION ORIGIN : 185.22.41.10
echo.

echo ---------------------------------
echo [1] Delete
echo ---------------------------------
echo.

:CHOICE
:: System Beep
echo  
set /p userinput="root@termux:~# "

if "%userinput%"=="1" (
    cls
    color 0A
    echo.
    echo [OK] Purging malicious files...
    echo [OK] System secured.
    echo.
    echo Thank you for using this PROGRAM.bat, press any key to close...
    pause >nul
    echo Restarting shell...
    timeout /t 2 >nul
    goto START_DOS
) else (
    goto CHOICE
)
