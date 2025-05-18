{
Business Source License 1.1

Parameters

Licensor:             InstallAware Software

Licensed Work:        InstallAware (Multi Platform) 2025
                      The Licensed Work is (C) 1996-2025 InstallAware Software

Additional Use Grant: You may make use of the Licensed Work, provided that
                      you may not use the Licensed Work at a Sanctioned Entity.

                      Sanctioned Entities are individuals, organizations, or
                      legal persons who have been formally designated by the
                      Licensor as having materially violated intellectual
                      property rights, breached license terms, or engaged in
                      unethical exploitation of (open-source) technologies,
                      including this software.

                      As of the first publicly available distribution of this
                      specific version of the Licensed Work under this
                      License, the following are designated as Sanctioned
                      Entities:

                      Future US, Inc.
                      L3Harris Technologies, Inc.
                      Wolters Kluwer N.V.

                      This includes any individuals, organizations, or
                      entities, acting in any capacity and at any time,
                      either directly or indirectly, on behalf of or under
                      the control and influence of the Sanctioned Entities,
                      such as (but not only) current and future:

                      Subsidiaries
                      Affiliates
                      Contractors
                      Agents
                      Employees
                      Parent companies
                      Acquisitions
                      Assignees
                      Joint Ventures
                      Franchisees
                      
                      Entities may petition the Licensor for removal from the
                      Sanctioned Entities list. Any such removal is at the
                      sole discretion of the Licensor and must be issued in a
                      public update to the Licensed Work under this License
                      as documented in this Additional Use Grant parameter.

Change Date:          2029-05-19

Change License:       GNU Affero General Public License version 3 (AGPLv3)

For information about alternative licensing arrangements for the Software,
please visit: https://www.installaware.com/

Notice

The Business Source License (this document, or the “License”) is not an Open
Source license. However, the Licensed Work will eventually be made available
under an Open Source License, as stated in this License.

License text copyright (c) 2017 MariaDB Corporation Ab, All Rights Reserved.
“Business Source License” is a trademark of MariaDB Corporation Ab.

Terms

The Licensor hereby grants you the right to copy, modify, create derivative
works, redistribute, and make non-production use of the Licensed Work. The
Licensor may make an Additional Use Grant, above, permitting limited
production use.

Effective on the Change Date, or the fourth anniversary of the first publicly
available distribution of a specific version of the Licensed Work under this
License, whichever comes first, the Licensor hereby grants you rights under
the terms of the Change License, and the rights granted in the paragraph
above terminate.

If your use of the Licensed Work does not comply with the requirements
currently in effect as described in this License, you must purchase a
commercial license from the Licensor, its affiliated entities, or authorized
resellers, or you must refrain from using the Licensed Work.

All copies of the original and modified Licensed Work, and derivative works
of the Licensed Work, are subject to this License. This License applies
separately for each version of the Licensed Work and the Change Date may vary
for each version of the Licensed Work released by Licensor.

You must conspicuously display this License on each original or modified copy
of the Licensed Work. If you receive the Licensed Work in original or
modified form from a third party, the terms and conditions set forth in this
License apply to your use of that work.

Any use of the Licensed Work in violation of this License will automatically
terminate your rights under this License for the current and all other
versions of the Licensed Work.

This License does not grant you any right in any trademark or logo of
Licensor or its affiliates (provided that you may use a trademark or logo of
Licensor as expressly required by this License).

TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE LICENSED WORK IS PROVIDED ON
AN “AS IS” BASIS. LICENSOR HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS,
EXPRESS OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND
TITLE.

MariaDB hereby grants you permission to use this License’s text to license
your works, and to refer to it using the trademark “Business Source License”,
as long as you comply with the Covenants of Licensor below.

Covenants of Licensor

In consideration of the right to use this License’s text and the “Business
Source License” name and trademark, Licensor covenants to MariaDB, and to all
other recipients of the licensed work to be provided by Licensor:

1. To specify as the Change License the GPL Version 2.0 or any later version,
   or a license that is compatible with GPL Version 2.0 or a later version,
   where “compatible” means that software provided under the Change License can
   be included in a program with software provided under GPL Version 2.0 or a
   later version. Licensor may specify additional Change Licenses without
   limitation.

2. To either: (a) specify an additional grant of rights to use that does not
   impose any additional restriction on the right granted in this License, as
   the Additional Use Grant; or (b) insert the text “None”.

3. To specify a Change Date.

4. Not to modify this License in any other way.
}
unit Design;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, Forms, SysUtils,
  Classes, Controls, LookUpStringList, StdCtrls, ExtCtrls, Dialogs,
  Menus, RunFus,
  actionseditor,
  dbpropedits,
  graphpropedits,
  idetextconverter,
  lazideintf,
  listviewpropedit,
  maskpropedit,
  propedits,
  treeviewpropedit, FDMain, IniFiles;

type

  TfrmDesign = class(TForm)
    cmpFormDesigner: TRFDesigner;
    procedure cmpFormDesignerLoadControl(Sender: TObject; TheControl: TControl;
      IniFile: TIniFile);
    procedure cmpFormDesignerPasteComponent(Sender: TObject;
      TheComponent: TComponent);
    procedure cmpFormDesignerMoveSizeControl(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerAddControl(Sender: TObject; TheControl: TControl);
    procedure cmpFormDesignerSaveControl(Sender: TObject; TheControl: TControl;
      IniFile: TIniFile);
    procedure FormShow(Sender: TObject);
    procedure cmpFormDesignerSelectControl(Sender: TObject;
      TheControl: TControl);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmpFormDesignerControlDblClick(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ShowYes(Sender: TObject);
    procedure ShowNo(Sender: TObject);
    procedure cmpFormDesignerChange(Sender: TObject);
    procedure cmpFormDesignerPlaceComponent(Sender: TObject;
      TheComponent: TComponent);
    procedure cmpFormDesignerReadError(Reader: TReader; const Message: string;
      var Handled: Boolean);
  private
    
    procedure UpdateInfo;
  public
    
    function AutoName(Control: TControl): Boolean;
  end;

var
  frmDesign: TfrmDesign;

implementation

uses FDCmpPal, OIForm, ToolForm, Rules;

{$R *.lfm}

procedure TfrmDesign.UpdateInfo;
begin
  
end;

function TfrmDesign.AutoName(Control: TControl): Boolean;
var
  i: Integer;
  CN: string;
begin
  Result:=False;
  if Assigned(Control) then
    with Control do
    begin
      if (Name='') or Assigned(Self.FindComponent(Name)) then
      begin
        CN:=Copy(ClassName,2,Pred(Length(ClassName)));
        for i:=1 to 32768 do
          if not Assigned(Self.FindComponent(CN+IntToStr(i))) then
          begin
            Name:=CN+IntToStr(i);
            Result:=True;
            Break;
          end;
      end;
    end;
end;

procedure TfrmDesign.FormShow(Sender: TObject);
begin
  cmpFormDesigner.Active:=True;
  with frmObjectInspector do
  begin
    cmbObjectInspector.Root:=Self;
    cmbObjectInspector.Instance:=Self;
    cmpObjectInspector.Root:=Self;
    cmpObjectInspector.Instance:=Self;
    Show;
  end;
end;

procedure TfrmDesign.cmpFormDesignerSelectControl(Sender: TObject;
  TheControl: TControl);
var
  E: Boolean;
  i: Integer;
begin
  
  if Assigned(TheControl) then
    {$IFDEF TFD1COMPATIBLE}
    frmToolForm.sbtLock.Down:=cmpFormDesigner.FixedControls.IndexOf(TheControl.Name)<>-1;
    {$ELSE}
    frmTooLForm.sbtLock.Down:=cmpFormDesigner.LockedControls.IndexOf(TheControl.Name)<>-1;
    {$ENDIF}
  UpdateInfo;
  E:=Assigned(cmpFormDesigner.Control);
  with frmToolForm do
  begin
    sbtLock.Enabled:=E;
    
    sbtDelete.Enabled:=E;
    mniLock.Enabled:=E;
    mniAlignToGrid.Enabled:=E;
    mniDelete.Enabled:=E;
    sbtCopy.Enabled:=E;
    sbtCut.Enabled:=E;
    mniCopy.Enabled:=E;
    mniCut.Enabled:=E;
  end;
end;

procedure TfrmDesign.FormActivate(Sender: TObject);
begin
  ActiveControl:=nil;
  
end;

procedure TfrmDesign.FormCreate(Sender: TObject);
begin
  cmpFormDesigner.PopupMenu:=frmToolForm.pmnMain;
end;

procedure TfrmDesign.cmpFormDesignerControlDblClick(Sender: TObject;
  TheControl: TControl);
begin
  if Assigned(TheControl) then
  begin
    
    Rules.SelItem := TheControl.Name;
    frmRules.ShowModal;
    ActiveControl:=nil;
  end;
end;

procedure TfrmDesign.cmpFormDesignerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  with frmToolForm do
    case Key of
      Ord('C'): if Shift=[ssCtrl] then eveCopy(nil);
      Ord('c'): if Shift=[ssCtrl] then eveCopy(nil);
      Ord('V'): if Shift=[ssCtrl] then evePaste(nil);
      Ord('v'): if Shift=[ssCtrl] then evePaste(nil);
      Ord('X'): if Shift=[ssCtrl] then eveCut(nil);
      Ord('x'): if Shift=[ssCtrl] then eveCut(nil);
      VK_INSERT:
        if Shift=[ssShift] then evePaste(nil)
        else
          if Shift=[ssCtrl] then eveCopy(nil);
      VK_DELETE:
        if Shift=[ssShift] then eveCut(nil)
        else
          if Shift=[] then eveDelete(nil);
    end;
end;

procedure TfrmDesign.ShowYes(Sender: TObject);
begin
  ShowMessage('YES');
end;

procedure TfrmDesign.ShowNo(Sender: TObject);
begin
  ShowMessage('NO');
end;

procedure TfrmDesign.cmpFormDesignerChange(Sender: TObject);
begin
  UpdateInfo;
end;

procedure TfrmDesign.cmpFormDesignerAddControl(Sender: TObject;
  TheControl: TControl);
begin
  GlobDirty := True;
end;

procedure TfrmDesign.cmpFormDesignerSaveControl(Sender: TObject;
  TheControl: TControl; IniFile: TIniFile);
begin
  
end;

procedure TfrmDesign.cmpFormDesignerMoveSizeControl(Sender: TObject;
  TheControl: TControl);
begin
  
  GlobDirty := True;
   
end;

procedure TfrmDesign.cmpFormDesignerPasteComponent(Sender: TObject;
  TheComponent: TComponent);
begin
  GlobDirty := True;
   
end;

procedure TfrmDesign.cmpFormDesignerLoadControl(Sender: TObject;
  TheControl: TControl; IniFile: TIniFile);
begin
  
end;

procedure TfrmDesign.cmpFormDesignerPlaceComponent(Sender: TObject;
  TheComponent: TComponent);
begin
  GlobDirty := True;
   
  EditMode(frmToolForm.pgcMain);
end;

procedure TfrmDesign.cmpFormDesignerReadError(Reader: TReader;
  const Message: string; var Handled: Boolean);
begin
  Handled := True;
end;

end.
