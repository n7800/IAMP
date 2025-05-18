//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("OIPKG5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("InspReg.pas");
USERES("InspReg.dcr");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
