@echo "This file is not supposed to be executed" & pause & exit &:: this is an inline comment

F8 at start-up &:: Safe mode / Mode sans echec
F7 in cmd.exe -> history &:: BUT better use Cmder or at least PowerShell ISE

where %cmd% &:: 'which' equivalent
ipconfig /displaydns

powercfg -h off/on &:: as admin, delete hiberfil.sys
schtasks &:: task scheduler
msinfo32 &:: info composants
services.msc &:: Services windows
magnify.exe &:: Loupe
clipbrd.exe &:: Display clipboard
regsvr32 %dll_file% &:: register dll
vssadmin list shadows &:: list available Volume Shadow Copies aka restore points, cf. http://superuser.com/a/165576)

robocopy "C:\Source" "E:\Destination" /E /PURGE &:: Backup

dir %WINDIR%\Microsoft.Net\Framework\v* /O:-N /B &:: Check .NET version

icacls * /T /Q /C /RESET &:: reset files permissions
:: Default .dll owner : NT SERVICE\TrustedInstaller

pskill, pslist... &:: Sysinternals Process Utilities
handle.exe -a | grep ': Key\|pid:' | grep 'COMPONENTS\|pid:' | grep -B1 'COMPONENTS' &:: Find all PIDs of processes using RegKeys containing 'COMPONENTS'

::: Usual cleanup steps
- create a restoration point
- AVG/Avast scan
- cleanmgr.exe
- CCCleaner
- Malwarebytes (+ possibly HijackThis)
- perfmon.exe / resmon.exe / Sysinternals ProcessExplorer
- Microsoft Securit Scanner : http://www.microsoft.com/security/scanner
- Farbar Service Scanner : http://www.bleepingcomputer.com/download/farbar-service-scanner/dl/62
- Defrag
- désactiver l'indexation des disques

::: Deeper clean-up/checks
sfc /scannow &:: To restore system files
chkdsk /r /f
:: CheckSUR : check system is up-to-date and installation conform aka KB947821 - http://technet.microsoft.com/en-us/library/ee619779%28WS.10%29.aspx
DISM.exe /Online /Cleanup-image /Scanhealth &:: on Win7, one needs to run KB947821.msu
:: -> when you run this command, DISM uses Windows Update to provide the files that are required to fix corruptions. However, if your Windows Update client is already broken, use a running Windows installation as the repair source, or use a Windows side-by-side folder from a network share or from a removable media, such as the Windows DVD, as the source of the files. To do this, run the following command instead:
DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows /LimitAccess
findstr /c:"[SR]" %windir%\logs\cbs\cbs.log >sfcdetails.txt &:: to read CBS.Log

::: Remove a file as admin :
:: 1- Take ownership of the files
takeown /f file
takeown /f directory /r
:: 2- Give yourself full rights on the file:
cacls file /G username:F
:: 3- Remove file
del file

"L'ordinal 459 est introuvable dans la bibliothèque de liens dynamiques urlmon.dll" -> uninstall MAJ KB2847204


::::::::::
:: Batch
::::::::::
@echo off
title Whatever &:: sets the terminal window title
cls &:: clear console screan
set file=%1 &:: set variable to be the first cmd-line argument
if exist %file% del %file%
echo %file% >> %file%
copy "C:\file.txt" "D:\%date:/=-%_file.txt.bak" &:: Variable substitution
:label
goto:label
:: Loop variables have 2 restrictions: they are one-letters only and their % must be doubled in .bat files
for /l %%x in (1, 1, 100) do echo %%x
for /r %%f in (file_A file_B) do if exist "%%f" echo %%f &:: paths are relative to the local dir
for /f "delims=" %%l in (%file%) do set /a counter+=1 &:: /a => evaluate numeric expression
for /f "tokens=1,* delims=:" %%i in ('findstr /n /r . file.txt') do if %%i geq 10 if %%i leq 20 echo %%j