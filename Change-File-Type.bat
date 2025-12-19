@echo off
setlocal enabledelayedexpansion

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
    pause
    exit /b 1
)

set count=0

for %%i in (*.%oldExt%) do (
    ren "%%i" "%%~ni.%newExt%"
    set /a count+=1
)

echo Renamed !count! file(s) from .%oldExt% to .%newExt%.

if !count! == 0 echo No files with extension .%oldExt% found.

popd
echo Operation complete.
pause
