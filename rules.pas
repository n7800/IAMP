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
unit Rules;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, mUtils,
  MaskEdit, CheckLst, PropIntf, PropList, FileLbl,
  ShellCtrls;

type
  TfrmRules = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SrcCont: TComboBox;
    SrcProp: TComboBox;
    TrgCont: TComboBox;
    TrgProp: TComboBox;
    SrcVal: TEdit;
    TrgVal: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    cNot: TCheckBox;
    GroupBox2: TGroupBox;
    Existing: TListBox;
    BitBtn2: TBitBtn;
    Label8: TLabel;
    Label9: TLabel;
    Cont: TComboBox;
    lblReceives: TLabel;
    Receives: TComboBox;
    lblVariable: TLabel;
    Variable: TEdit;
    Label13: TLabel;
    arrReceives: TLabel;
    arrVariable: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    lblAction: TLabel;
    arrAction: TLabel;
    Action: TComboBox;
    Label18: TLabel;
    Label20: TLabel;
    BitBtn4: TBitBtn;
    Up: TSpeedButton;
    Down: TSpeedButton;
    Image16: TImage;
    Image15: TImage;
    Image1: TImage;
    Image14: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label10: TLabel;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    procedure PageControlChange(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure VariableExit(Sender: TObject);
    procedure VariableEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ContChange(Sender: TObject);
    procedure PropChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ExistingClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BehaviorContChange(Sender: TObject);
    procedure SetControlTag(Sender: TObject);
    procedure VariableChange(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure UpClick(Sender: TObject);
    procedure DownClick(Sender: TObject);
  private
  public
    procedure AddRule(ReplaceIndex: Integer);
    procedure SetControls(Receive, Write, Perform: Boolean);
  end;

const
  ReceiveExStr = '[Written Variable Value]';

var
  frmRules: TfrmRules;
  SelItem: String;
  piSrc, piTrg: TPropertyInterface;

implementation

uses
  OIForm, Design, ToolForm, uDlgAPI;

{$R *.lfm}

procedure TfrmRules.SetControls(Receive, Write, Perform: Boolean);
begin
  if Perform then
  begin
    Action.Items.Clear;
    Action.Items.Add('<none>');
  end;
  arrAction.Enabled := Perform;
  lblAction.Enabled := Perform;
  Action.Enabled := Perform;
  arrVariable.Enabled := Write;
  lblVariable.Enabled := Write;
  Variable.Enabled := Write;
  if Receive then
  begin
    Receives.Items.Clear;
    Receives.Items.Add('<none>');
  end;
  arrReceives.Enabled := Receive;
  lblReceives.Enabled := Receive;
  Receives.Enabled := Receive;
end;

procedure TfrmRules.FormShow(Sender: TObject);
var
  i, j: Integer;
  b: Boolean;
  s: String;
  SourceControl, TargetControl: String;
begin
  SrcCont.Items.Clear;
  TrgCont.Items.Clear;
  Cont.Items.Clear;
  for i := 1 to frmDesign.ComponentCount do
    if frmDesign.Components[i -1].Name <> 'cmpFormDesigner' then
      if Trim(frmDesign.Components[i -1].Name) <> '' then
      begin
        SrcCont.Items.AddObject(frmDesign.Components[i -1].Name, frmDesign.Components[i -1]);
        TrgCont.Items.AddObject(frmDesign.Components[i -1].Name, frmDesign.Components[i -1]);
        Cont.Items.AddObject(frmDesign.Components[i -1].Name, frmDesign.Components[i -1]);
      end;
  
  Cont.ItemIndex := 0;
  TrgCont.ItemIndex := 0;
  SrcCont.ItemIndex := SrcCont.Items.IndexOf(SelItem);
  ContChange(SrcCont);
  ContChange(TrgCont);
  Cont.ItemIndex := Cont.Items.IndexOf(SelItem);
  BehaviorContChange(Cont);
  for i := Existing.Count downto 1 do
  begin
    ParseRule(Existing.Items[i -1], b, SourceControl, s, s, TargetControl, s, s);
    
    b := false;
    for j := 1 to SrcCont.Items.Count do
      if AnsiLowerCase(SrcCont.Items[j -1]) = AnsiLowerCase(SourceControl) then
      begin
        b := True;
        Break;
      end;
    
    if b then
    begin
      b := false;
      for j := 1 to TrgCont.Items.Count do
        if AnsiLowerCase(TrgCont.Items[j -1]) = AnsiLowerCase(TargetControl) then
        begin
          b := True;
          Break;
        end;
    end;
    
    if not b then
      Existing.Items.Delete(i -1);
  end;
end;

procedure TfrmRules.ContChange(Sender: TObject);
var
  i: Integer;
  cb, tcb: TComboBox;
  pi: TPropertyInterface;
begin
  cb := TComboBox(Sender);
  if cb = SrcCont then
  begin
    tcb := SrcProp;
    pi := piSrc;
  end
  else
  begin
    tcb := TrgProp;
    pi := piTrg;
  end;
  tcb.Items.Clear;
  if cb.ItemIndex = -1 then Exit;
  pi.Instance := TComponent(cb.Items.Objects[cb.ItemIndex]);
  for i := 1 to pi.Count do
    if not IsFilteredProp(pi.Properties[i -1].Name) then
      tcb.Items.AddObject(pi.Properties[i -1].Name, pi.Properties[i -1]);
  tcb.ItemIndex := 0;
  PropChange(tcb);
end;

procedure TfrmRules.PropChange(Sender: TObject);
var
  cb: TComboBox;
  ed: TEdit;
  pr: TProperty;
begin
  cb := TComboBox(Sender);
  if cb = SrcProp then
    ed := SrcVal
  else
    ed := TrgVal;
  pr := TProperty(cb.Items.Objects[cb.ItemIndex]);
  ed.Text := pr.AsString;
end;

procedure TfrmRules.BitBtn1Click(Sender: TObject);
begin
  AddRule(-1);
  GlobDirty := True;
end;

procedure TfrmRules.BitBtn2Click(Sender: TObject);
var
  i: Integer;
begin
  for i := Existing.Items.Count downto 1 do
    if Existing.Selected[i -1] then
    begin
      Existing.Items.Delete(i -1);
      GlobDirty := True;
    end;
end;

procedure TfrmRules.ExistingClick(Sender: TObject);
var
  srcControl, srcProperty, srcValue: String;
  trgControl, trgProperty, trgValue: String;
  srcReverse: Boolean;
begin
  if Existing.ItemIndex = -1 then Exit;
  ParseRule(Existing.Items[Existing.ItemIndex], srcReverse,
    srcControl, srcProperty, srcValue, trgControl, trgProperty,
    trgValue);
  cNot.Checked := srcReverse;
  SrcCont.ItemIndex := SrcCont.Items.IndexOf(srcControl);
  ContChange(SrcCont);
  SrcProp.ItemIndex := SrcProp.Items.IndexOf(srcProperty);
  SrcVal.Text := srcValue;
  TrgCont.ItemIndex := TrgCont.Items.IndexOf(trgControl);
  ContChange(TrgCont);
  TrgProp.ItemIndex := TrgProp.Items.IndexOf(trgProperty);
  TrgVal.Text := trgValue;
end;

procedure TfrmRules.AddRule(ReplaceIndex: Integer);
var
  s, sX: String;
begin
  if cNot.Checked then sX := ' <> '
    else sX := ' = ';
  s := 'IF (' +
    SrcCont.Text + '.' + SrcProp.Text + sX + SrcVal.Text + ')  THEN  ' +
    TrgCont.Text + '.' + TrgProp.Text + ' := ' + TrgVal.Text + ';';
  
  if (ReplaceIndex <> -1) and (Existing.ItemIndex = -1) then Exit;
  if ReplaceIndex = -1 then Existing.Items.Add(s)
    else Existing.Items[ReplaceIndex] := s;
end;

procedure TfrmRules.BitBtn3Click(Sender: TObject);
begin
  if Existing.ItemIndex <> -1 then
    if Existing.ItemIndex +1 <= Existing.Items.Count then
    begin
      AddRule(Existing.ItemIndex);
      GlobDirty := True;
    end;
end;

procedure TfrmRules.BehaviorContChange(Sender: TObject);
begin
  SetControls(false, false, false);
  if Cont.ItemIndex = -1 then Exit;
  Variable.Text := TControl(Cont.Items.Objects[Cont.ItemIndex]).Hint;
  if ((((((Cont.Items.Objects[Cont.ItemIndex] is TLabel) or
    (Cont.Items.Objects[Cont.ItemIndex] is TLabel)) or 
    (Cont.Items.Objects[Cont.ItemIndex] is TButton)) or
    ((Cont.Items.Objects[Cont.ItemIndex] is TBitBtn) or
    (Cont.Items.Objects[Cont.ItemIndex] is TSpeedButton))) or
    (((Cont.Items.Objects[Cont.ItemIndex] is TImage) or
    (Cont.Items.Objects[Cont.ItemIndex] is TShape)))))
  then
  begin
    SetControls(false, false, True);
    Action.Items.Add('Go to Next Dialog');
    Action.Items.Add('Go to Previous Dialog');
    Action.Items.Add('Cancel Setup');
    Action.Items.Add('Select Target Folder');
    Action.Items.Add('Return from Dialog');
    Action.Items.Add('Select Custom Folder');
  end;
  if (Cont.Items.Objects[Cont.ItemIndex] is TStaticText) then
  begin
    SetControls(True, false, false);
    Receives.Items.Add('Installation Progress');
    Receives.Items.Add('Component Description');
    Receives.Items.Add('Component Required Space');
    Receives.Items.Add('Total Required Space');
    Receives.Items.Add('Available Disk Space');
    Receives.Items.Add('Disk Space Difference');
  end;
  if (Cont.Items.Objects[Cont.ItemIndex] is TFileLabel) then
  begin
    SetControls(True, false, false);
    Receives.Items.Add('Installation Progress');
    Receives.Items.Add('Component Description');
    Receives.Items.Add('Component Required Space');
    Receives.Items.Add('Total Required Space');
    Receives.Items.Add('Available Disk Space');
    Receives.Items.Add('Disk Space Difference');
  end;
  if Cont.Items.Objects[Cont.ItemIndex] is TProgressBar then
  begin
    SetControls(True, True, false);
    Receives.Items.Add(ReceiveExStr);
    Receives.Items.Add('Installation Progress');
  end;
  if (Cont.Items.Objects[Cont.ItemIndex] is TEdit) or
    (Cont.Items.Objects[Cont.ItemIndex] is TMaskEdit) then
  begin
    SetControls(True, True, false);
    Receives.Items.Add(ReceiveExStr);
    Receives.Items.Add('Start Menu Group');
    Receives.Items.Add('Installation Folder');
    Receives.Items.Add('Workstation User');
    Receives.Items.Add('Workstation Company');
  end;
  if (Cont.Items.Objects[Cont.ItemIndex] is TMemo) then
  begin
    SetControls(True, True, false);
    Receives.Items.Add('ReadMe File');
    Receives.Items.Add('License Agreement');
  end;
  if (Cont.Items.Objects[Cont.ItemIndex] is TTreeView) or
    (Cont.Items.Objects[Cont.ItemIndex] is TCheckListBox) then
  begin
    SetControls(True, True, false);
    Receives.Items.Add('Component List');
  end;
  if Cont.Items.Objects[Cont.ItemIndex] is TShellTreeView
  then
  begin
    SetControls(True, True, false);
    Receives.Items.Add(ReceiveExStr);
    Receives.Items.Add('Installation Folder');
  end;
  if (((Cont.Items.Objects[Cont.ItemIndex] is TCheckBox) or
    (Cont.Items.Objects[Cont.ItemIndex] is TRadioButton)) or
    ((Cont.Items.Objects[Cont.ItemIndex] is TListBox) or
    (Cont.Items.Objects[Cont.ItemIndex] is TComboBox))) or
    (Cont.Items.Objects[Cont.ItemIndex] is TTrackBar) then
      SetControls(false, True, false);
  Action.ItemIndex := TControl(Cont.Items.Objects[Cont.ItemIndex]).Tag;
  if TControl(Cont.Items.Objects[Cont.ItemIndex]).Tag = 100 then
    Receives.ItemIndex := Receives.Items.IndexOf(ReceiveExStr)
  else
    if TControl(Cont.Items.Objects[Cont.ItemIndex]).Tag = 0 then
      Receives.ItemIndex := 0
    else
    begin
      if Receives.Items.IndexOf(ReceiveExStr) <> -1 then
        Receives.ItemIndex := TControl(Cont.Items.Objects[Cont.ItemIndex]).Tag +1
      else
        Receives.ItemIndex := TControl(Cont.Items.Objects[Cont.ItemIndex]).Tag;
    end;
end;

procedure TfrmRules.SetControlTag(Sender: TObject);
var
  i: Integer;
begin
  if TComboBox(Sender).Items.IndexOf(ReceiveExStr) <> -1 then
  begin
    if TComboBox(Sender).ItemIndex = 0 then i := 0
      else if TComboBox(Sender).ItemIndex = 1 then i := 100
        else i := TComboBox(Sender).ItemIndex -1;
  end
  else
    i := TComboBox(Sender).ItemIndex;
  TControl(Cont.Items.Objects[Cont.ItemIndex]).Tag := i;
  GlobDirty := True;
end;

procedure TfrmRules.VariableChange(Sender: TObject);
begin
  TControl(Cont.Items.Objects[Cont.ItemIndex]).Hint := TEdit(Sender).Text;
  GlobDirty := True;
  VariableEnter(Sender);
end;

procedure TfrmRules.BitBtn4Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmRules.UpClick(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  if Existing.ItemIndex = 0 then Exit;
  if Existing.ItemIndex = -1 then Exit;
  s := Existing.Items[Existing.ItemIndex];
  i := Existing.ItemIndex -1;
  Existing.Items.Delete(Existing.ItemIndex);
  Existing.Items.Insert(i, s);
  Existing.ItemIndex := i;
  Existing.Selected[i] := True;
end;

procedure TfrmRules.DownClick(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  if Existing.ItemIndex = Existing.Items.Count -1 then Exit;
  if Existing.ItemIndex = -1 then Exit;
  s := Existing.Items[Existing.ItemIndex];
  i := Existing.ItemIndex +1;
  Existing.Items.Delete(Existing.ItemIndex);
  Existing.Items.Insert(i, s);
  Existing.ItemIndex := i;
  Existing.Selected[i] := True;
end;

procedure TfrmRules.VariableEnter(Sender: TObject);
var
  s: String;
begin
  if PageControl.ActivePage <> TabSheet2 then Exit;
  s := TEdit(Sender).Text;
end;

procedure TfrmRules.VariableExit(Sender: TObject);
begin
end;

procedure TfrmRules.FormHide(Sender: TObject);
begin
end;

procedure TfrmRules.PageControlChange(Sender: TObject);
begin
end;

initialization
  piSrc := TPropertyInterface.Create(nil);
  piTrg := TPropertyInterface.Create(nil);

finalization
  if Assigned(piSrc) then
    FreeAndNil(piSrc);
  if Assigned(piTrg) then
    FreeAndNil(piTrg);

end.
