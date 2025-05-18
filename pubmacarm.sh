find . -name '.DS_Store' -type f -delete
rm -r ~/fpcupdeluxe/fpc/units/aarch64-darwin/openssl
rm -r ~/fpcupdeluxe/fpc/units/aarch64-darwin/fcl-net
cp ./patch/* ./
rm miamp.app/Contents/MacOS/miamp
rm miauix.app/Contents/MacOS/miauix
rm miaxstub.app/Contents/MacOS/miaxstub
rm miaxbuild.app/Contents/MacOS/miaxbuild
rm mpax.app/Contents/MacOS/mpax
rm trans/mTranslator.app/Contents/MacOS/mTranslator
mkdir -p bin/macos/trans
mkdir -p macos
mkdir -p bxbin/macos
mkdir -p uxbin/macos
mkdir -p pxbin/macos
~/fpcupdeluxe/lazarus/lazbuild --build-mode=Guiless miaxstub.lpr --build-all
strip ./miaxstub
cp ./miaxstub ./miacstub
chmod 777 ./miacstub
~/fpcupdeluxe/lazarus/lazbuild --build-mode=LicensedGuiless miaxstub.lpr --build-all
strip ./miaxstub
cp ./miaxstub ./miacstubl
chmod 777 ./miacstubl
~/fpcupdeluxe/lazarus/lazbuild --build-mode=Licensed miaxstub.lpr --build-all
strip ./miaxstub
cp ./miaxstub ./miaxstubl
chmod 777 ./miaxstubl
~/fpcupdeluxe/lazarus/lazbuild miamp.lpr --build-mode=Licensed --build-all
strip ./miaxstub
cp ./miamp ./miampl
chmod 777 ./miampl
~/fpcupdeluxe/lazarus/lazbuild miaxstub.lpr --build-all
strip ./miaxstub
~/fpcupdeluxe/lazarus/lazbuild miauix.lpr --build-all
strip ./miauix
~/fpcupdeluxe/lazarus/lazbuild miaxbuild.lpr --build-all
strip ./miaxbuild
~/fpcupdeluxe/lazarus/lazbuild miamp.lpr --build-all
strip ./miamp
~/fpcupdeluxe/lazarus/lazbuild mpax.lpr --build-all
strip ./mpax
~/fpcupdeluxe/lazarus/lazbuild trans/mTranslator.lpr --build-all
strip trans/mTranslator
cp 7z2301-mac/7zz ./macos/miax.lib
cp ./macos/miax.lib ./bin/macos/miax.lib
chmod 777 ./miaxstub
chmod u-s ./miaxstub
chmod 777 ./miacstub
chmod u-s ./miacstub
chmod 777 ./miacstubl
chmod u-s ./miacstubl
chmod 777 ./miaxstubl
chmod u-s ./miaxstubl
chmod 777 ./miamp
chmod 777 ./miampl
chmod 777 ./miaxbuild
chmod 777 ./miauix
chmod 777 ./mpax
chmod 777 ./trans/mTranslator
chmod 777 ./macos/miax.lib
cp ./macos/miax.lib .
chmod 777 ./miax.lib
# chmod 777 ./miaxex.lib
cp ./miaxstub ./bin/macos/miaxstub.app/Contents/MacOS/miaxstub
cp ./miaxstub ./bin/macos/miaxstub
cp ./miacstub ./bin/macos/miacstub
cp ./miauix ./uibin/macos/miauix.app/Contents/MacOS/miauix
cp ./miamp ./bin/macos/miamp.app/Contents/MacOS/miamp
cp ./miaxstub ./macos/miaxstub.app/Contents/MacOS/miaxstub
cp ./miaxstub ./macos/miaxstub
cp ./miacstub ./macos/miacstub
cp ./miaxbuild ./bxbin/macos/miaxbuild
cp ./mpax ./pxbin/macos/mpax.app/Contents/MacOS/mpax
cp ./trans/mTranslator ./bin/macos/trans/mTranslator.app/Contents/MacOS/mTranslator
chmod 777 ./macos/miaxstub.app/Contents/MacOS/miaxstub
chmod u-s ./macos/miaxstub.app/Contents/MacOS/miaxstub
chmod 777 ./bin/macos/miamp.app/Contents/MacOS/miamp
chmod 777 ./pxbin/macos/mpax.app/Contents/MacOS/mpax
chmod 777 ./bin/macos/miax.lib
chmod 777 ./bin/macos/miaxstub
chmod u-s ./bin/macos/miaxstub
chmod 777 ./bin/macos/miacstub
chmod u-s ./bin/macos/miacstub
chmod 777 ./bin/macos/miaxstub.app/Contents/MacOS/miaxstub
chmod u-s ./bin/macos/miaxstub.app/Contents/MacOS/miaxstub
chmod 777 ./uibin/macos/miauix.app/Contents/MacOS/miauix
chmod 777 ./macos/miaxstub
chmod 777 ./macos/miacstub
chmod 777 ./bxbin/macos/miaxbuild
chmod 777 ./pxbin/macos/mpax.app/Contents/MacOS/mpax
chmod 777 ./bin/macos/trans/mTranslator.app/Contents/MacOS/mTranslator
rm -R ./unlic
ditto ./macos ./unlic/macos
cp ./miaxstubl ./macos/miaxstub
cp ./miacstubl ./macos/miacstub
