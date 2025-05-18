find . -name '*.fpc' -type f -delete
rm -R ./lib
rm -R ./GreatisRuntimeFusion/FormDes/Source/lib
rm -R ./GreatisRuntimeFusion/ObjInsp/Source/lib
rm -R ./GreatisRuntimeFusion/RunFus/Source/lib
find . -name '.DS_Store' -type f -delete
find . -name 'link*.res' -type f -delete
rm fphttpclient.pp
rm fpopenssl.pp
rm fpsock.pp
rm cnetdb.pp
rm httpdefs.pp
rm httpprotocol.pp
rm httpsvlt.pp
rm netdb.pp
rm ns_url_request_ex.pas
rm openssl.pas
rm opensslsockets.pp
rm resolve.pp
rm sslbase.pp
rm sslsockets.pp
rm ssockets.pp
