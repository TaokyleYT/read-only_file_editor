@echo off
@REM                author: Taokyle
@REM    a tool to bypass registry configurations where
@REM  viewing/editing specific directory/file is forbidden
@REM        please credit before distributing forks

@REM set the below variable to an always available temporary folder
set tempdir=D:\temp\file_editor

@REM creates temp dir
if not exist D:\temp\file_editor (
  mkdir D:\temp\file_editor
  attrib -R D:\temp\file_editor
)

@REM menu
echo 1 = search file
echo 2 = edit file
echo 3 = copy dir to dir
set /P mode="mode: "
if %mode%==1 goto mode1
if %mode%==2 goto mode2
if %mode%==3 goto mode3

@REM if none of the mode are selected
echo bruh enter "1", "2" or "3" not "%mode%"
goto commonexit

@REM mode 1
:mode1
set /P target="file name query: "
set originaldir=%cd%
@REM query all found drives of the inputed file/dir
for /F "skip=1" %%D in ('wmic LogicalDisk WHERE DriveType^=3 GET DeviceID') do (
    for /F %%C in ("%%D") do (
        cd %%D\
        dir /s/w/p/d *%target%*
    )
)
cd %originaldir%
goto commonexit

@REM mode 2
:mode2
set /P target="filename: "
@REM removes extra colons (from drive name) and quotations
set targetexc=%target::=%
set targetvalid=%targetexc:"=%

if not EXIST %target% (
  echo bro %target% doesn't even exist
  goto commonexit
)
if exist %target%\* (
  echo bro %target% is a directory
  goto commonexit
)

@REM recreates forbidden file system inside temp folder
if not exist "D:\temp\file_editor\%targetvalid%\.." (
  mkdir "D:\temp\file_editor\%targetvalid%\.."
  attrib "D:\temp\file_editor\%targetvalid%\.."
)
@REM copies target to temp, edits temp, and replace temp back to target to achieve the bypass
xcopy /V/C/H/R %target% "D:\temp\file_editor\%targetvalid%"
notepad.exe "D:\temp\file_editor\%targetvalid%"
xcopy /V/C/H/R "D:\temp\file_editor\%targetvalid%" %target%
goto commonexit

@REM mode 3
:mode3
set /P target="target directory path: "
set /P ret="to: "
set ret=%retOR%ENDING
set ret=%ret:^"=%
set targetexc=%target::=%
set targetvalid=%targetexc:^"=%
if %ret%==ENDING ( set ret="D:\temp\file_editor\%targetvalid%\"ENDING )
set ret=%ret:~0,-7%

if not EXIST %target% (
  echo bro %target% doesn't even exist
  goto commonexit
)
if not EXIST %ret% ( mkdir %ret% )

@REM same as mode 2, but require manual replace later to allow advance manipulations before putting back
xcopy /V/C/H/R/E %target% %ret%
explorer.exe "%ret%"
echo copied contents in %target% to %ret%
echo to replace original content, copy content from %ret% to %target% instead
goto commonexit

@REM end
:commonexit
echo:
echo:
echo OPERATION COMPLETED
PAUSE
