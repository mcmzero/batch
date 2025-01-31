@echo off
:: Run the batch file as administrator
:: If not running as administrator, restart the script with admin privileges
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo This script must be run as administrator.
    pause
    exit /b
)

:: Set registry path and value name
set regPath=HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore
set valueName=ShowDlssIndicator

:: Prompt user for action
echo Set or delete the registry value.
echo.
echo 1. Set registry value (default: 1024)
echo 2. Delete registry value
echo.
set /p choice=Choose an option (1 or 2):

if "%choice%"=="1" (
    echo Setting the registry value.
    reg add "%regPath%" /v "%valueName%" /t REG_DWORD /d 1024 /f
    if %ERRORLEVEL% EQU 0 (
        echo %valueName% has been set to 1024 (decimal).
    ) else (
        echo Failed to set the registry value.
    )
) else if "%choice%"=="2" (
    echo Deleting the registry value.
    reg delete "%regPath%" /v "%valueName%" /f
    if %ERRORLEVEL% EQU 0 (
        echo %valueName% has been deleted.
    ) else (
        echo Failed to delete the registry value.
    )
) else (
    echo Invalid choice. Please enter 1 or 2.
)

timeout /t 15
