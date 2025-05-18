{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit OIPKG;

{$warn 5023 off : no warning about unused units}
interface

uses
  AppInsp, CollEdit, CompInsp, DBInspct, IniInsp, InspCtrl, ListView, 
  MenuEdit, PicsEdit, PropEdit, PropIntf, PropList, SColInsp, StrsEdit, 
  TreeInsp, TreeView, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('OIPKG', @Register);
end.
