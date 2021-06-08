:: Wrapper: Offline Config
:: This file is modified by settings.bat. It is not organized, but comments for each setting have been added.
:: You should be using settings.bat, and not touching this. Offline relies on this file remaining consistent, and it's easy to mess that up.

:: Opens this file in Notepad when run
setlocal
if "%SUBSCRIPT%"=="" ( start notepad.exe "%CD%\%~nx0" & exit )
endlocal

:: Shows exactly Offline is doing, and never clears the screen. Useful for development and troubleshooting. Default: n
set VERBOSEWRAPPER=n

:: Won't check for dependencies (flash, node, etc) and goes straight to launching. Useful for speedy launching post-install. Default: n
set SKIPCHECKDEPENDS=n

:: Won't install dependencies, regardless of check results. Overridden by SKIPCHECKDEPENDS. Mostly useless, why did I add this again? Default: n
set SKIPDEPENDINSTALL=n

:: Won't check for dependencies (old cepstral, old ivona, sapi 4) and goes straight to launching. Useful for speedy launching post-install. Default: n
set SKIPCHECKDEPENDSVOICES=n

:: Won't install dependencies, regardless of check results. Overridden by SKIPCHECKDEPENDSVOICES. Mostly useless, why did I add this again? Default: n
set SKIPDEPENDINSTALLVOICES=n

:: Opens Offline in an included copy of ungoogled-chromium. Allows continued use of Flash as modern browsers disable it. Default: y
set INCLUDEDCHROMIUM=y

:: Opens INCLUDEDCHROMIUM in headless mode. Looks pretty nice. Overrides CUSTOMBROWSER and BROWSER_TYPE. Default: y
set APPCHROMIUM=y

:: Opens Offline in a browser of the user's choice. Needs to be a path to a browser executable in quotes. Default: n
set CUSTOMBROWSER=n

:: Lets the launcher know what browser framework is being used. Mostly used by the Flash installer. Accepts "chrome", "firefox", and "n". Default: n
set BROWSER_TYPE=n
set CUSTOMBROWSER=n

set DRYRUN=n
set BROWSER_TYPE=chrome

set CEPSTRAL=n

:: Opens Offline in an included copy of Basilisk, sourced from BlueMaxima's Flashpoint.
:: Allows continued use of Flash as modern browsers disable it. Default: n
set INCLUDEDBASILISK=y

:: Makes it so both the settings and the Wrapper launcher shows developer options. Default: n
set DEVMODE=y

:: Tells settings.bat which port the frontend is hosted on. (If changed manually, you MUST also change the value of "SERVER_PORT" to the same value in wrapper\env.json) Default: 4343
set PORT=4343
