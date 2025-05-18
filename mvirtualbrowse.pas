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
unit mvirtualbrowse;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  ShellAPI, Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils,
  
  Variants, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ImgList, StdCtrls, mUtils, Buttons, ComCtrls, ComboEx
  {$IFDEF WINDOWS}, Windows{$ENDIF};

type

  TVirtualBrowse = class(TForm)
    BrowseFeatures: TComboBoxEx;
    OK: TBitBtn;
    Cancel: TBitBtn;
    FileImages: TImageList;
    FeatureImages: TImageList;
    Timer: TTimer;
    FeatFilter: TCheckBox;
    Panel: TPanel;
    Folders: TTreeView;
    Splitter: TSplitter;
    Files: TListView;
    Label6: TLabel;
    Image14: TImage;
    procedure FormShow(Sender: TObject);
    procedure FeatFilterClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FilesDblClick(Sender: TObject);
    procedure FoldersChange(Sender: TObject; Node: TTreeNode);
    procedure BrowseFeaturesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    
  public
    function BrowseForVirtualFile(var FileName: String): Boolean;
    procedure BrowseWithTextControl(TextControl: TEdit); overload;
    procedure BrowseWithTextControl(TextControl: TComboBox); overload;
    procedure BrowseWithTextControl(TextControl: TComboBoxEx); overload;
    procedure BrowseWithMemoControl(MemoControl: TMemo);
  end;

var
  VirtualBrowse: TVirtualBrowse;
  VirtualBrowseSelectedFile: String;

implementation

{$IFnDEF FPC}
  {$R *.lfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

uses
  uGui;

resourcestring
  SSupportFiles = 'Support Files';
  SFiLterFilesByFeature = 'Fi&lter Files by Feature:';
  SFiLterFilesByFeature_1 = 'Fi&lter Files by Feature...';

procedure TVirtualBrowse.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := false;
  OK.Enabled := (Files.SelCount = 1) and
    ((AnsiPos('*', Files.Selected.Caption) = 0) and
      (AnsiPos('?', Files.Selected.Caption) = 0));
  Timer.Enabled := True;
end;

procedure TVirtualBrowse.FormCreate(Sender: TObject);
{$IFDEF WINDOWS}
var
  SFI: TSHFileInfo;
begin
  Files.SmallImages := TImageList.Create(Self);
  
  Files.SmallImages.ShareImages := True;
  Timer.Interval := 100;
  Timer.Enabled := True;
{$ELSE}
begin
  Timer.Interval := 100;
  Timer.Enabled := True;
{$ENDIF}
end;

procedure TVirtualBrowse.FormHide(Sender: TObject);
begin
  ui.PopStatusStack;
end;

procedure TVirtualBrowse.BrowseFeaturesChange(Sender: TObject);
begin
  FoldersChange(Self, Folders.Selected);
end;

procedure TVirtualBrowse.FoldersChange(Sender: TObject; Node: TTreeNode);
var
  l: TStrings;
  i: Integer;
  hWait, hDef: TCursor;
begin
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if BrowseFeatures.ItemIndex = -1 then Exit; 
    if Folders.Selected = nil then Exit;
    Files.Items.BeginUpdate;
    Files.Items.Clear;
    if Folders.Selected.Text = SSupportFiles then
      for i := 1 to SupportFiles.Count do
        ui.AddFileToFileList(VirtualBrowse.Files,
          ExtractFilePath(SupportFiles[i -1]),
          ExtractFileName(SupportFiles[i -1]),
          '')
    else
    begin
      Files.Enabled := True;
      l := ui.GetFilesAndSourcesForComponentInFolder(
        ui.GetComponentPathFromCombo(BrowseFeatures),
        ui.GetFolderPathFromTree(Folders.Selected), FeatFilter.Checked);
      for i := 1 to l.Count do
        if i mod 2 = 1 then
          ui.AddFileToFileList(VirtualBrowse.Files,
            ExtractFilePath(l[i -1]),
            ExtractFileName(l[i -1]),
            l[i]);
      l.Free;
    end;
    Files.Items.EndUpdate;
  finally
    Screen.Cursor := hDef;
  end;
  Folders.Selected.MakeVisible;
end;

procedure TVirtualBrowse.FilesDblClick(Sender: TObject);
begin
  if OK.Enabled then
  begin
    OKClick(Self);
    ModalResult := mrOk;
  end;
end;

procedure TVirtualBrowse.OKClick(Sender: TObject);
begin
  VirtualBrowseSelectedFile := Files.Selected.Caption;
end;

procedure TVirtualBrowse.FeatFilterClick(Sender: TObject);
begin
  BrowseFeatures.Visible := FeatFilter.Checked;
  if FeatFilter.Checked then
    FeatFilter.Caption := SFiLterFilesByFeature
  else
    FeatFilter.Caption := SFiLterFilesByFeature_1;
  FoldersChange(Self, Folders.Selected);
end;

function TVirtualBrowse.BrowseForVirtualFile(var FileName: String): Boolean;
begin
  
  VirtualBrowseSelectedFile := FileName;
  Result := ShowModal = mrOk;
  
  if Result then
  begin
    FileName := AssertDir(ui.GetFolderPathFromTree(Folders.Selected))
      + VirtualBrowseSelectedFile;
    if ExtractFilePath(FileName) = '' then
      FileName := '$SUPPORTDIR$\' + FileName; 
  end;
end;

procedure TVirtualBrowse.FormShow(Sender: TObject);
var
  l, lX: TStringList;
  i, j: Integer;
begin
  ui.PushStatusStack('Browsing for installed files');
  
  l := TStringList.Create;
  lX := TStringList.Create;
  for i := 1 to DefComponent.Count do
    if (i -1) mod 4 = 0 then
    begin
      l.Add(DefComponent[(i -1) +1]);
      lX.Add(DefComponent[(i -1) +2]);
    end;
  ui.GetComponentsTree(ui.Features, l, lX);
  l.Free;
  lX.Free;
  
  ui.MigrateFeatures(ui.Features, BrowseFeatures);
  BrowseFeatures.ItemIndex := 0;
  
  l := TStringList.Create;
  l.Sorted := True;
  l.CaseSensitive := false;
  l.Duplicates := dupIgnore;
  for i := 1 to InstallFiles.Count do
    if (i -1) mod 13 = 0 then
      l.Add(InstallFiles[(i -1) + 3]);
  for i := 1 to GetFolderLocation.Count do
    if (i -1) mod 4 = 0 then
      l.Add('$' + GetFolderLocation[(i -1) + 1] + '$');
  ui.GetFoldersTreeEx(VirtualBrowse.Folders, l);
  
  l.Free;
  
  FeatFilterClick(Self);
  Folders.Items.Item[0].Selected := True;
  Folders.Items.Item[0].Expand(True);
  BrowseFeaturesChange(Self);
  Files.SetFocus;
  
  if VirtualBrowseSelectedFile <> '' then
  begin
    if AnsiPos('$SUPPORTDIR$\', AnsiUpperCase(VirtualBrowseSelectedFile)) = 1 then 
    begin
      Folders.ClearSelection;
      Folders.Items[Folders.Items.Count -1].Selected := True;
      BrowseFeaturesChange(Self);
      for j := 1 to Files.Items.Count do
        if CompareText(Files.Items[j -1].Caption,
          ExtractFileName(VirtualBrowseSelectedFile)) = 0 then
        begin
          Files.Items[j -1].MakeVisible(false);
          Files.Items[j -1].Selected := True;
          Files.ItemFocused := Files.Items[j -1];
          Folders.Selected.MakeVisible;
          Exit;
        end;
    end
    else
      for i := 1 to Folders.Items.Count do
        if CompareText(AssertDir(ExtractFilePath(VirtualBrowseSelectedFile)),
          AssertDir(ui.GetFolderPathFromTree(Folders.Items[i -1]))) = 0 then
        begin
          Folders.ClearSelection;
          Folders.Items[i -1].Selected := True;
          BrowseFeaturesChange(Self);
          for j := 1 to Files.Items.Count do
            if CompareText(Files.Items[j -1].Caption,
              ExtractFileName(VirtualBrowseSelectedFile)) = 0 then
            begin
              Files.Items[j -1].MakeVisible(false);
              Files.ItemFocused := Files.Items[j -1];
              Files.Items[j -1].Selected := True;
              Folders.Selected.MakeVisible;
              Exit;
            end;
          Break;
        end;
  end;
  VirtualBrowseSelectedFile := ''; 
end;

procedure TVirtualBrowse.BrowseWithTextControl(TextControl: TEdit);
var
  s: String;
begin
  s := TextControl.Text;
  if VirtualBrowse.BrowseForVirtualFile(s) then
    TextControl.Text := s;
end;

procedure TVirtualBrowse.BrowseWithMemoControl(MemoControl: TMemo);
var
  s: String;
begin
  if VirtualBrowse.BrowseForVirtualFile(s) then
    if MemoControl.Lines.IndexOf(s) = -1 then
      MemoControl.Lines.Add(s);
end;

procedure TVirtualBrowse.BrowseWithTextControl(TextControl: TComboBox);
var
  s: String;
begin
  s := TextControl.Text;
  if VirtualBrowse.BrowseForVirtualFile(s) then
    TextControl.Text := s;
end;

procedure TVirtualBrowse.BrowseWithTextControl(TextControl: TComboBoxEx);
var
  s: String;
begin
  s := TextControl.Text;
  if VirtualBrowse.BrowseForVirtualFile(s) then
    TextControl.Text := s;
end;

end.

