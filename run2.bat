@echo off& setlocal& set x86=& set w32=system32
rem http://paulhoule.com/msvc14/copymsvc14.bat    May 28, 2016
if "%~1"=="" echo Copies minimal files to run CL 14.28 (32 and 64 bit)
if "%~1"=="" echo First arg must be target directory& goto :eof

if exist "c:\Program Files (x86)\." set "x86= (x86)"& set w32=syswow64
dir "c:\Program Files%x86%\"
set vs1=c:\Program Files%x86%\Microsoft Visual Studio 14.28
dir "%vs1%"
set vs2=c:\Program Files%x86%\Windows Kits\10
dir "%vs2%"
set vs3=c:\Program Files%x86%\Windows Kits\8.1
dir "%vs3%"

set emsg=Can't find src dir - run on system where compiler is installed
if exist "%vs1%" if exist "%vs2%" if exist "%vs3%" set emsg=
if not "%emsg%"=="" echo %emsg%& goto :eof

if exist "%~1" echo dir "%~1" exists... delete it first& goto :eof

echo Copying binaries (bin, sdk\bin)..........
xcopy /i "%vs1%\VC\bin" "%~1\bin" >nul
xcopy /i "%vs1%\VC\bin\1033" "%~1\bin\1033" >nul
xcopy /i "%vs1%\VC\bin\x86_amd64" "%~1\bin\x86_amd64" >nul
xcopy /i "%vs1%\VC\bin\x86_amd64\1033" "%~1\bin\x86_amd64\1033" >nul
xcopy /i "%vs3%\bin\x86" "%~1\sdk\bin" >nul
xcopy /i "%vs3%\bin\x86\1033" "%~1\sdk\bin\1033" >nul
xcopy /i "%vs3%\bin\x64" "%~1\sdk\bin\x64" >nul
xcopy /i "%vs3%\bin\x64\1033" "%~1\sdk\bin\x64\1033" >nul
xcopy c:\windows\%w32%\api-ms-win-*.dll "%~1\bin" >nul
xcopy c:\windows\%w32%\*140*.dll "%~1\bin" >nul
xcopy c:\windows\%w32%\ucrtbase*.dll "%~1\bin" >nul
xcopy c:\windows\%w32%\VsGraphicsHelper.dll "%~1\bin" >nul

echo Copying includes (include, sdk\include)..........
xcopy /i "%vs1%\vc\include" "%~1\include" /s >nul
xcopy /i "%vs2%\include\10.0.10150.0\ucrt" "%~1\include" /s >nul
xcopy /i "%vs3%\include\shared" "%~1\sdk\include" /s >nul
xcopy /i "%vs3%\include\um" "%~1\sdk\include" /s >nul

echo Copying libraries (lib, sdk\lib)..........
xcopy /i "%vs1%\VC\lib" "%~1\lib" >nul
xcopy /i "%vs2%\lib\10.0.10150.0\ucrt\x86" "%~1\lib" >nul
xcopy /i "%vs3%\lib\winv6.3\um\x86" "%~1\sdk\lib" >nul
xcopy /i "%vs1%\VC\lib\amd64" "%~1\lib\amd64" >nul
xcopy /i "%vs2%\lib\10.0.10150.0\ucrt\x64" "%~1\lib\amd64" >nul
xcopy /i "%vs3%\lib\winv6.3\um\x64" "%~1\sdk\lib\x64" >nul
