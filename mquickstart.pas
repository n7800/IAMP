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
unit mquickstart;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, FileCtrl,
  ComboEx, mquickstartthread, mUtils{$IFDEF WINDOWS}, ShellAPI{$ENDIF};

type

  TQuickStartWizard = class(TForm)
    Back: TBitBtn;
    OpenWith: TComboBox;
    Cycle: TPage;
    Details: TPage;
    FileTypes: TPage;
    Finish: TPage;
    Folder: TPage;
    Next: TBitBtn;
    Cancel: TBitBtn;
    Bevel2: TBevel;
    QBook: TNotebook;
    Image1: TImage;
    Shape2: TShape;
    Label21: TLabel;
    Label22: TLabel;
    Shortcuts: TListView;
    VMware: TImage;
    VirtualPC: TLabel;
    Label23: TLabel;
    Image13: TImage;
    Label26: TLabel;
    Label24: TLabel;
    Label18: TLabel;
    Label27: TLabel;
    Shape3: TShape;
    Image2: TImage;
    Label1: TLabel;
    BuildNow: TCheckBox;
    Label20: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    Label4: TLabel;
    Image3: TImage;
    Label2: TLabel;
    Product: TEdit;
    Organization: TEdit;
    Image47: TImage;
    Label6: TLabel;
    Label8: TLabel;
    Files: TEdit;
    Label10: TLabel;
    Bevel1: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    Image5: TImage;
    Browse: TButton;
    Image57: TImage;
    Dynamic: TCheckBox;
    Label7: TLabel;
    Image4: TImage;
    Label15: TLabel;
    Bevel4: TBevel;
    Image7: TImage;
    Label17: TLabel;
    Label19: TLabel;
    Image59: TImage;
    ShortcutsPage: TPage;
    PlatformMenu: TCheckBox;
    Desktop: TCheckBox;
    QuickLaunchBar: TCheckBox;
    Locations: TLabel;
    Label5: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Image6: TImage;
    Bevel5: TBevel;
    Label25: TLabel;
    Label28: TLabel;
    Image65: TImage;
    Extension: TEdit;
    Label9: TLabel;
    Image8: TImage;
    OpenWithText: TLabel;
    Image9: TImage;
    Label29: TLabel;
    Label30: TLabel;
    Bevel6: TBevel;
    Image10: TImage;
    Label32: TLabel;
    Welcome: TPage;
    procedure FormCreate(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure BrowseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ShortcutsEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure ShortcutsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure PlatformMenuClick(Sender: TObject);
    procedure DesktopClick(Sender: TObject);
    procedure QuickLaunchBarClick(Sender: TObject);
    procedure ShortcutsEdited(Sender: TObject; Item: TListItem; var S: string);
    procedure ShortcutsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExtensionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    
  public
    procedure PrepNewRun;
    procedure CallStep;
    function CheckStep: Boolean;
    procedure AdjustButtons;
    function Query(Question: String): Boolean;
    procedure SetListItemOverlay(Item: TListItem);
    function AddFileToFileList(List: TListView; FilePath, FileName: String): TListItem;
    function AddFileToFileDrop(Drop: TComboBoxEx; FilePath: String): TComboExItem;
    procedure Bomb(Error: String);
    procedure SetShortcutState(Enabled: Boolean);
  end;

var
  QuickStartWizard: TQuickStartWizard;
  FwdStep, BackStep: Boolean;
  LastGoodFolder: String = '';
  Step: Integer;
  FirstShot: Boolean = false;

implementation

{$R *.lfm}

function TQuickStartWizard.AddFileToFileDrop(Drop: TComboBoxEx;
  FilePath: String): TComboExItem;
var
  {$IFDEF WINDOWS}
  SFI: TSHFileInfo;
  {$ENDIF}
  Attr: Integer;
begin
  Result := Drop.ItemsEx.Add;
  Attr := FILE_ATTRIBUTE_NORMAL;
  Result.Caption := FilePath;
  {$IFDEF WINDOWS}
  SHGetFileInfo(PChar(FilePath), Attr, SFI, SizeOf(TSHFileInfo), SHGFI_ICON or SHGFI_USEFILEATTRIBUTES);
  Result.ImageIndex := SFI.iIcon;
  {$ENDIF}
end;

function TQuickStartWizard.AddFileToFileList(List: TListView; FilePath, FileName: String): TListItem;
var
  {$IFDEF WINDOWS}
  SFI: TSHFileInfo;
  {$ENDIF}
  Attr: Integer;
begin
  Result := List.Items.Add;
  Attr := FILE_ATTRIBUTE_NORMAL;
  Result.Caption := FileName;
  Result.SubItems.Add(FilePath);
  Result.SubItems.Add('FALSE');
  Result.SubItems.Add('FALSE');
  Result.SubItems.Add('FALSE');
  {$IFDEF WINDOWS}
  SHGetFileInfo(PChar(FilePath), Attr, SFI, SizeOf(TSHFileInfo), SHGFI_ICON or SHGFI_USEFILEATTRIBUTES);
  Result.ImageIndex := SFI.iIcon;
  {$ENDIF}
end;

procedure TQuickStartWizard.AdjustButtons;
begin
  Next.Caption := '&Next >';
  if Step >= 6 then
    Next.Caption := '&Finish';
  Back.Enabled := Step > 1;
end;

procedure TQuickStartWizard.BackClick(Sender: TObject);
begin
  BackStep := True;
  FwdStep := false;
  Step := Step -1;
  CallStep;
end;

procedure TQuickStartWizard.Bomb(Error: String);
begin
  Application.MessageBox(PChar(Error), PChar(Caption),
    mb_iconStop + mb_Ok);
end;

procedure TQuickStartWizard.BrowseClick(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory('Select the folder containing your application files.', '', s) then
    Files.Text := s;
end;

procedure TQuickStartWizard.CallStep;
begin
  
  if not CheckStep then
  begin
    if BackStep then
      Step := Step +1
    else
      Step := Step -1;  
    Exit;
  end;
  
  AdjustButtons;
  
  case Step of
    1: QBook.PageIndex := QBook.Pages.IndexOf('Welcome');
    2: begin
         QBook.PageIndex := QBook.Pages.IndexOf('Details');
         Product.SetFocus;
       end;
    3: begin
         QBook.PageIndex := QBook.Pages.IndexOf('Folder');
         Files.SetFocus;
       end;
    4: begin
         QBook.PageIndex := QBook.Pages.IndexOf('ShortcutsPage');
         Shortcuts.SetFocus;
       end;
    5: begin
         QBook.PageIndex := QBook.Pages.IndexOf('FileTypes');
         if Extension.Enabled then
           Extension.SetFocus;
       end;
    6: begin
         QBook.PageIndex := QBook.Pages.IndexOf('Finish');
         BuildNow.SetFocus;
       end;
    7: begin
         OnCloseQuery := nil;
         ModalResult := mrOk;
       end;
  end;
end;

procedure TQuickStartWizard.CancelClick(Sender: TObject);
begin
  if Query('You will lose all your changes if you close the wizard now. Are you sure?') then
  begin
    if qst <> nil then
      qst.Terminate;
    OnCloseQuery := nil;
    ModalResult := mrCancel;
  end;
end;

function TQuickStartWizard.CheckStep: Boolean;
var
  i: Integer;
begin
  Result := false;
  if not FwdStep then
  begin
    Result := True;
    Exit;
  end;
  if Step = 3 then
  begin
    if Product.Text = '' then
    begin
      Bomb('Please enter your product name.');
      Product.SetFocus;
      Exit;
    end;
    if Organization.Text = '' then
    begin
      Bomb('Please enter your company name.');
      Organization.SetFocus;
      Exit;
    end;
  end;
  if Step = 4 then
  begin
    if Files.Text = '' then
    begin
      
      BrowseClick(Self);
    end;
    
    if Files.Text = '' then
    begin
      Bomb('Please select your application folder.');
      Files.SetFocus;
      Exit;
    end;
    if not DirectoryExists(Files.Text) then
    begin
      Bomb('The folder you selected is not accessible. Please select your application folder.');
      Files.SetFocus;
      Exit;
    end;
    if AnsiCompareText(AssertDir(LastGoodFolder), AssertDir(Files.Text)) <> 0 then
    begin
      
      Next.Enabled := false;
      Back.Enabled := false;
      BorderIcons := [biMaximize];
      Cancel.OnClick := CancelClick;
      QBook.PageIndex := QBook.Pages.IndexOf('Cycle');
      qstFinished := false;
      qstFolder := AssertDir(Files.Text);
      qst := TQuickStartThread.Create(True);
      qst.FreeOnTerminate := True;
      qst.Resume;
      repeat
        Application.HandleMessage;
      until qstFinished;
      
      BorderIcons := [biSystemMenu, biMaximize];
      Cancel.OnClick := nil;
      if not qstResult then
      begin
        QBook.PageIndex := QBook.Pages.IndexOf('Folder');
        Next.Enabled := True;
        Back.Enabled := True;
        Exit;
      end; 
      if qstList.Count = 0 then
      begin
        Bomb('The folder you selected is empty. Please select your application folder.');
        QBook.PageIndex := QBook.Pages.IndexOf('Folder');
        Files.SetFocus;
        Next.Enabled := True;
        Back.Enabled := True;
        Exit;
      end;
      
      Shortcuts.OnChange := nil;
      Shortcuts.Items.BeginUpdate;
      Shortcuts.Items.Clear;
      for i := 1 to qstListBin.Count do
        AddFileToFileList(Shortcuts, qstListBin[i -1], ExtractFileNameOnly(qstListBin[i -1]));
      Shortcuts.Items.EndUpdate;
      Shortcuts.OnChange := ShortcutsChange;
      OpenWith.Items.BeginUpdate;
      OpenWith.Items.Clear;
      for i := 1 to qstListBin.Count do
        
        OpenWith.Items.Add(qstListBin[i -1]);
      OpenWith.Items.EndUpdate;
      LastGoodFolder := AssertDir(Files.Text);
      
      Next.Enabled := True;
      Back.Enabled := True;
      QBook.PageIndex := QBook.Pages.IndexOf('Folder');
      Application.ProcessMessages;
    end;
  end;
  if Step = 4 then
  begin
    Shortcuts.ClearSelection;
    ShortcutsChange(Self, nil, ctState);
    if qstListBin.Count = 0 then
      Shortcuts.Color := clBtnFace
    else
      Shortcuts.Color := clWindow;
  end;
  if Step = 5 then
  begin
    if qstListBin.Count = 0 then
    begin
      Extension.Text := '';
      Extension.Enabled := false;
    end
    else
      Extension.Enabled := True;
    ExtensionChange(Self);
    if qstListBin.Count = 0 then
    begin
      Extension.Color := clBtnFace;
      OpenWith.Color := clBtnFace;
    end
    else
    begin
      Extension.Color := clWindow;
      OpenWith.Color := clWindow;
    end;
  end;
  Result := True;
end;

procedure TQuickStartWizard.DesktopClick(Sender: TObject);
begin
  if Shortcuts.Selected = nil then Exit;
  Shortcuts.Selected.SubItems[2] := BoolToStr(Desktop.Checked);
  SetListItemOverlay(Shortcuts.Selected);
end;

procedure TQuickStartWizard.ExtensionChange(Sender: TObject);
begin
  OpenWith.Enabled := Extension.Text <> '';
  if not OpenWith.Enabled then
    OpenWith.ItemIndex := -1
  else
    if OpenWith.ItemIndex = -1 then
      if OpenWith.Items.Count > 0 then
        OpenWith.ItemIndex := 0;
end;

procedure TQuickStartWizard.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not Visible then
  begin
    CanClose := True;
    Exit;
  end;
  CanClose := Query('You will lose all your changes if you close the wizard now. Are you sure?');
  if CanClose then
    if qst <> nil then
      ModalResult := mrCancel;
end;

procedure TQuickStartWizard.FormCreate(Sender: TObject);
{$IFDEF FAKEWINDOWS}
var
  SFI: TSHFileInfo;
begin
  
  Shortcuts.SmallImages := TImageList.Create(Self);
  Shortcuts.SmallImages.Handle := SHGetFileInfo('', 0, SFI, SizeOf(SFI), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  Shortcuts.SmallImages.ShareImages := True;
  OpenWith.Images := TImageList.Create(Self);
  OpenWith.Images.Handle := SHGetFileInfo('', 0, SFI, SizeOf(SFI), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  OpenWith.Images.ShareImages := True;
{$ELSE}
begin
{$ENDIF}
  QBook.HandleNeeded;
  PrepNewRun;
end;

procedure TQuickStartWizard.FormShow(Sender: TObject);
var
  i: Integer;
begin
  
  OnCloseQuery := FormCloseQuery;
  Next.SetFocus;
  if FirstShot then Exit;
  FirstShot := True;
  
  for i := 1 to QBook.Pages.Count do
  begin
    QBook.PageIndex := i -1;
    Application.ProcessMessages;
  end;
  QBook.PageIndex := 0;
  
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
end;

procedure TQuickStartWizard.NextClick(Sender: TObject);
begin
  FwdStep := True;
  BackStep := false;
  Step := Step +1;
  CallStep;
end;

procedure TQuickStartWizard.PrepNewRun;
begin
  LastGoodFolder := '';
  Product.Text := 'My Product';
  Organization.Text := 'My Company';
  Files.Text := '';
  Dynamic.Checked := True;
  Shortcuts.Items.BeginUpdate;
  Shortcuts.Items.Clear;
  Shortcuts.Items.EndUpdate;
  Extension.Text := '';
  OpenWith.Items.BeginUpdate;
  OpenWith.Items.Clear;
  OpenWith.Items.EndUpdate;
  BuildNow.Checked := True;
  FwdStep := True;
  BackStep := false;
  Step := 1;
  CallStep;
end;

function TQuickStartWizard.Query(Question: String): Boolean;
begin
  if Application.MessageBox(PChar(Question), PChar(Caption),
    mb_iconQuestion + mb_OkCancel + MB_DEFBUTTON2) = id_Ok then
    Result := True
  else
    Result := false;
end;

procedure TQuickStartWizard.QuickLaunchBarClick(Sender: TObject);
begin
  if Shortcuts.Selected = nil then Exit;
  Shortcuts.Selected.SubItems[3] := BoolToStr(QuickLaunchBar.Checked);
  SetListItemOverlay(Shortcuts.Selected);
end;

procedure TQuickStartWizard.SetListItemOverlay(Item: TListItem);
begin
  
end;

procedure TQuickStartWizard.SetShortcutState(Enabled: Boolean);
begin
  Locations.Enabled := Enabled;
  PlatformMenu.Enabled := Enabled;
  Desktop.Enabled := Enabled;
  QuickLaunchBar.Enabled := Enabled;
  if not Enabled then
  begin
    PlatformMenu.Checked := false;
    Desktop.Checked := false;
    QuickLaunchBar.Checked := false;
  end;
end;

procedure TQuickStartWizard.ShortcutsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  try
    PlatformMenu.OnClick := nil;
    
    Item := Shortcuts.Selected;
    
    if Item = nil then
    begin
      SetShortcutState(false);
      Exit;
    end;
    if Change = ctState then
      SetShortcutState(Item.Selected);
    if Item.Selected then
    begin
      
      PlatformMenu.Checked := StrToBool(Item.SubItems[1]);
      Desktop.Checked := StrToBool(Item.SubItems[2]);
      QuickLaunchBar.Checked := StrToBool(Item.SubItems[3]);
    end;
  finally
    
    PlatformMenu.OnClick := PlatformMenuClick;
  end;
end;

procedure TQuickStartWizard.ShortcutsEdited(Sender: TObject; Item: TListItem;
  var S: string);
begin
  Next.Default := True;
end;

procedure TQuickStartWizard.ShortcutsEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit := Item.Checked = True;
  if AllowEdit then
    Next.Default := false;
end;

procedure TQuickStartWizard.ShortcutsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 113 then
    if Shortcuts.Selected <> nil then
      Shortcuts.Selected.EditCaption;
end;

procedure TQuickStartWizard.PlatformMenuClick(Sender: TObject);
begin
  if Shortcuts.Selected = nil then Exit;
  Shortcuts.Selected.SubItems[1] := BoolToStr(PlatformMenu.Checked);
  SetListItemOverlay(Shortcuts.Selected);
end;

end.
