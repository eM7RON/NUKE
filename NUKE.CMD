::
:: Simon Tucker 2022
:: 
::


@echo NUKE.CMD
                                                                                                             
@echo off
set NUM=0 1 2 3 4 5 6
for %%x in (%NUM%) do ( 
    for %%y in (%NUM%) do (
        color %%x%%y
    )
)

color 02

setlocal
:: Prompt if script should be executed
:PROMPT
SET /P PROMPT="Deploy NUMKE.CMD (Y/[N])? "
IF /I "%PROMPT%" NEQ "Y" GOTO END

:: Delete file explorer recent files
@echo on
del /F /Q %APPDATA%\Microsoft\Windows\Recent\*
del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*
del /F /Q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*

:: Delete contents of Temp folder
cd /D %temp%
for /d %%D in (*) do rd /s /q "%%D"
del /f /q *
set ChromeDir=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data
del /q /s /f "%ChromeDir%"
rd /s /q "%ChromeDir%"

:: Empty recycle bin
powershell.exe Clear-RecycleBin -Force

:: Delete data
cd "C:\Users\%USERNAME%\Pictures"
del * /S /Q
rmdir /S /Q "C:\Users\%USERNAME%\Pictures"

cd "C:\Users\%USERNAME%\Documents"
del * /S /Q
rmdir /S /Q "C:\Users\%USERNAME%\Documents"

cd "C:\Users\%USERNAME%\Downloads"
del * /S /Q
rmdir /S /Q "C:\Users\%USERNAME%\Downloads"

cd "C:\Users\%USERNAME%\Videos"
del * /S /Q
rmdir /S /Q "C:\Users\%USERNAME%\Videos"

cd "C:\Data\DEFAULT_USER"
del * /S /Q
rmdir /S /Q "C:\Data\DEFAULT_USER"

:: Delete sysprep error logs
cd "C:\Windows\System32\Sysprep\Panther"
del * /S /Q

:: Delete WIFI passwords - please substitue in your SSID 
netsh wlan delete profile "SSID"

:: Delete powershell history
powershell.exe Remove-Item -Path (Get-PSReadlineOption).HistorySavePath

:: Delete Command Prompt History
cls

::Delete NUKE.CMD
start /b "" cmd /c del "%~f0"&exit /b

:END
endlocal