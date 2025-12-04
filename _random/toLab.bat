:: Set up a couple of variables.
:: If this is your first time running this, you probably want to set HELP and SETUP to 1.
@set HELP=0
@set SETUP=0
@set LOCALBASEDIR=%USERPROFILE%\dotfiles
@set REMOTEBASEDIR=Documents/%USERNAME%
@set SCRIPT=%LOCALBASEDIR%\to.scr
@set REMOTE=%REMOTEBASEDIR%/_fromPC
@set LOCAL=%LOCALBASEDIR%\toLab
@if %SETUP%==1 @(@echo NOTE: Setting up the remote directories...)

:: Generate the script for the SFTP console to run
@(
   @if %SETUP%==1 @(@echo -mkdir %REMOTEBASEDIR%)
   @if %SETUP%==1 @(@echo -mkdir %REMOTE%)
   @echo cd %REMOTE%
   @echo put -R %LOCAL%
   @echo quit
) > %SCRIPT%

:: Call the menu batch script.
@if %HELP%==1 @(@echo NOTE: Put all documents recursively from '%LOCAL%')
@if %HELP%==1 @(@echo       Onto remote dir '%%USERPROFILE%%/%REMOTE%')
@IF NOT "%~1"=="" @(@call :menu %SCRIPT% %1)
@if     "%~1"=="" @(@call :menu %SCRIPT%)
@goto :eof

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutines                                                           ::
:: Note that this should be identical to the subroutines in fromLab.bat  ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Create a menu to select the correct testbench.
:menu
   @IF NOT "%~2"=="" @(@set id=%2)
   @if     "%~2"=="" @(@set /P id=Select Lab PC - 0: TB-Alpha. 1: TB-ELF1. 2: TB-ELF2. 3: TB-ELF3. 4+: All TBs: )
   @if %HELP%==1 @(@echo NOTE: To Copy/Paste the password: highlight it with the mouse,)
   @if %HELP%==1 @(@echo       then press Ctrl-Insert, followed by Shift-Insert)
   @if %id% ==  0 @( @call :startSFTP fn-sd4-edev-001  PC403591.US.ASML.COM %1 .4xb%%%%R4k+G]v    )
   @if %id% ==  1 @( @call :startSFTP fn-elf-edevlab-1 PC403620.US.ASML.COM %1 SDfwTBone1!1!      )
   @if %id% ==  2 @( @call :startSFTP fn-elf-edevlab-2 PC403622.US.ASML.COM %1 SDfwTBtwo2@2@      )
   @if %id% ==  3 @( @call :startSFTP fn-elf-edevlab-3 PC403619.US.ASML.COM %1 SDfwTBthree3#3#    )
   @if %id% gtr 3 @(
      @echo %id%: Selecting all TBs!
      @call :startSFTP fn-sd4-edev-001  PC403591.US.ASML.COM %1 .4xb%%%%R4k+G]v
      @call :startSFTP fn-elf-edevlab-1 PC403620.US.ASML.COM %1 SDfwTBone1!1!
      @call :startSFTP fn-elf-edevlab-2 PC403622.US.ASML.COM %1 SDfwTBtwo2@2@
      @call :startSFTP fn-elf-edevlab-3 PC403619.US.ASML.COM %1 SDfwTBthree3#3#
    )
   @del %1
   @pause
   @goto :eof

:: If the search for the hw_server doesn't return empty, then echo the PID.
:startSFTP
   @echo Password: %4
   @sftp -P 60022 %1@%2 < %3
