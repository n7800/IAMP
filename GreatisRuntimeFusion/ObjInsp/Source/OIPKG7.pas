{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit OIPKG7;

{$warn 5023 off : no warning about unused units}
interface

uses
  InspReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('InspReg', @InspReg.Register);
end;

initialization
  RegisterPackage('OIPKG7', @Register);
end.
