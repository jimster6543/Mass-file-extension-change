@echo off
setlocal enabledelayedexpansion

echo.
echo Do you want to process subfolders recursively? (Y/N, default: N)
set /p "recursive=>"

if /i "%recursive%"=="Y" (
    set "recursive=Y"
) else (
    set "recursive=N"
)

echo Enter the old file extension (e.g., txt - without dot):
set /p "oldExt=>"

echo Enter the new file extension (e.g., jpg - without dot):
set /p "newExt=>"

echo Enter the directory path (or press Enter for current directory):
set /p "dirPath=>"

if "%dirPath%"=="" set "dirPath=."

pushd "%dirPath%" 2>nul
if errorlevel 1 (
    echo Error: Directory not found or inaccessible.
    echo.
    pause
    exit /b 1
)

set count=0

if "%recursive%"=="Y" (
    for /r %%i in (*.%oldExt%) do (
        if not exist "%%~ni.%newExt%" (
            ren "%%i" "%%~ni.%newExt%"
            set /a count+=1
        ) else (
            echo SKIPPED: "%%~nxi" - target "%%~ni.%newExt%" already exists
        )
    )
) else (
    for %%i in (*.%oldExt%) do (
        if not exist "%%~ni.%newExt%" (
            ren "%%i" "%%~ni.%newExt%"
            set /a count+=1
        ) else (
            echo SKIPPED: "%%~nxi" - target "%%~ni.%newExt%" already exists
        )
    )
)

echo.
echo Renamed !count! file(s) from .%oldExt% to .%newExt%.

if !count! == 0 echo No files were renamed (either none found or all targets already exist).

popd
echo Operation complete.
pause
