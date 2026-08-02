@echo off
setlocal

set "BMVIM_SCRIPT_DIR=%~dp0"
set "BMVIM_SCRIPT_DIR=%BMVIM_SCRIPT_DIR:~0,-1%"

for %%I in ("%BMVIM_SCRIPT_DIR%\..") do set "BMVIM_ROOT_DIR=%%~fI"

set "BMVIM_DATA_PATH=%USERPROFILE%\.banhmivim\data"
set "BMVIM_STATE_PATH=%USERPROFILE%\.banhmivim\state"
set "BMVIM_CACHE_PATH=%USERPROFILE%\.banhmivim\cache"

set "NVIM_APPNAME=banhmivim"
set "XDG_CONFIG_HOME=%BMVIM_ROOT_DIR%\config"
set "XDG_DATA_HOME=%BMVIM_DATA_PATH%"
set "XDG_STATE_HOME=%BMVIM_STATE_PATH%"
set "XDG_CACHE_HOME=%BMVIM_CACHE_PATH%"

nvim %*

endlocal
