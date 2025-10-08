@echo off
setlocal

:: Check if a port number was provided as an argument.
if "%1"=="" (
    echo ERROR: No port number provided.
    echo.
    echo Usage: %~n0 [port]
    echo Example: %~n0 300
    goto :eof
)

echo Searching for process(es) on port %1...
echo.

set "pidFound="
:: Loop through the output of netstat to find the Process ID (PID).
:: Note the double percent signs (%%p) are required for variables in a batch file.
for /f "tokens=5" %%p in ('netstat -aon ^| findstr ":%1"') do (
    set pidFound=1
    echo Found process with PID %%p. Attempting to terminate...
    taskkill /F /PID %%p
)

:: Check if any process was found.
if not defined pidFound (
    echo No process found listening on port %1.
)

echo.
echo Script finished.
endlocal
