@echo off

SET CDP="%CD%"


%CDP%\adb\adb start-server
echo Connect your Quest and allow USB debugging
echo (You need to enable Developer Mode)
pause

cls
TITLE QuestCraft Installer

GOTO MENU

:MENU

ECHO ----------------------------------------------------
echo ------------ ==QuestCraft Installer 1.0== ----------
echo               .......................              
echo          .:7LJsJv7r7sUjYvLirrv7vsJsjsJv7ri.        
echo        :rr777rrirEDP77v7v7YYJiiiiiir7r77vvL7i      
echo      :v7:iiriri:igDdiriv777Yv::::::ii:7usri7vY:    
echo     qBBM. .iririrbEX::iPgbi:i::::::..iBBBPrrrrsE   
echo    gBBBBqJuXJLrvjBQQ1IIBBBJjJIISsYvY7ZBBBBSXXPZBB  
echo   BQBBBBBQBBBBBBBBBBBBBBBBBQBQBBBBBQBBBQBBBBBBBQBd 
echo   BBQBQBBBBBBRi                     .iqBBBBBQBBBBB 
echo  rBBBBBBBBBB.                          rBBBQBBBQBB 
echo  vQBBBQBBBBI                        rBB BBBBBBBBBB.
echo  7BBBBBBBBBB                       ZBQBBBBBBBQBBBB.
echo  .QBBBBBBBBBB1.                    BQBBBQBQBBBBBQB 
echo   BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBQBBBP 
echo   :BBBBBBBBBBBBBQBBBBBBBBBBBQBBBBBBBBBBBBBBBQBQBQ
echo    7BBBBBBBQBBBQBBBBBBBBBQBBBQBBBBBBBBBBBBBBBBBBBB 
echo     :BBBQBBBQBQBQBBBBBBBBBBBBBBBBBBBBBBBBBBBBBQBBB:
echo       2BBBBBBBBBBQBBBBBBBBBQBBBBBBBBBBBBBBBBBQBBBQ 
echo         rRBBBBBBBBBBBBBBBBQBBBBBBBQBBBBB BQBBBQBBS 
echo            .rjPEMgRMRgRMQgRgMgMDgZggZKui   LgQMj.  
ECHO ----------------------------------------------------

echo.   
echo !YOU NEED TO DOWNLOAD LATEST VERSION ON THE FIRST RUN!
echo.                                         
echo 1) Install QuestCraft
echo 2) Download latest version
echo 3) Exit

CHOICE /N /C 123 /M "Pick a number:"%1

IF ERRORLEVEL 3 GOTO EXIT
IF ERRORLEVEL 2 GOTO DOWNLOAD
IF ERRORLEVEL 1 GOTO INSTALL


:INSTALL
%CDP%\adb\adb install -g %CDP%\source\app-debug.apk
%CDP%\adb\adb push %CDP%\source\Android /sdcard/
echo Done
pause
cls
GOTO MENU



:DOWNLOAD
DEL /S /Q %CDP%\source\* >nul
wget -P %CDP%\source\ -q --show-progress https://github.com/QuestCraftPlusPlus/QuestCraft/releases/latest/download/app-debug.apk
wget -P %CDP%\source\ -q --show-progress https://github.com/QuestCraftPlusPlus/QuestCraft/releases/latest/download/extracttoroot.zip

Call :UnZipFile "%CD%\source\" "%CD%\source\extracttoroot.zip"

DEL /S /Q %CDP%\source\extracttoroot.zip >nul

echo Done
pause
cls
GOTO MENU



:EXIT
cls
echo Exiting...
%CDP%\adb\adb kill-server
pause

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
