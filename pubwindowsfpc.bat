del miaxstub.exe
del miacstub.exe
del miacstubl.exe
del miaxstubl.exe
del miampl.exe
del miauix.exe
del miaxbuild.exe
del mpax.exe
del miamp.exe
del trans\mTranslator.exe
md bin\windows\trans
md uibin\windows
md bxbin\windows
md pxbin\windows
c:\fpcupdeluxe\lazarus\lazbuild --build-mode=Guiless miaxstub.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miaxstub.exe
copy .\miaxstub.exe .\miacstub.exe /y
c:\fpcupdeluxe\lazarus\lazbuild --build-mode=LicensedGuiless miaxstub.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miaxstub.exe
copy .\miaxstub.exe .\miacstubl.exe /y
c:\fpcupdeluxe\lazarus\lazbuild --build-mode=Licensed miaxstub.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miaxstub.exe
copy .\miaxstub.exe .\miaxstubl.exe /y
c:\fpcupdeluxe\lazarus\lazbuild --build-mode=Licensed miamp.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miamp.exe
copy .\miamp.exe .\miampl.exe /y
c:\fpcupdeluxe\lazarus\lazbuild miaxstub.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miaxstub.exe
c:\fpcupdeluxe\lazarus\lazbuild miauix.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miauix.exe
c:\fpcupdeluxe\lazarus\lazbuild miaxbuild.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miaxbuild.exe
c:\fpcupdeluxe\lazarus\lazbuild miamp.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip miamp.exe
c:\fpcupdeluxe\lazarus\lazbuild mpax.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip mpax.exe
c:\fpcupdeluxe\lazarus\lazbuild trans\mTranslator.lpr -B
c:\fpcupdeluxe\fpc\bin\i386-win32\strip trans\mTranslator.exe
copy .\windows\miax.lib . /y
copy .\windows\dependentx.exe . /y
copy .\miaxstub.exe .\bin\windows\miaxstub.exe /y
copy .\miacstub.exe .\bin\windows\miacstub.exe /y
copy .\miauix.exe .\uibin\windows\miauix.exe /y
copy .\miamp.exe .\bin\windows\miamp.exe /y
copy .\miaxstub.exe .\windows\miaxstub.exe /y
copy .\miacstub.exe .\windows\miacstub.exe /y
copy .\miaxbuild.exe .\bxbin\windows\miaxbuild.exe /y
copy .\mpax.exe .\pxbin\windows\mpax.exe /y
copy .\trans\mTranslator.exe .\bin\windows\trans\mTranslator.exe /y
rd /s /q .\unlic
xcopy .\windows .\unlic\windows /e /h /c /i
copy .\miaxstubl.exe .\windows\miaxstub.exe /y
copy .\miacstubl.exe .\windows\miacstub.exe /y
