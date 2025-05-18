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
unit moptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Buttons, mUtils, mCompilerVariable, Process;

type

  TOptions = class(TForm)
    gbHooks: TGroupBox;
    HideTextEy: TCheckBox;
    Console: TCheckBox;
    imgCompressedWeb1: TImage;
    Label1: TLabel;
    Hooks: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    tsPageCodeSigningHooks: TTabSheet;
    TeamID: TEdit;
    AutoUpdate: TCheckBox;
    Bevel1: TBevel;
    BevelChangeRevision: TBevel;
    BevelOutputFilename: TBevel;
    btnAddVariable: TBitBtn;
    btnBrowsePFX: TButton;
    btnBrowseSPC: TButton;
    btnDeleteVariable: TBitBtn;
    btnEditVariable: TBitBtn;
    btnNewProductCode: TButton;
    btnNewRevisionCode: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    BuildFilename: TEdit;
    BuildFolder: TEdit;
    BuildFolderBrowse: TButton;
    CacheSource: TCheckBox;
    CD: TRadioButton;
    CodeSign: TCheckBox;
    HideTextEx: TCheckBox;
    InfoURL: TEdit;
    lblTeamID: TLabel;
    lblInfoURL: TLabel;
    lblPassword: TLabel;
    lblAppleIDPassword: TLabel;
    lblTimestamp: TLabel;
    Password: TEdit;
    poSignAll: TCheckBox;
    AppleIDPassword: TEdit;
    SPC: TComboBox;
    Compress0: TLabel;
    Compress1: TLabel;
    Compress2: TLabel;
    Compress3: TLabel;
    Compress4: TLabel;
    Compress5: TLabel;
    Compress6: TLabel;
    Compress7: TLabel;
    Compress8: TLabel;
    CompressBar: TTrackBar;
    CompressText: TLabel;
    Conditional: TListView;
    CustomFolder: TRadioButton;
    Debug: TCheckBox;
    Encrypt: TCheckBox;
    gbAuthenticode: TGroupBox;
    gbCompression: TGroupBox;
    gbDeploymentType: TGroupBox;
    gbOutput: TGroupBox;
    gbProjectProperties: TGroupBox;
    gbVariables: TGroupBox;
    HideText: TCheckBox;
    imgCompressedSFX: TImage;
    imgCompressedWeb: TImage;
    imgUncompressed: TImage;
    Key: TEdit;
    Label44: TLabel;
    LangEx: TCheckBox;
    Language: TComboBox;
    lblAESPassword: TLabel;
    lblBest: TLabel;
    lblChoose: TLabel;
    lblCompressedSFX: TLabel;
    lblCompressedWeb: TLabel;
    lblCreateBuildsIn: TLabel;
    lblLanguage: TLabel;
    lblLeaveEmpty: TLabel;
    lblManufacturer: TLabel;
    lblNone: TLabel;
    lblOutputFilename: TLabel;
    lblPFX: TLabel;
    lblProductCode: TLabel;
    lblProductName: TLabel;
    lblProductVersion: TLabel;
    lblPVK: TLabel;
    lblRevisionCode: TLabel;
    lblSPC: TLabel;
    lblSpecifyFilename: TLabel;
    lblUnCompressed: TLabel;
    Manufacturer: TEdit;
    OpenIcon: TOpenDialog;
    pcOptionTabs: TPageControl;
    pcCerts: TPageControl;
    IgnoreMissing: TCheckBox;
    PFX: TEdit;
    PFXOpen: TOpenDialog;
    pnCompressionText: TPanel;
    ProductCode: TEdit;
    ProductName: TEdit;
    ProductVersion: TEdit;
    ProjectFolder: TRadioButton;
    PVK: TEdit;
    PVKopen: TOpenDialog;
    RevisionCode: TEdit;
    SFX: TRadioButton;
    SPCopen: TOpenDialog;
    TimeStamp: TComboBox;
    tsPageProject: TTabSheet;
    tsPageCompilerVariables: TTabSheet;
    tsPageBuild: TTabSheet;
    tsPageAuthenticode: TTabSheet;
    tsPageCompression: TTabSheet;
    tsPageOutput: TTabSheet;
    Tree: TTreeView;
    tsPFX: TTabSheet;
    tsSPC: TTabSheet;
    Vista: TComboBox;
    Web: TRadioButton;
    procedure btnAddVariableClick(Sender: TObject);
    procedure btnBrowsePFXClick(Sender: TObject);
    procedure btnBrowsePVKClick(Sender: TObject);
    procedure btnBrowseSPCClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteVariableClick(Sender: TObject);
    procedure btnEditVariableClick(Sender: TObject);
    procedure btnNewProductCodeClick(Sender: TObject);
    procedure btnNewRevisionCodeClick(Sender: TObject);
    procedure BuildFolderBrowseClick(Sender: TObject);
    procedure CompressBarChange(Sender: TObject);
    procedure ConditionalDblClick(Sender: TObject);
    procedure ConsoleChange(Sender: TObject);
    procedure CacheSourceChange(Sender: TObject);
    procedure DebugChange(Sender: TObject);
    procedure EncryptChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HideTextChange(Sender: TObject);
    procedure HideTextExChange(Sender: TObject);
    procedure HideTextEyChange(Sender: TObject);
    procedure HooksChange(Sender: TObject);
    procedure IgnoreMissingClick(Sender: TObject);
    procedure ProjectFolderChange(Sender: TObject);
    procedure SPCDropDown(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure VistaChange(Sender: TObject);
  private
  public
    procedure PopulateBuildEvents;
  end;

var
  Options: TOptions;
  BackTimeStampText: String;

implementation

{$R *.lfm}

uses
  uGui;

procedure TOptions.TreeChange(Sender: TObject; Node: TTreeNode);
var
  ts: TTabSheet;
begin
  if Node = nil then
    Exit;
  
  pcOptionTabs.PageIndex := Node.AbsoluteIndex;
  
  ts := pcCerts.ActivePage;
  pcCerts.ActivePage := tsPFX;
  pcCerts.ActivePage := tsSPC;
  pcCerts.Activepage := ts;
  if Node.AbsoluteIndex < 2 then HelpKeyword := 'projectsettings'; 
  if Node.AbsoluteIndex > 1 then HelpKeyword := 'buildsettings'; 
  if Node.AbsoluteIndex = 6 then 
    PopulateBuildEvents;
end;

procedure TOptions.VistaChange(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  case Vista.ItemIndex of
    -1: Exit;
     0: s := 'requireAdministrator';
     1: s := 'asInvoker';
  end;
  for i := 1 to Conditional.Items.Count do
  begin
    if AnsiCompareText(Conditional.Items[i -1].Caption, 'UAC') = 0 then
    begin
      Conditional.Items[i -1].SubItems[0] := s;
      Exit;
    end;
    if i = Conditional.Items.Count then
      with Conditional.Items.Add do
      begin
        Caption := 'UAC';
        SubItems.Add(s);
        Exit;
      end;
  end;
  with Conditional.Items.Add do
  begin
    Caption := 'UAC';
    SubItems.Add(s);
  end;
end;

procedure TOptions.PopulateBuildEvents;
var
  s: String;
  i: Integer;
  b: Boolean;
begin
  s := '';
  for i := Conditional.Items.Count downto 1 do
    if AnsiCompareText(Conditional.Items[i -1].Caption, 'CODE-SIGN-HOOKS') = 0 then
    begin
      s := SingleLineToMultiLine(Conditional.Items[i -1].SubItems[0]);
      Break;
    end;
  Hooks.Lines.Text := s;
  Exit;
end;

procedure TOptions.btnCancelClick(Sender: TObject);
begin
end;

procedure TOptions.btnDeleteVariableClick(Sender: TObject);
var
  i: Integer;
begin
  for i := Conditional.Items.Count downto 1 do
    if Conditional.Items[i -1].Selected then
      Conditional.Items.Delete(i -1);
end;

procedure TOptions.btnEditVariableClick(Sender: TObject);
begin
  if Conditional.Selected = nil then Exit;
  CompilerVariable.Variable.Text := Conditional.Selected.Caption;
  CompilerVariable.Default.Text := Conditional.Selected.SubItems[0];
  if CompilerVariable.ShowModal = mrOk then
  begin
    Conditional.Selected.Caption := CompilerVariable.Variable.Text;
    Conditional.Selected.SubItems.Clear;
    Conditional.Selected.SubItems.Add(CompilerVariable.Default.Text);
  end;
end;

procedure TOptions.btnBrowsePVKClick(Sender: TObject);
begin
  if PVKopen.Execute then
    PVK.Text := PVKopen.FileName;
end;

procedure TOptions.btnBrowsePFXClick(Sender: TObject);
begin
  if PFXopen.Execute then
    PFX.Text := PFXopen.FileName;
end;

procedure TOptions.btnAddVariableClick(Sender: TObject);
var
  i, j: Integer;
  l: TListItem;
begin
  CompilerVariable.Variable.Text := '';
  CompilerVariable.Default.Text := '';
  if CompilerVariable.ShowModal = mrOk then
  begin
    j := -1;
    for i := 1 to Conditional.Items.Count do
      if AnsiUpperCase(Conditional.Items[i -1].Caption) = AnsiUpperCase(CompilerVariable.Variable.Text) then
      begin
        j := i -1;
        Break;
      end;
    if j = -1 then
      j := Conditional.Items.Add.Index;
    l := Conditional.Items[j];
    l.Caption := CompilerVariable.Variable.Text;
    l.SubItems.Clear;
    l.SubItems.Add(CompilerVariable.Default.Text);
  end;
end;

procedure TOptions.btnBrowseSPCClick(Sender: TObject);
begin
  if SPCopen.Execute then
    SPC.Text := SPCopen.FileName;
end;

procedure TOptions.btnNewProductCodeClick(Sender: TObject);
begin
  ProductCode.Text := CreateGUIDUp;
end;

procedure TOptions.btnNewRevisionCodeClick(Sender: TObject);
begin
  RevisionCode.Text := CreateGUIDUp;
end;

procedure TOptions.BuildFolderBrowseClick(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory(SBuildFolder, '', s) then
    BuildFolder.Text := AssertDir(s);
end;

procedure TOptions.CompressBarChange(Sender: TObject);
begin
  
  {$IFDEF DARWIN}
  if CompressBar.Position = 0 then
    CompressText.Caption := 'UDRO - UDIF read-only image';
  if CompressBar.Position = 1 then
    CompressText.Caption := 'UDRW - UDIF read/write image';
  if CompressBar.Position = 2 then
    CompressText.Caption := 'UDCO - UDIF ADC-compressed image';
  if CompressBar.Position = 3 then
    CompressText.Caption := 'UDBZ - UDIF bzip2-compressed image (deprecated)';
  if CompressBar.Position = 4 then
    CompressText.Caption := 'UDZO - UDIF zlib-compressed image';
  if CompressBar.Position = 5 then
    CompressText.Caption := 'ULFO - UDIF lzfse-compressed image (OS X 10.11+ only)';
  if CompressBar.Position = 6 then
    CompressText.Caption := 'ULMO - UDIF lzma-compressed image (macOS 10.15+ only)';
  if CompressBar.Position = 7 then
    CompressText.Caption := 'not implemented yet';
  if CompressBar.Position = 8 then
    CompressText.Caption := 'not implemented yet';
  {$ELSE}
  if CompressBar.Position = 0 then
    CompressText.Caption := Compress0.Caption;
  if CompressBar.Position = 1 then
    CompressText.Caption := Compress1.Caption;
  if CompressBar.Position = 2 then
    CompressText.Caption := Compress2.Caption;
  if CompressBar.Position = 3 then
    CompressText.Caption := Compress3.Caption;
  if CompressBar.Position = 4 then
    CompressText.Caption := Compress4.Caption;
  if CompressBar.Position = 5 then
    CompressText.Caption := Compress5.Caption;
  if CompressBar.Position = 6 then
    CompressText.Caption := Compress6.Caption;
  if CompressBar.Position = 7 then
    CompressText.Caption := Compress7.Caption;
  if CompressBar.Position = 8 then
    CompressText.Caption := Compress8.Caption;
  {$ENDIF}
end;

procedure TOptions.ConditionalDblClick(Sender: TObject);
begin

end;

procedure TOptions.ConsoleChange(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  case Console.State of
    cbChecked: s := 'TRUE';
    cbUnChecked: s := 'FALSE';
    cbGrayed: s := 'AUTO';
  end;
  for i := 1 to Conditional.Items.Count do
  begin
    if AnsiCompareText(Conditional.Items[i -1].Caption, 'NOGUI') = 0 then
    begin
      Conditional.Items[i -1].SubItems[0] := s;
      Exit;
    end;
    if i = Conditional.Items.Count then
      with Conditional.Items.Add do
      begin
        Caption := 'NOGUI';
        SubItems.Add(s);
        Exit;
      end;
  end;
  with Conditional.Items.Add do
  begin
    Caption := 'NOGUI';
    SubItems.Add(s);
  end;
end;

procedure TOptions.CacheSourceChange(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  case CacheSource.State of
    cbChecked: s := 'TRUE';
    cbUnchecked: s := 'FALSE';
    cbGrayed: s := '';
  end;
  for i := Conditional.Items.Count downto 1 do
  begin
    if AnsiCompareText(Conditional.Items[i -1].Caption, 'CACHESOURCES') = 0 then
    begin
      Conditional.Items[i -1].SubItems[0] := s;
      if s = '' then
        Conditional.Items.Delete(i -1);
      Exit;
    end;
    if i = Conditional.Items.Count then
      if s <> '' then
        with Conditional.Items.Add do
        begin
          Caption := 'CACHESOURCES';
          SubItems.Add(s);
          Exit;
        end;
  end;
  if s <> '' then
    with Conditional.Items.Add do
    begin
      Caption := 'CACHESOURCES';
      SubItems.Add(s);
    end;
end;

procedure TOptions.DebugChange(Sender: TObject);
begin
  if Debug.Checked then
    CD.Checked := True;
end;

procedure TOptions.EncryptChange(Sender: TObject);
begin
  HideText.Enabled := Encrypt.Checked;
  Key.Enabled := Encrypt.Checked;
  lblAESPassword.Enabled := Encrypt.Checked;
end;

procedure TOptions.FormCreate(Sender: TObject);
begin
  {$IFDEF LINUX}
  Hooks.WantReturns := True;
  Label2.Caption := 'To start a new command, use the ENTER key.';
  {$ENDIF}
  {$IFDEF DARWIN} 
  Label2.Caption := 'To start a new command, type OPTION+ENTER.';
  {$ENDIF}
end;

procedure TOptions.FormHide(Sender: TObject);
begin
  ui.PopStatusStack;
end;

procedure TOptions.FormShow(Sender: TObject);
var
  l: TStringList;
  i: Integer;
  b: Boolean;
  s, sX: String;
  n: TTreeNode;
begin
  ui.PushStatusStack('Editing project settings');
  
  LangEx.Visible := false;
  for i := 1 to SupportFiles.Count do
    if AnsiCompareText(ExtractFileNameOnly(ProjectStruct.Name) + '.mtx', 
      SupportFiles[i -1]) = 0 then
    begin
      LangEx.Visible := True;
      Break;
    end;
  
  n := Tree.Selected;
  TreeChange(Self, Tree.Items[3]);
  TreeChange(Self, n);
  TimeStamp.Text := BackTimeStampText;
  ProjectFolderChange(Self);
  if Tree.Selected = nil then
    Tree.Items[0].Selected := True;
  TreeChange(Self, Tree.Selected);
  
  s := ProjectStruct.Language;
  
  Language.Items.Clear;
  
  l := FindAllFilesEx(EXEDIR + 'trans\translations.*', false); 
  for i := 1 to l.Count do
  begin
    sX := ExtractFileExt(l[i -1]);
    Delete(sX, 1, 1);
    if (AnsiUpperCase(sX) <> 'MAP') and 
      ((AnsiUpperCase(sX) <> 'ORIGINAL') and (AnsiUpperCase(sX) <> 'DEFINITION')) then 
      Language.Items.Add(sX);
  end;
  l.Free;
  
  b := false;
  for i := 1 to Language.Items.Count do
    if AnsiUpperCase(Language.Items[i -1]) = 'ENGLISH' then 
    begin
      b := True;
      Break;
    end;
  if not b then Language.Items.Add(SEnglish_1);
  Language.Style := csDropDown;
  Language.Sorted := True;
  Language.Style := csDropDownList;
  
  for i := 1 to Language.Items.Count do
    if AnsiUpperCase(Language.Items[i -1]) = AnsiUpperCase(s) then
    begin
      Language.ItemIndex := i -1;
      Break;
    end
    else
    begin
      if AnsiUpperCase(Language.Items[i -1]) = 'ENGLISH' then 
      Language.ItemIndex := i -1;
    end;
  
  CompressBarChange(Self);
  
  HideTextChange(Self);
  EncryptChange(Self);
  HideTextExChange(Self);
  HideTextEyChange(Self);
end;

procedure TOptions.HideTextChange(Sender: TObject);
begin
  if HideText.Checked then
    Key.PasswordChar := '*'
  else
    Key.PasswordChar := #0;
end;

procedure TOptions.HideTextExChange(Sender: TObject);
begin
  if HideTextEx.Checked then
    Password.PasswordChar := '*'
  else
    Password.PasswordChar := #0;
end;

procedure TOptions.HideTextEyChange(Sender: TObject);
begin
  if HideTextEy.Checked then
    AppleIDPassword.PasswordChar := '*'
  else
    AppleIDPassword.PasswordChar := #0;
end;

procedure TOptions.HooksChange(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s := MultiLineToSingleLine(Hooks.Lines.Text);
  for i := 1 to Conditional.Items.Count do
  begin
    if AnsiCompareText(Conditional.Items[i -1].Caption, 'CODE-SIGN-HOOKS') = 0 then
    begin
      Conditional.Items[i -1].SubItems[0] := s;
      Exit;
    end;
    if i = Conditional.Items.Count then
      with Conditional.Items.Add do
      begin
        Caption := 'CODE-SIGN-HOOKS';
        SubItems.Add(s);
        Exit;
      end;
  end;
  with Conditional.Items.Add do
  begin
    Caption := 'CODE-SIGN-HOOKS';
    SubItems.Add(s);
  end;
end;

procedure TOptions.IgnoreMissingClick(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  if IgnoreMissing.Checked then s := 'TRUE'
    else s := 'FALSE';
  for i := 1 to Conditional.Items.Count do
  begin
    if AnsiCompareText(Conditional.Items[i -1].Caption, 'IGNOREMISSINGFILES') = 0 then
    begin
      Conditional.Items[i -1].SubItems[0] := s;
      Exit;
    end;
    if i = Conditional.Items.Count then
      with Conditional.Items.Add do
      begin
        Caption := 'IGNOREMISSINGFILES';
        SubItems.Add(s);
        Exit;
      end;
  end;
  with Conditional.Items.Add do
  begin
    Caption := 'IGNOREMISSINGFILES';
    SubItems.Add(s);
  end;
end;

procedure TOptions.ProjectFolderChange(Sender: TObject);
begin
  BuildFolder.Enabled := CustomFolder.Checked;
  BuildFolderBrowse.Enabled := CustomFolder.Checked;
end;

procedure TOptions.SPCDropDown(Sender: TObject);
var
  i: Integer;
  p: TProcess;
  li: LongInt;
  l: TStringList;
  fs: TFileStream;
  b: array[1..8192] of Byte;
begin
  try
    p := TProcess.Create(nil);
    p.CommandLine := 'certtool y'; 
    p.Options := [poUsePipes];
    
    p.Options := p.Options + [poNoConsole];
    p.Options := p.Options - [poNewConsole];
    
    p.Execute;
    fs := TFileStream.Create(EXEDIR + 'csr', fmCreate);
    repeat
      li := p.Output.Read(b, 8192);
      fs.Write(b, li);
    until li = 0;
    fs.Free;
    p.Free;
    l := TStringList.Create;
    l.LoadFromFile(EXEDIR + 'csr');
    DeleteFile(EXEDIR + 'csr');
    for i := l.Count downto 1 do
      if AnsiPos('   Common Name     : Developer ID Application: ', l[i -1]) <> 1 then
        l.Delete(i -1)
      else
        l[i -1] := StringReplace(l[i -1], '   Common Name     : ', '', [rfReplaceAll, rfIgnoreCase]);
    
    SPC.Items.Text := l.Text;
    l.Free;
  except
    
  end;
end;

end.

