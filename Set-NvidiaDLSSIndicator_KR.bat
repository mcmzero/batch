@echo off
:: 배치 파일을 관리자 권한으로 실행
:: 관리자 권한이 아닌 경우 스크립트를 다시 실행
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo 관리자 권한으로 실행해야 합니다.
    pause
    exit /b
)

:: 레지스트리 경로 설정
set regPath=HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore
set valueName=ShowDlssIndicator

:: 옵션 선택
echo 레지스트리 값을 설정 또는 삭제합니다.
echo.
echo 1. 레지스트리 값 설정 (기본값: 1024)
echo 2. 레지스트리 값 삭제
echo.
set /p choice=옵션을 선택하세요 (1 또는 2):

if "%choice%"=="1" (
    echo 레지스트리 값을 설정합니다.
    reg add "%regPath%" /v "%valueName%" /t REG_DWORD /d 1024 /f
    if %ERRORLEVEL% EQU 0 (
        echo %valueName% 값이 1024(10진수)로 설정되었습니다.
    ) else (
        echo 레지스트리 값을 설정하는 데 실패했습니다.
    )
) else if "%choice%"=="2" (
    echo 레지스트리 값을 삭제합니다.
    reg delete "%regPath%" /v "%valueName%" /f
    if %ERRORLEVEL% EQU 0 (
        echo %valueName% 값이 삭제되었습니다.
    ) else (
        echo 레지스트리 값을 삭제하는 데 실패했습니다.
    )
) else (
    echo 잘못된 선택입니다. 1 또는 2를 입력하세요.
)

timeout /t 15
