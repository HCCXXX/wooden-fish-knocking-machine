set PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x86;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE;C:\Program Files (x86)\Windows Kits\10\bin;D:\Program Files\DMDALL\D2_108_1\dmd2\windows\bin;%PATH%
set DMD_LIB=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22000.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64
set VCINSTALLDIR=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\
set VCTOOLSINSTALLDIR=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\
set VSINSTALLDIR=C:\Program Files\Microsoft Visual Studio\2022\Community\
set WindowsSdkDir=C:\Program Files (x86)\Windows Kits\10\
set WindowsSdkVersion=10.0.22000.0
set UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
set UCRTVersion=10.0.22000.0

echo my_utils\raylibx\draw_unitext.d >x64\Debug\beating_the_wooden_drum.build.rsp
echo my_utils\my_tools.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylib\binding.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylib\package.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylib\raylib_types.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylib\raymath.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylib\raymathext.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylib\reasings.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylib\rlgl.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo beating_the_wooden_drum.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo controls_test_suite.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raygui.d >>x64\Debug\beating_the_wooden_drum.build.rsp
echo raylibdll.lib >>x64\Debug\beating_the_wooden_drum.build.rsp

"D:\Program Files (x86)\VisualD\pipedmd.exe" -deps x64\Debug\beating_the_wooden_drum.dep dmd -debug -m64 -g -gf -X -Xf"x64\Debug\beating_the_wooden_drum.json" -c -of"x64\Debug\beating_the_wooden_drum.obj" @x64\Debug\beating_the_wooden_drum.build.rsp
if %errorlevel% neq 0 goto reportError

set LIB=D:\Program Files\DMDALL\D2_108_1\dmd2\windows\bin\..\lib64
echo. > F:\VISUAL~2\DPROJE~1\BEATIN~1\BEATIN~1\x64\Debug\BEATIN~1.RSP
echo "x64\Debug\beating_the_wooden_drum.obj" /OUT:"x64\Debug\beating_the_wooden_drum.exe" raylibdll.lib  >> F:\VISUAL~2\DPROJE~1\BEATIN~1\BEATIN~1\x64\Debug\BEATIN~1.RSP
echo user32.lib  >> F:\VISUAL~2\DPROJE~1\BEATIN~1\BEATIN~1\x64\Debug\BEATIN~1.RSP
echo kernel32.lib  >> F:\VISUAL~2\DPROJE~1\BEATIN~1\BEATIN~1\x64\Debug\BEATIN~1.RSP
echo legacy_stdio_definitions.lib /LIBPATH:"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\lib\x64" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22000.0\ucrt\x64" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x64" /DEBUG /PDB:"x64\Debug\beating_the_wooden_drum.pdb" /INCREMENTAL:NO /NOLOGO /NODEFAULTLIB:libcmt libcmtd.lib /SUBSYSTEM:CONSOLE >> F:\VISUAL~2\DPROJE~1\BEATIN~1\BEATIN~1\x64\Debug\BEATIN~1.RSP
"D:\Program Files (x86)\VisualD\mb2utf16.exe" F:\VISUAL~2\DPROJE~1\BEATIN~1\BEATIN~1\x64\Debug\BEATIN~1.RSP

"D:\Program Files (x86)\VisualD\pipedmd.exe" -msmode -deps x64\Debug\beating_the_wooden_drum.lnkdep "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.35.32215\bin\HostX86\x86\link.exe" @F:\VISUAL~2\DPROJE~1\BEATIN~1\BEATIN~1\x64\Debug\BEATIN~1.RSP
if %errorlevel% neq 0 goto reportError
if not exist "x64\Debug\beating_the_wooden_drum.exe" (echo "x64\Debug\beating_the_wooden_drum.exe" not created! && goto reportError)

goto noError

:reportError
set ERR=%ERRORLEVEL%
set DISPERR=%ERR%
if %ERR% LSS -65535 then DISPERR=0x%=EXITCODE%
echo Building x64\Debug\beating_the_wooden_drum.exe failed (error code %DISPERR%)!
exit /B %ERR%

:noError
