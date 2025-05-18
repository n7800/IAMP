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
unit mchangetheme;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TChangeTheme = class(TForm)
    Label41: TLabel;
    ThemeText: TLabel;
    Theme: TComboBox;
    BitBtn9: TBitBtn;
    GroupBox1: TGroupBox;
    DlgPreview: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ThemeParentText: TLabel;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ThemeChange(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    
  public
    
  end;

var
  ChangeTheme: TChangeTheme;

implementation

uses
  mproject, mUtils, uGui;

resourcestring
  SNoSetupThemesHaveBeenInstalled1O = 'No setup themes have been installed.'#13#13'1. Open the Control Panel "Add-Remove Programs" applet,'#13'2. Choose the "Change" option for InstallAware,'#13'3. Select "Add or Remove Features" and choose at least one setup theme.';
  SWarningAllCustomizationsMadeToYo = 'Warning: All customizations made to your existing dialogs will be lost!';
  SAreYouSureYouWantToOverwriteAllY = 'Are you sure you want to overwrite all your dialogs with base versions from the ';
  STheme = ' theme?';
  SApplyNewTheme = 'Apply New Theme?';
  SNoteNotAllDialogsInYourCurrentTh = 'Note: Not all dialogs in your current theme are available in the new theme. You will have to manually remake some of your current dialogs to fit in with the new style.';
  SWouldYouStillLikeToChangeToTheNe = 'Would you still like to change to the new theme?';

{$R *.lfm}

procedure TChangeTheme.BitBtn3Click(Sender: TObject);
begin
  OpenURL('https://www.installaware.com/getthemes.asp'); 
end;

procedure TChangeTheme.BitBtn9Click(Sender: TObject);
begin
   OpenDocument(PChar(EXEDIR + 'Dialogs' + PathDelim + Theme.Text + PathDelim + 
    Theme.Text)); 
end;

procedure TChangeTheme.ThemeChange(Sender: TObject);
var
  s: String;
  t: TextFile;
  BOM: Char;
begin
  if Theme.Text = '' then Exit;
  DlgPreview.AutoSize := True;
  if MyFileExists(EXEDIR + 'Dialogs' + PathDelim + Theme.Text + PathDelim + 'ad.bmp') then
    DlgPreview.Picture.Bitmap.LoadFromFile(
      EXEDIR + 'Dialogs' + PathDelim + Theme.Text + PathDelim + 'ad.bmp'); 
  if Forms.Screen.PixelsPerInch <> 96 then
  begin
    DlgPreview.AutoSize := false;
    DlgPreview.Stretch := True;
    DlgPreview.Height := DlgPreview.Height +
      (GroupBox1.ClientWidth - (2* DlgPreview.Left)) - DlgPreview.Width;
    DlgPreview.Width := GroupBox1.ClientWidth - (2* DlgPreview.Left);
  end;
  if MyFileExists(EXEDIR + 'Dialogs' + PathDelim + Theme.Text + PathDelim + AnsiLowerCase(Theme.Text) + '.txt') then 
  begin
    FileMode := 0;
    AssignFile(t, EXEDIR + 'Dialogs' + PathDelim + Theme.Text + PathDelim + AnsiLowerCase(Theme.Text) + '.txt',cp_utf8); 
    Reset(t);
    if not eof(t) then
    begin
      read(t, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(t);
        reset(t);
      end;
    end;
    ReadLn(t, s);
    CloseFile(t);
    ThemeText.Caption := s;
    ThemeParentText.Caption := Theme.Text;
  end;
  BitBtn9.Enabled := MyFileExists(EXEDIR + 'Dialogs' + PathDelim + Theme.Text + PathDelim + Theme.Text
    {$IFDEF WINDOWS} + '.exe'
    {$ELSE}
    {$IFDEF DARWIN}
    + '.app/Contents/MacOS/' + Theme.Text
    {$ENDIF}
    {$ENDIF}
    ); 
end;

procedure TChangeTheme.BitBtn1Click(Sender: TObject);
var
  i, j, k: Integer;
  s, sX: String;
  l: TStringList;
  t: TextFile;
  BOM: Char;
begin
  if Theme.Items.Count = 0 then
  begin
    Application.MessageBox(PChar(SNoSetupThemesHaveBeenInstalled1O),
      PChar(Application.Title), mb_Ok + mb_IconExclamation);
    ModalResult := mrCancel;
    Exit;
  end;
  if Application.MessageBox(PChar(SWarningAllCustomizationsMadeToYo + MyLineEnding + MyLineEnding +
    SAreYouSureYouWantToOverwriteAllY + Theme.Text + STheme),
    PChar(SApplyNewTheme), mb_YesNo or mb_IconExclamation) = id_Yes then
  begin
    if CurrentProjectName = '' then
      s := EXEDIR
    else
      s := AssertDir(ExtractFilePath(CurrentProjectName));
    l := FindAllFilesEx(EXEDIR + 'Dialogs' + PathDelim + Theme.Text + PathDelim + '*', false); 
    k := id_Yes;
    for i := 1 to DialogFiles.Count do
      for j := 1 to l.Count do
        if CompareText(ExtractFileNameOnly(l[j -1]),
          ExtractFileNameOnly(DialogFiles[i -1])) = 0 then Break
        else
          if j = l.Count then
            if k <> id_No then
            begin
              if Application.MessageBox(PChar(SNoteNotAllDialogsInYourCurrentTh + MyLineEnding + MyLineEnding +
                SWouldYouStillLikeToChangeToTheNe), PChar(SApplyNewTheme),
                mb_YesNo + mb_IconQuestion) = id_No then
              begin
                l.Free;
                Exit;
              end
              else
                k := id_No;
            end;
    for i := 1 to l.Count do
      if AnsiLowerCase(ExtractFileExt(l[i -1])) = '.lfm' then 
        if DialogFiles.IndexOf(ExtractFileName(l[i -1])) <> -1 then
        begin
          FileCopyFile(PChar(l[i -1]), PChar(s + ExtractFileName(l[i -1])), false);
          FileCopyFile(PChar(l[i -1] + '.miaf'), PChar(s + ExtractFileName(l[i -1]) + '.miaf'), false); 
        end;
    l.Free;
    
    ui.SetDirtyMPR(True);
  end;
end;

procedure TChangeTheme.FormHide(Sender: TObject);
begin
  ui.PopStatusStack;
end;

procedure TChangeTheme.FormShow(Sender: TObject);
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  ui.PushStatusStack('Changing theme');
  
  l := FindAllFilesEx(EXEDIR + 'Dialogs' + PathDelim + '*', True); 
  Theme.Items.Clear;
  for i := 1 to l.Count do
  begin
    s := DeAssertDir(ExtractFilePath(l[i -1]));
    if DirectoryExists(s) then
    begin
      s := ExtractFileName(s);
      if Theme.Items.IndexOf(s) = -1 then
    
        Theme.Items.Add(s);
    end;
  end;
  l.Free;
  Theme.Style := csDropDown;
  Theme.Sorted := True;
  Theme.Style := csDropDownList;
  if Theme.Items.IndexOf('macOS') <> 0 then 
    Theme.ItemIndex := Theme.Items.IndexOf('macOS') 
  else
    Theme.ItemIndex := 0;
  ThemeChange(Self);
end;

end.

