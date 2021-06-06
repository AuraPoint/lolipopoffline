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
if !SKIPCHECKDEPENDSVOICES!==y (
	echo Checking dependencies has been skipped.
	PING -n 4 127.0.0.1>nul
	echo:
	cls & goto main
)

if !VERBOSEWRAPPER!==n (
	echo Checking for dependencies...
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
	set CEPSTRAL_DETECTED=n
	set NEEDTHEDEPENDERS=y
) else (
	echo OLD IVONA voices are installed.
	set CEPSTRAL_DETECTED=y
)

