{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RFPKG;

{$warn 5023 off : no warning about unused units}
interface

uses
  RFReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('RFReg', @RFReg.Register);
end;

initialization
  RegisterPackage('RFPKG', @Register);
end.
