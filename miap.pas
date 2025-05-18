{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit miap;

{$warn 5023 off : no warning about unused units}
interface

uses
  FileLbl, WiseListBox, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('FileLbl', @FileLbl.Register);
  RegisterUnit('WiseListBox', @WiseListBox.Register);
end;

initialization
  RegisterPackage('miap', @Register);
end.
