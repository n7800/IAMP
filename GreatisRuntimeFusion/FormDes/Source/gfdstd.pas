{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit GFDSTD;

{$warn 5023 off : no warning about unused units}
interface

uses
  CDReg, FDReg, FDDsgn, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('CDReg', @CDReg.Register);
  RegisterUnit('FDReg', @FDReg.Register);
end;

initialization
  RegisterPackage('GFDSTD', @Register);
end.
