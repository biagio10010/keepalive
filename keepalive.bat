@echo off

echo The purpose of this batch script is to prevent the computer from going into sleep mode by emulating the keystroke
echo for the "num lock" key twice with a frequency specified by the user (in minutes).
echo:


:input

REM The user shall set the activation frequency of the script
set /p minutes="Enter the desired activation frequency of the script (in minutes):"
if "%minutes%"=="" goto input
set /a seconds=minutes*60
if %seconds% lss 1 (
	echo Invalid input value
	goto input
)
if %seconds% gtr 99999 (
	echo Invalid input value
	goto input
)
echo:


:loop

echo Pressing "Bloc Num" key twice...

REM The script shall simulate pressing the "Bloc Num" key twice
powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{NUMLOCK}{NUMLOCK}');"

REM If an error occurs, the script shall repeat the loop
if %ERRORLEVEL% neq 0 (
	echo Error detected, retrying to press the "Bloc Num" key twice...
	echo:
	goto loop
)

if %minutes% gtr 1 (
	echo Sleeping for %minutes% minutes...
) else (
	echo Sleeping for %minutes% minute...
)

REM The script shall pause its execution for %minutes% minutes
timeout /t %seconds% /nobreak >nul

echo:

goto loop
