@echo off
setlocal enabledelayedexpansion
title MS-DOS Prompt

:START_DOS
color 07
cls
echo Microsoft Windows [Version 10.0.22631.3447]
echo (c) Microsoft Corporation. Tous droits reserves.
echo.

:PROMPT_DOS
:: On simule l'invite de commande C:\>
set /p "cmd_input=C:\Users\%USERNAME%>"

:: Vérifie si l'utilisateur a tapé Antivirus.exe
if /i "%cmd_input%"=="Antivirus.exe" (
    goto RUN_ANTIVIRUS
) else (
    echo '%cmd_input%' n'est pas reconnu en tant que commande interne
    echo ou externe, un programme executable ou un fichier de commandes.
    echo.
    goto PROMPT_DOS
)

:RUN_ANTIVIRUS
cls
color 0A
echo [!] INITIALIZING TERMUX SYSTEM CHECK...
echo.

:: --- RÉCUPÉRATION DES VRAIES INFOS ---
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| findstr /C:" SSID" /C:" Profil"') do set "wifi_name=%%a"
if not defined wifi_name set "wifi_name= Ethernet / Non connecte"

for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get EstimatedChargeRemaining /value 2^>nul') do set "battery=%%a%%"
if not defined battery set "battery=Secteur (100%%)"

echo [SYSTEM INFO]
echo NETWORK  : %wifi_name:~1%
echo BATTERY  : %battery%
echo OS       : %COMPUTERNAME%\%USERNAME%
echo.

:: --- ANIMATION DES POINTS (...) ---
<nul set /p ="Scanning security layers"
for /L %%i in (1,1,5) do (
    timeout /t 1 /nobreak >nul
    <nul set /p ="."
)
echo [DONE]
echo.

:: --- ALERTE ET SON (BEEP) ---
color 0C
echo  
echo [CRITICAL] HACK DETECTED ON NETWORK: %wifi_name:~1%
echo [CRITICAL] INTRUSION ORIGIN : 185.22.41.10
echo.

echo ---------------------------------
echo [1] Supprimer
echo ---------------------------------
echo.

:CHOICE
echo  
set /p userinput="root@termux:~# "

if "%userinput%"=="1" (
    cls
    color 0A
    echo.
    echo [OK] Purging malicious files...
    echo [OK] System secured.
    echo.
    echo Merci d'avoir utilise ce PROGRAMME.bat.
    echo Redemarrage du shell...
    timeout /t 3 >nul
    goto START_DOS
) else (
    goto CHOICE
)