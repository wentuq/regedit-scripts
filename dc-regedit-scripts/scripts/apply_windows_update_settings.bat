@echo off
setlocal

rem Get the script directory
set script_dir=%~dp0

rem Get the main directory
set main_dir=%script_dir%..

rem Get Windows version
for /f "tokens=4-5 delims=[.] " %%i in ('ver') do set ver=%%i.%%j

rem Check if Windows 10 (version 10.0.xxxx)
if "%ver%"=="10.0" (
    echo Detected Windows 10
    regedit /s "%main_dir%\win10-disable-automatic-updates.reg"
    goto :end
)

rem Check if Windows 11 (version 10.0.22000 or higher)
for /f "tokens=1-4 delims=." %%i in ("%ver%") do (
    if %%i==10 (
        if %%j==0 (
            if %%k geq 22000 (
                echo Detected Windows 11
                regedit /s "%main_dir%\win11-disable-automatic-updates.reg"
                goto :end
            )
        )
    )
)

:end
echo Finished applying settings
endlocal 
