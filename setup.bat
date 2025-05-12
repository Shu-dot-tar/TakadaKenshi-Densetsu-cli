@echo off
setlocal

echo === Chuck Norris Facts CLI Setup ===
echo:

set SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%SCRIPT_DIR:\=/%

REM Add to PATH permanently
echo Updating the PATH environment variable...

REM Get the current PATH
set "CURRENT_PATH="
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "CURRENT_PATH=%%b"

REM Set the new PATH
if not defined CURRENT_PATH (
    set "NEW_PATH=%SCRIPT_DIR%"
) else (
    set "NEW_PATH=%CURRENT_PATH%;%SCRIPT_DIR%"
)

REM Update the PATH environment variable
reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%NEW_PATH%" /f
echo PATH updated! : %NEW_PATH%

REM Grant execute permission to fact.py
echo Granting execute permission to fact.py...
powershell -Command "Set-ItemProperty -Path '%SCRIPT_DIR%\fact.py' -Name IsReadOnly -Value $false"

REM Generate fact.py if not exist
if not exist "%SCRIPT_DIR%\fact.bat" (
    echo Generating fact.py...
    echo @echo off > "%SCRIPT_DIR%\fact.bat"
    echo python "%%~dp0fact.py" %%* >> "%SCRIPT_DIR%\fact.bat"
)

echo:
echo Setup complete!
echo The following path has been added to the system environment variables: %SCRIPT_DIR%
echo Please open a new Command Prompt and run the fact command.
echo Caution: You may need to reboot your device for the settings to take effect.
echo:

endlocal