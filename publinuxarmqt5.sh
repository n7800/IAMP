rm miaxstub
rm miacstub
rm miacstubl
rm miaxstubl
rm miampl
rm miauix
rm miabuild
rm mpax
rm miamp
rm trans/mTranslator
mkdir -p linuxarm   
mkdir -p linux
mkdir -p bin/LINUX/trans
mkdir -p uibin/LINUX
mkdir -p bxbin/LINUX
mkdir -p pxbin/LINUX
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Guiless miaxstub.lpr -B --ws=qt5
strip ./miaxstub
cp ./miaxstub ./miacstub
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=LicensedGuiless miaxstub.lpr -B --ws=qt5
strip ./miaxstub
cp ./miaxstub ./miacstubl
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Licensed miaxstub.lpr -B --ws=qt5
strip ./miaxstub
cp ./miaxstub ./miaxstubl
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Licensed miamp.lpr -B --ws=qt5
strip ./miamp
cp ./miamp ./miampl
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Linux miaxstub.lpr -B --ws=qt5
strip ./miaxstub
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Linux miauix.lpr -B --ws=qt5
strip ./miauix
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Linux miaxbuild.lpr -B --ws=qt5
strip ./miaxbuild
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Linux miamp.lpr -B --ws=qt5
strip ./miamp
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Linux mpax.lpr -B --ws=qt5
strip ./mpax
~/Downloads/fpcupdeluxe/lazarus/lazbuild --build-mode=Linux trans/mTranslator.lpr -B --ws=qt5
strip trans/mTranslator
cp 7z2201-linux-arm64/7zzs ./linux/miax.lib
cp ./linux\ arm\ stub\ for\ cute/dependentx ./linuxarm/dependentx
cp ./linux\ arm\ stub\ for\ cute/dependenty ./linuxarm/dependenty
cp ./linuxarm/dependentx ./linux/dependentx
cp ./linuxarm/dependenty ./linux/dependenty
cp ./libqt5pas_1_2_16-4_arm64/libQt5Pas.so.1.2.16 ./libQt5Pas.so.1
chmod 777 ./miaxstub
chmod 777 ./miacstub
chmod 777 ./miacstubl
chmod 777 ./miaxstubl
chmod 777 ./miampl
chmod 777 ./miamp
chmod 777 ./miaxbuild
chmod 777 ./miauix
chmod 777 ./mpax
chmod 777 ./linux/miax.lib
chmod 777 ./linux/dependentx
chmod 777 ./linux/dependenty
chmod 777 ./trans/mTranslator
cp ./linux/miax.lib .
cp miax.lib ./bin/LINUX/miax.lib
cp ./linux/dependentx .
cp ./linux/dependenty .
cp ./miaxstub ./bin/LINUX/miaxstub
cp ./miacstub ./bin/LINUX/miacstub
cp ./miauix ./uibin/LINUX/miauix
cp ./miamp ./bin/LINUX/miamp
cp ./miaxstub ./linux/miaxstub
cp ./miacstub ./linux/miacstub
cp ./miaxbuild ./bxbin/LINUX/miaxbuild
cp ./mpax ./pxbin/LINUX/mpax
cp ./trans/mTranslator ./bin/LINUX/trans/mTranslator
chmod 777 ./linux/miaxstub
chmod 777 ./linux/miacstub
chmod 777 ./bin/LINUX/miamp
chmod 777 ./bin/LINUX/miax.lib
chmod 777 ./bin/LINUX/miaxstub
chmod 777 ./bin/LINUX/miacstub
chmod 777 ./uibin/LINUX/miauix
chmod 777 ./bxbin/LINUX/miaxbuild
chmod 777 ./pxbin/LINUX/mpax
chmod 777 ./bin/LINUX/trans/mTranslator
rm -R ./unlic
mkdir ./unlic
cp -R ./linux ./unlic/linux
cp ./miaxstubl ./linux/miaxstub
cp ./miacstubl ./linux/miacstub
