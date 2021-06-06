:: TTS Generator
:: Author: RedBoi/#8423 
:: Suggested By: jaime.#8359
:: License: MIT
::::::::::::::::::::
:: Initialization ::
::::::::::::::::::::

title Lolipop: Offline TTS Generator [Initializing...]

:: Stop commands from spamming stuff, cleans up the screen
@echo off && cls

:: Lets variables work or something idk im not a nerd
SETLOCAL ENABLEDELAYEDEXPANSION

:: Make sure we're starting in the correct folder, and that it worked (otherwise things would go horribly wrong)
pushd "%~dp0"
if !errorlevel! NEQ 0 ( set ERROR=y & goto error_location )
if not exist "balcon" ( set ERROR=y & goto error_location )

:: Check *again* because it seems like sometimes it doesn't go into dp0 the first time???
pushd "%~dp0"
if !errorlevel! NEQ 0 ( set ERROR=y & goto error_location )
if not exist "balcon" ( set ERROR=y & goto error_location )
set SUBSCRIPT=y
if exist "config.bat" ( 
	call config.bat
	set "SUBSCRIPT="
) else (
	set ERROR=y
	set "SUBSCRIPT="
	goto error_location
)

:error_location
if !ERROR!==n ( goto noerror_location )
echo Doesn't seem like this script is in a Lolipop: Offline utilities folder.
pause && exit
:noerror_location

:: patch detection
if exist "..\patch.jpg" ( 
	goto patched 
) else ( 
	goto init
)

:patched
echo 

:init
:: Checking if the voices (like SAPI 4, OLD Cepstral/Some Voiceforge Voices, and OLD Ivona Voices) 
:: are installed - jaime
title Lolipop: Offline TTS Generator [Checking voice dependencies...]
if !SKIPCHECKDEPENDSVOICES!==y (
	echo Checking voice dependencies has been skipped.
	PING -n 4 127.0.0.1>nul
	echo:
	cls & goto main
)

if !VERBOSEWRAPPER!==n (
	echo Checking for voice dependencies...
	echo:
)

:check_sapifour
echo Checking if SAPI 4 voices are installed...
balcon\balcon.exe -l | findstr "SAPI 4" > nul
if !errorlevel! == 0 (
	echo SAPI 4 voices are not installed.
	echo:
	set SAPIFOUR_DETECTED=n
	set NEEDTHEDEPENDERS=y
) else (
	echo SAPI 4 voices are installed.
	echo:
	set SAPIFOUR_DETECTED=y
)
:check_cepstral
echo Checking if the OLD Cepstral/Some Voiceforge voices are installed...
balcon\balcon.exe -l | findstr "Cepstral" > nul
if !errorlevel! == 0 (
	echo OLD Cepstral/Some Voiceforge voices are not installed.
	set CEPSTRAL_DETECTED=n
	set NEEDTHEDEPENDERS=y
) else (
	echo OLD Cepstral/Some Voiceforge voices are installed.
	set CEPSTRAL_DETECTED=y
)
:check_ivona
echo Checking if the OLD IVONA voices are installed...
balcon\balcon.exe -l | findstr "IVONA" > nul
if !errorlevel! == 0 (
	echo OLD IVONA voices are not installed.
	set IVONA_DETECTED=n
	set NEEDTHEDEPENDERS=y
) else (
	echo OLD IVONA voices are installed.
	set IVONA_DETECTED=y
)
:: if it is checked then it gets directly to the main tts generator
:: if not then it installs missing dependencies
if !NEEDTHEDEPENDERS!==y (
	if !SKIPDEPENDINSTALLVOICES!==n (
		echo:
		echo Installing missing dependencies...
		echo:
	) else (
	echo Skipping dependency install.
	goto main
	)
) else (
	echo All dependencies are available.
	echo Turning off checking dependencies...
	echo:
	:: Initialize vars
	set CFG=config.bat
	set TMPCFG=tempconfig.bat
	:: Loop through every line until one to edit
	if exist !tmpcfg! del !tmpcfg!
	set /a count=1
	for /f "tokens=1,* delims=0123456789" %%a in ('find /n /v "" ^< !cfg!') do (
		set "line=%%b"
		>>!tmpcfg! echo(!line:~1!
		set /a count+=1
		if !count! GEQ 20 goto linereached
	)
	:linereached
	:: Overwrite the original setting
	echo set SKIPCHECKDEPENDSVOICES=y>> !tmpcfg!
	echo:>> !tmpcfg!
	:: Print the last of the config to our temp file
	more +15 !cfg!>> !tmpcfg!
	:: Make our temp file the normal file
	copy /y !tmpcfg! !cfg! >nul
	del !tmpcfg!
	:: Set in this script
	set SKIPCHECKDEPENDSVOICES=y
	goto main
)

title Lolipop: Offline TTS Generator [Installing voice dependencies...]

:: Preload variables
set INSTALL_FLAGS=ALLUSERS=1 /norestart
set SAFE_MODE=n
if /i "!SAFEBOOT_OPTION!"=="MINIMAL" set SAFE_MODE=y
if /i "!SAFEBOOT_OPTION!"=="NETWORK" set SAFE_MODE=y

:: Check for admin if installing Cepstral, SAPI 4, or IVONA voices
:: Skipped in Safe Mode, just in case anyone is running Lolipop in safe mode... for some reason
:: and also because that was just there in the code i used for this and i was like "eh screw it why remove it"
if !ADMINREQUIRED!==y (
	if !VERBOSEWRAPPER!==y ( echo Checking for Administrator rights... && echo:)
	if /i not "!SAFE_MODE!"=="y" (
		fsutil dirty query !systemdrive! >NUL 2>&1
		if /i not !ERRORLEVEL!==0 (
			color cf
			if !VERBOSEWRAPPER!==n ( cls )
			echo:
			echo ERROR
			echo:
			echo Lolipop: Offline needs to install these voices:
			echo:
			if !SAPIFOUR_DETECTED!==n ( echo SAPI 4 )
			if !CEPSTRAL_DETECTED!==n ( echo OLD Cepstral )
			if !IVONA_DETECTED!==n ( echo OLD Ivona ^(2^) )
			echo To do this, it must be started with Admin rights.
			echo:
			echo Press any key to restart this window and accept any admin prompts that pop up.
			pause
			if !DRYRUN!==n (
				echo Set UAC = CreateObject^("Shell.Application"^) > %tmp%\requestAdmin.vbs
				set params= %*
				echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> %tmp%\requestAdmin.vbs
				start "" %tmp%\requestAdmin.vbs
				exit /B
			) else (
				goto dryrungobrrr
			)
			:dryrungobrrr
			echo:
			if !DRYRUN!==y (
				echo ...yep, dry run is going great so far, let's skip the exit
				pause
				goto postadmincheck
			)
		)
	)
	if !VERBOSEWRAPPER!==y ( echo Admin rights detected. && echo:)
)

:postadmincheck
if !SAPIFOUR_DETECTED!==n

