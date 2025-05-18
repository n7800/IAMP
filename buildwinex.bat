rmdir iamp\release /s /q
miaxbuild iamp\iamp.mprx /b=1
miaxbuild iamp\iamp.mprx /b=2
rmdir iamp\ReleaseGui /s /q
move iamp\Release iamp\ReleaseGui
miaxbuild iamp\iamp.mprx /b=1 NOGUI=TRUE
miaxbuild iamp\iamp.mprx /b=2 NOGUI=TRUE
rmdir iamp\ReleaseNoGui /s /q
move iamp\Release iamp\ReleaseNoGui

