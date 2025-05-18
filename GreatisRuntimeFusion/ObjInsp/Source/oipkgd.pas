{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit OIPKGD;

{$warn 5023 off : no warning about unused units}
interface

uses
  InspReg, OIDsgn, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('InspReg', @InspReg.Register);
end;

initialization
  RegisterPackage('OIPKGD', @Register);
end.
