@echo off
setlocal EnableDelayedExpansion

set "ARGS="

:loop
if "%~1"=="" goto done

set "arg=%~1"

if /I "!arg:--target=!"=="!arg!" (
    set "ARGS=!ARGS! "!arg!""
)

shift
goto loop

:done

zig cc -target x86_64-windows-gnu %ARGS%
