@echo off

set /p oldFileType=Enter the file type you want to change:
set /p newFileType=Enter the new file type:
set /p directory=Enter the directory where the files are located:

cd /d %directory%

for /f "delims=" %%i in ('dir /b *%oldFileType%') do (
ren "%%i" "%%~ni.%newFileType%"
)

echo File type conversion complete.
pause
