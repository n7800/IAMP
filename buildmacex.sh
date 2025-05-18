rm -r iamp/Release
./miaxbuild iamp/iamp.mprx /b=1
./miaxbuild iamp/iamp.mprx /b=2
rm -r iamp/ReleaseGui
mv iamp/Release iamp/ReleaseGui
./miaxbuild iamp/iamp.mprx /b=1 NOGUI=TRUE
./miaxbuild iamp/iamp.mprx /b=2 NOGUI=TRUE
rm -r iamp/ReleaseNoGui
mv iamp/Release iamp/ReleaseNoGui
