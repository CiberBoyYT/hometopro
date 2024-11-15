@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
title HomeToPro v0.2
echo Welcome to HomeToPro v0.2!
echo This program will help you to upgrade from Windows 10/11 Home to Pro version without paying a buck!
echo You don't even need to have your Home edition activated.
echo I strongly recommend you to disable Windows Defender until the program finishes with its work, as it may trigger false positives.
color 4
echo WARNING!
color 7
echo This program is currently in beta phase, although it works perfectly.
echo This program can make modifications to the registry with the purpose of making the task easier, avoiding UAC prompts.
echo The creator of this program doesn't make responsible of damages made by wrong using this app.
echo If you already have Windows 10/11 Pro and just want to activate it, type A
echo If you have a Home version and just wanna upgrade to Pro, because you have a Pro license, type U
echo If you have a Home version and wanna upgrade to Pro and then activate Pro for free, type UA
echo If you want to exit HomeToPro, type E
echo NOTE: HomeToPro will remove your current product key. If you already have Windows Pro activated, don't run this program.
:choice
SET choice=
SET /p choice=What do you want to do? (A/U/UA/E) USE UPPERCASE!: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='A' GOTO activatepro
IF '%choice%'=='U' GOTO noactivation
IF '%choice%'=='UA' GOTO upgradeactivate
IF '%choice%'=='E' GOTO exit
echo "%choice%" is not a valid choice!
goto choice
:activatepro
cls
title HomeToPro v0.2 - Windows Pro Edition Activation
echo You have chosen: Activate Windows Pro edition. 
echo Your system will be activated using slmgr.vbs. If you want to change your choice, close this program and re launch HomeToPro.
echo Press any key to continue
pause
echo Installing product key for Windows Pro edition...
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
timeout /t 1 /nobreak > NUL
echo Setting activation server..
slmgr /skms kms8.msguides.com
timeout /t 4 /nobreak > NUL
echo Finishing activation... Please be patient.
slmgr /ato
timeout /t 6 /nobreak > NUL
cls
echo Congratulations!
echo Your Windows version has been completely activated using a Windows Pro product key!
echo Enjoy your fully activated system!
echo Press any key to exit HomeToPro
pause
:noactivation
title HomeToPro v0.2 - Upgrade from Home to Pro (NO ACTIVATION)
echo You have chosen: Upgrade from Home edition to Pro edition without activating Windows. This process can take around 5 minutes, please be patient.
echo This method will use LicenseManager and wuauserv to switch your Windows edition. If you want to change your choice, close this program and re launch HomeToPro.
echo Press any key to continue
pause
echo Starting upgrade, please be patient. Don't close this window.
sc config LicenseManager start= auto & net start LicenseManager
sc config wuauserv start= auto & net start wuauserv
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T
shutdown -r -t 60 -c "HomeToPro has successfully upgraded your system to Pro edition. Save all your data and your system will reboot in 1 minute."
echo Your system has been succesfully updated. 
echo Press any key to exit
pause
:upgradeactivate
cls 
title HomeToPro v0.2 - Upgrade from Home to Pro (ACTIVATION INCLUDED)
echo You have chosen: Upgrade from Home edition to Pro edition and after that, activate Windows.
echo Be patient! This process can take around 10 minutes, and your system will reboot several times.
echo Never close the HomeToPro window, doing it can result in an unstable machine.
echo Press any key to continue...
pause
echo Disabling UAC...
%windir%\System32\cmd.exe /c %windir%\System32\reg.exe ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
%windir%\System32\cmd.exe /c %windir%\System32\reg.exe ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
echo Preparing directories...
mkdir %windir%\HomeToPro
timeout /t 1 /nobreak > NUL
echo Compiling activator...
echo @echo off >> %windir\HomeToPro\activator.bat
echo if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b) >> %windir%\HomeToPro\activator.bat
echo slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX >> %windir\HomeToPro\activator.bat
echo slmgr /skms kms8.msguides.com >> %windir\HomeToPro\activator.bat
echo timeout /t 3 /nobreak > NUL >> %windir\HomeToPro\activator.bat
echo slmgr /ato >> %windir\HomeToPro\activator.bat
echo timeout /t 8 /nobreak > NUL >> %windir\HomeToPro\activator.bat
echo %windir%\System32\cmd.exe /c %windir%\System32\reg.exe ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f >> %windir\HomeToPro\activator.bat
echo %windir%\System32\cmd.exe /c %windir%\System32\reg.exe ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 /f >> %windir\HomeToPro\activator.bat
echo shutdwon -r -t 05 -c "Windows has been succesfully activated, wait 5 seconds" >> %windir\HomeToPro\activator.bat
echo rd /s /q %windir%\HomeToPro >> %windir%\HomeToPro\activator.bat
echo (goto) 2>nul & del "%~f0" >> %windir\HomeToPro\activator.bat
echo Copying activator to startup folder...
copy "%windir%\HomeToPro\activator.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\activator.bat"
echo Performing the update....
sc config LicenseManager start= auto & net start LicenseManager
sc config wuauserv start= auto & net start wuauserv
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T
cls
echo Your system has been succesfully upgraded.
echo Windows needs to reboot to finish the upgrade.
echo After rebooting, a CMD window will popup and it will perform the activation.
echo After it finishes the activation, it will reboot your computer and your system will finally be ready to use with your brand new Pro edition.
echo After the reboot, don't close the CMD window that will popup.
echo Also, don't re enable UAC, doing so will make the program not work.
echo Press any key to reboot your system...
pause
shutdown -r -t 00
:exit
echo Exiting...
pause