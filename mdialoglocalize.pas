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
unit mdialoglocalize;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  ShellAPI, Mask, Windows,
{$ELSE}
  Masks, LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, mUtils, FileLbl, MaskEdit, ShellCtrls,
  Variants, Classes, Graphics, Controls, Forms, RunFus, FDMain,
  Dialogs, ExtCtrls, StdCtrls, Buttons, CheckLst, FileCtrl, ComCtrls,
  ToolForm, Design{$IFDEF WINDOWS}, ShellAPI{$ENDIF};

type

  TDialogLocalize = class(TForm)
    Bevel2: TBevel;
    Cancel: TBitBtn;
    Error: TPage;
    Export1: TPage;
    Export2: TPage;
    Import1: TPage;
    Import2: TPage;
    Import3: TPage;
    Localize1: TPage;
    Localize2: TPage;
    Localize3: TPage;
    Next: TBitBtn;
    Back: TBitBtn;
    Notebook: TNotebook;
    Export: TRadioButton;
    Import: TRadioButton;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    ImportFolder: TEdit;
    BitBtn4: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    ExportFolder: TEdit;
    Langs: TCheckListBox;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Label6: TLabel;
    DoingWork: TLabel;
    Image1: TImage;
    Shape2: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Bevel4: TBevel;
    Panel1: TPanel;
    Label13: TLabel;
    Label16: TLabel;
    Image8: TImage;
    Label17: TLabel;
    Bevel5: TBevel;
    Panel2: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Image9: TImage;
    Bevel6: TBevel;
    Panel3: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Image10: TImage;
    Bevel7: TBevel;
    Panel4: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    Image11: TImage;
    Bevel8: TBevel;
    Panel5: TPanel;
    Label24: TLabel;
    Label25: TLabel;
    Image12: TImage;
    Image13: TImage;
    Shape3: TShape;
    Label26: TLabel;
    Label27: TLabel;
    Image16: TImage;
    Shape4: TShape;
    Label28: TLabel;
    Label29: TLabel;
    Label14: TLabel;
    Image14: TImage;
    Image3: TImage;
    Label15: TLabel;
    Image5: TImage;
    Image2: TImage;
    Label30: TLabel;
    Image4: TImage;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Shape1: TShape;
    Label31: TLabel;
    Localize: TRadioButton;
    BitBtn7: TBitBtn;
    Bevel1: TBevel;
    Panel6: TPanel;
    Label36: TLabel;
    Label37: TLabel;
    Image6: TImage;
    Label38: TLabel;
    AutoFolder: TEdit;
    Label39: TLabel;
    Image7: TImage;
    AutoLanguages: TCheckListBox;
    Bevel3: TBevel;
    Panel7: TPanel;
    Label40: TLabel;
    Label41: TLabel;
    Image15: TImage;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Label42: TLabel;
    Image17: TImage;
    Label43: TLabel;
    Label44: TLabel;
    Image18: TImage;
    Label45: TLabel;
    Label46: TLabel;
    Image19: TImage;
    Shape5: TShape;
    Label47: TLabel;
    Label35: TLabel;
    Label48: TLabel;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    Task: TPage;
    Welcome: TPage;
    Work: TPage;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    
  public
    procedure SetControls(First, Last: Boolean);
    function DoExport(Path: String): Boolean;
    function GetFormStrings(Form: String): TStrings; 
    function GetFormStringsEx(Form: String): TStrings; 
    function ReconcileTrans(NewFile, PreserveFile: String): Boolean; 
  end;

var
  DialogLocalize: TDialogLocalize;
  OldMap, OldIndex: TStringList;

implementation

{$IFnDEF FPC}
  {$R *.lfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

uses
  uGui, mproject;

resourcestring
  
  SUnableToCreateAccessFolder = 'Unable to create/access folder';
  SThisFolderAlreadyContainsPreviou = 'This folder already contains previously exported translations for the current project. Would you like to preserve existing translation data?'#13#13;
  SYesPreserveExistingTranslationsA = 'Yes: Preserve existing translations, adding new items as necessary.'#13;
  SNoOverwriteAllPreviousTranslatio = 'No: Overwrite all previous translations.'#13;
  SCancelDoNothing = 'Cancel: Do nothing.';
  SUnableToAccessFolder = 'Unable to access folder';
  SFolderDoesNotSeemToContainTransl = 'Folder does not seem to contain translations for current project'#13#13;
  SExpectedTranslationIndexFileNotF = 'Expected translation index file not found:'#13;
  SExpectedTranslationMapFileNotFou = 'Expected translation map file not found:'#13;
  SFolderDoesNotContainAnyLocalizat = 'Folder does not contain any (exported) localizations';
  SPleaseChooseAtLeastOneLanguageFo = 'Please choose at least one language for localization or import';
  SProjectAlreadyContainsPreviously = 'Project already contains previously imported translations.'#13'Would you like to discard them and import new translations?';
  SNext = '&Next >';
  SFinish = '&Finish';
  SExportToFolder = 'Export to Folder';
  SImportFromFolder = 'Import from Folder';
  SDialog = 'Dialog: ';
  SUnableToReconcileTranslationsPle = 'Unable to reconcile translations. Please try your export again into a different folder. Be sure to use the correct folder that already contains translations for your project.';

function RightAnsiPos(SubStr, s: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  while AnsiPos(SubStr, s) <> 0 do
  begin
    i := AnsiPos(SubStr, s);
    Delete(s, 1, i);
    if i <> 0 then Result := Result +i;
  end;
end;

procedure TDialogLocalize.FormShow(Sender: TObject);
begin
  ui.PushStatusStack('Localizing project');
  
  Notebook.PageIndex := Notebook.Pages.IndexOf('Welcome'); 
  SetControls(True, false);
  Export.Checked := True;
end;

procedure TDialogLocalize.NextClick(Sender: TObject);
var
  i: Integer;
  l: TStringList;
  lX, lY: TStringList;
  t, tX: TextFile;
  s, sX: String;
  j: Integer;
  BOM: Char;
begin
  if Notebook.ActivePage = 'Welcome' then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Task'); 
    SetControls(false, false);
    Exit;
  end;
  if Notebook.ActivePage = 'Task' then 
  begin
    if Export.Checked then
      Notebook.PageIndex := Notebook.Pages.IndexOf('Export1') 
    else  
    if Localize.Checked then
      Notebook.PageIndex := Notebook.Pages.IndexOf('Localize1')
    else
      Notebook.PageIndex := Notebook.Pages.IndexOf('Import1'); 
    SetControls(false, false);
    Exit;
  end;
  if Notebook.ActivePage = 'Export1' then 
  begin
    if ((ExportFolder.Text = '') or (not ForceDirectories(ExportFolder.Text)))
      or (not DirectoryExists(ExportFolder.Text)) then
    begin
      Application.MessageBox(PChar(SUnableToCreateAccessFolder),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    OldMap.Clear;
    OldIndex.Clear;
    if MyFileExists(AssertDir(ExportFolder.Text) + ProjectStruct.Name + '.mtx') then
      if MyFileExists(AssertDir(ExportFolder.Text) + 'translations.Map') then
      begin
        i := Application.MessageBox(PChar(SThisFolderAlreadyContainsPreviou +
          SYesPreserveExistingTranslationsA +
          SNoOverwriteAllPreviousTranslatio +
          SCancelDoNothing), PChar(Application.Title), mb_YesNoCancel + mb_IconQuestion);
        if i = id_Cancel then Exit;
        if i = id_Yes then
        begin
          OldIndex.LoadFromFile(AssertDir(ExportFolder.Text) + ProjectStruct.Name + '.mtx', TEncoding.UTF8);
          OldMap.LoadFromFile(AssertDir(ExportFolder.Text) + 'translations.Map', TEncoding.UTF8);
        end;
      end;
    Back.Enabled := false;
    Next.Enabled := false;
    Cancel.Enabled := false;
    DoingWork.Caption := '';
    Label24.Caption := 'Exporting...';
    Notebook.PageIndex := Notebook.Pages.IndexOf('Work'); 
    Application.ProcessMessages;
    
    if not DoExport(AssertDir(ExportFolder.Text)) then
    begin
      Notebook.PageIndex := Notebook.Pages.IndexOf('Error'); 
      SetControls(false, True);
      Exit;
    end;
    
    FileCopyBundle(EXEDIR + 'trans' + PathDelim + 'mTranslator', AssertDir(ExportFolder.Text) + 'mTranslator');
    
    l := FindAllFilesEx(EXEDIR + 'trans' + PathDelim + 'translations.*', false); 
    for i := 1 to l.Count do
      if CompareText(ExtractFileExtOnly(l[i -1]), 'map') <> 0 then 
        if CompareText(ExtractFileExtOnly(l[i -1]), 'original') <> 0 then 
          if CompareText(ExtractFileExtOnly(l[i -1]), 'definition') <> 0 then 
          begin
            if (OldMap.Count = 0) or not MyFileExists(AssertDir(ExportFolder.Text) + 'translations.' + ExtractFileExtOnly(l[i -1])) then
              FileCopyFile(PChar(AssertDir(ExportFolder.Text) + 'translations.Original'),
                PChar(AssertDir(ExportFolder.Text) + 'translations.' + ExtractFileExtOnly(l[i -1])),
                false)
            else
              if not ReconcileTrans(AssertDir(ExportFolder.Text) + 'translations.Original',
                AssertDir(ExportFolder.Text) + 'translations.' + ExtractFileExtOnly(l[i -1])) then
              begin
                ModalResult := mrCancel;
                Exit;
              end;
          end;
    l.Free;
    Notebook.PageIndex := Notebook.Pages.IndexOf('Export2'); 
    SetControls(false, True);
    Exit;
  end;
  if Notebook.ActivePage = 'Error' then 
    ModalResult := mrOk;
  if ((Notebook.ActivePage = 'Export2') or 
    (Notebook.ActivePage = 'Import3')) or
    (Notebook.ActivePage = 'Localize3') then 
  begin
    ModalResult := mrOk;
  end;
  if Notebook.ActivePage = 'Import1' then 
  begin
    
    if (ImportFolder.Text = '') or (not DirectoryExists(ImportFolder.Text)) then
    begin
      Application.MessageBox(PChar(SUnableToAccessFolder),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    ImportFolder.Text := AssertDir(ImportFolder.Text);
    if not MyFileExists(ImportFolder.Text + 
      ProjectStruct.Name + '.mtx') then 
    begin
      Application.MessageBox(PChar(SFolderDoesNotSeemToContainTransl +
        SExpectedTranslationIndexFileNotF +
        ImportFolder.Text + ProjectStruct.Name + '.mtx'), 
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    if not MyFileExists(ImportFolder.Text + 'translations.Map') then 
    begin
      Application.MessageBox(PChar(SFolderDoesNotSeemToContainTransl +
        SExpectedTranslationMapFileNotFou +
        ImportFolder.Text + 'translations.Map'), 
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    
    l := FindAllFilesEx(ImportFolder.Text + 'translations.*', false); 
    Langs.Items.Clear;
    for i := 1 to l.Count do
      if CompareText(ExtractFileExtOnly(l[i -1]), 'map') <> 0 then 
        if CompareText(ExtractFileExtOnly(l[i -1]), 'original') <> 0 then 
          if CompareText(ExtractFileExtOnly(l[i -1]), 'definition') <> 0 then 
            Langs.Items.Add(ExtractFileExtOnly(l[i -1]));
    Langs.Sorted := True;
    l.Free;
    if Langs.Items.Count = 0 then
    begin
      Application.MessageBox(PChar(SFolderDoesNotContainAnyLocalizat),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    Notebook.PageIndex := Notebook.Pages.IndexOf('Import2'); 
    SetControls(false, false);
    Exit;
  end;
  if Notebook.ActivePage = 'Localize1' then 
  begin
    
    if (AutoFolder.Text = '') or (not DirectoryExists(AutoFolder.Text)) then
    begin
      Application.MessageBox(PChar(SUnableToAccessFolder),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    AutoFolder.Text := AssertDir(AutoFolder.Text);
    if not MyFileExists(AutoFolder.Text +
      ProjectStruct.Name + '.mtx') then 
    begin
      Application.MessageBox(PChar(SFolderDoesNotSeemToContainTransl +
        SExpectedTranslationIndexFileNotF +
        AutoFolder.Text + ProjectStruct.Name + '.mtx'), 
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    if not MyFileExists(AutoFolder.Text + 'translations.Map') then 
    begin
      Application.MessageBox(PChar(SFolderDoesNotSeemToContainTransl +
        SExpectedTranslationMapFileNotFou +
        AutoFolder.Text + 'translations.Map'), 
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    
    l := FindAllFilesEx(AutoFolder.Text + 'translations.*', false); 
    AutoLanguages.Items.Clear;
    for i := 1 to l.Count do
      if CompareText(ExtractFileExtOnly(l[i -1]), 'map') <> 0 then 
        if CompareText(ExtractFileExtOnly(l[i -1]), 'original') <> 0 then 
          if CompareText(ExtractFileExtOnly(l[i -1]), 'definition') <> 0 then 
            if MyFileExists(EXEDIR + 'reference.' + ExtractFileExtOnly(l[i -1])) then
              AutoLanguages.Items.Add(ExtractFileExtOnly(l[i -1]));
    AutoLanguages.Sorted := True;
    l.Free;
    if AutoLanguages.Items.Count = 0 then
    begin
      Application.MessageBox(PChar(SFolderDoesNotContainAnyLocalizat),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    Notebook.PageIndex := Notebook.Pages.IndexOf('Localize2'); 
    SetControls(false, false);
    Exit;
  end;
  if Notebook.ActivePage = 'Import2' then 
  begin
    
    for i := 1 to Langs.Count do
      if Langs.Checked[i -1] then Break
      else
        if i = Langs.Count then
        begin
          Application.MessageBox(PChar(SPleaseChooseAtLeastOneLanguageFo),
            PChar(Application.Title), mb_Ok + mb_IconStop);
          Exit;
        end;
    
    for i := 1 to SupportFiles.Count do
      if CompareText(ProjectStruct.Name + '.mtx', 
        SupportFiles[i -1]) = 0 then
      begin
        if Application.MessageBox(PChar(SProjectAlreadyContainsPreviously),
          PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_No then Exit
        else
          Break;
      end;
    DoingWork.Caption := '';
    Label24.Caption := 'Importing...';
    Notebook.PageIndex := Notebook.Pages.IndexOf('Work'); 
    Application.ProcessMessages;
    
    l := FindAllFilesEx(EXEDIR + 'trans' + PathDelim + 'translations.*', false); 
    for i := 1 to l.Count do
      l[i -1] := AnsiLowerCase(ExtractFileName(l[i -1]));
    l.Add('translations.map'); 
    l.Add('translations.original'); 
    l.Add(AnsiLowerCase(ProjectStruct.Name + '.mtx')); 
    for i := SupportFiles.Count downto 1 do
      if l.IndexOf(AnsiLowerCase(SupportFiles[i -1])) <> -1 then
      begin
        DeleteFile(PROJDIR + SupportFiles[i -1]);
        SupportFiles.Delete(i -1);
      end;
    l.Free;
    
    FileCopyFile(PChar(ImportFolder.Text + 'translations.Map'), 
      PChar(PROJDIR + 'translations.Map'), false); 
    SupportFiles.Add('translations.Map'); 
    FileCopyFile(PChar(ImportFolder.Text + 'translations.Original'), 
      PChar(PROJDIR + 'translations.Original'), false); 
    SupportFiles.Add('translations.Original'); 
    for i := 1 to Langs.Count do
      if Langs.Checked[i -1] then
      begin
        FileCopyFile(PChar(ImportFolder.Text + 'translations.' + Langs.Items[i -1]), 
          PChar(PROJDIR + 'translations.' + Langs.Items[i -1]), false); 
        SupportFiles.Add('translations.' + Langs.Items[i -1]); 
      end;
    FileCopyFile(PChar(ImportFolder.Text + ProjectStruct.Name + '.mtx'), 
      PChar(PROJDIR + ProjectStruct.Name + '.mtx'), false); 
    SupportFiles.Add(ProjectStruct.Name + '.mtx'); 
    
    ui.SetDirtyMPR(True);
    Project.SetSupport(SupportFiles);
    Notebook.PageIndex := Notebook.Pages.IndexOf('Import3'); 
    SetControls(false, True);
    Exit;
  end;
  if Notebook.ActivePage = 'Localize2' then 
  begin
    
    for i := 1 to AutoLanguages.Count do
      if AutoLanguages.Checked[i -1] then Break
      else
        if i = AutoLanguages.Count then
        begin
          Application.MessageBox(PChar(SPleaseChooseAtLeastOneLanguageFo),
            PChar(Application.Title), mb_Ok + mb_IconStop);
          Exit;
        end;
    DoingWork.Caption := '';
    Label24.Caption := 'Translating...';
    lX := TStringList.Create;
    lY := TStringList.Create;
    for i := 1 to AutoLanguages.Count do
      if AutoLanguages.Checked[i -1] then
      begin
        lX.Clear;
        lX.LoadFromFile(AutoFolder.Text + 'translations.' + AutoLanguages.Items[i -1], TEncoding.UTF8);
        lY.Clear;
        lY.LoadFromFile(EXEDIR + 'trans' + PathDelim + 'translations.' + AutoLanguages.Items[i -1], TEncoding.UTF8);
        FileMode := 0;
        AssignFile(t, EXEDIR + 'reference.' + AutoLanguages.Items[i -1],cp_utf8);
        AssignFile(tX, EXEDIR + 'reference.Original',cp_utf8);
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
        Reset(tX);
        if not eof(tX) then
        begin
          read(tX, BOM);
          if ansicomparetext(BOM, #$FEFF) <> 0 then
          begin
            closefile(tX);
            reset(tX);
          end;
        end;
        while not EOF(t) do
        begin
          ReadLn(t, s);
          ReadLn(tX, sX);
          for j := 1 to lX.Count do
            if lX[j -1] = sX then
              lX[j -1] := s;
          for j := 1 to lY.Count do
            if lY[j -1] = sX then
              lY[j -1] := s;
        end;
        CloseFile(t);
        CloseFile(tX);
        lX.SaveToFile(AutoFolder.Text + 'translations.' + AutoLanguages.Items[i -1], TEncoding.UTF8);
        lY.SaveToFile(EXEDIR + 'trans' + PathDelim + 'translations.' + AutoLanguages.Items[i -1], TEncoding.UTF8);
      end;
    lX.Free;
    lY.Free;
    Notebook.PageIndex := Notebook.Pages.IndexOf('Work'); 
    Application.ProcessMessages;
    Notebook.PageIndex := Notebook.Pages.IndexOf('Localize3'); 
    SetControls(false, True);
    Exit;
  end;
end;

procedure TDialogLocalize.SetControls(First, Last: Boolean);
begin
  Next.Caption := SNext;
  if First then
  begin
    Back.Enabled := false;
    Cancel.Enabled := True;
    Next.Enabled := True;
  end
  else
  if Last then
  begin
    
    Back.Enabled := false;
    Cancel.Enabled := false;
    Next.Enabled := True;
    Next.Caption := SFinish;
  end
  else
  begin
    Back.Enabled := True;
    Next.Enabled := True;
    Cancel.Enabled := True;
  end;
  if Notebook.ActivePage = 'Task' then 
  begin
  end;
  if Notebook.ActivePage = 'Export1' then 
  begin
  end;
  if Notebook.ActivePage = 'Export2' then 
  begin
  end;
  if Notebook.ActivePage = 'Import1' then 
  begin
  end;
  if Notebook.ActivePage = 'Import2' then 
  begin
  end;
  if Notebook.ActivePage = 'Import3' then 
  begin
  end;
  if Notebook.ActivePage = 'Localize1' then 
  begin
  end;
  if Notebook.ActivePage = 'Localize2' then 
  begin
  end;
  if Notebook.ActivePage = 'Localize3' then 
  begin
  end;
end;

procedure TDialogLocalize.BackClick(Sender: TObject);
begin
  if Notebook.ActivePage = 'Welcome' then 
  begin
    Exit; 
  end;
  if Notebook.ActivePage = 'Task' then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Welcome'); 
    SetControls(True, false);
  end;
  if ((Notebook.ActivePage = 'Export1') or 
    (Notebook.ActivePage = 'Import1')) or
    (Notebook.ActivePage = 'Localize1') then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Task'); 
    SetControls(false, false);
  end;
  if Notebook.ActivePage = 'Export2' then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Export1'); 
    SetControls(false, false);
  end;
  if Notebook.ActivePage = 'Import2' then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Import1'); 
    SetControls(false, false);
  end;
  if Notebook.ActivePage = 'Localize2' then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Localize1'); 
    SetControls(false, false);
  end;
  if Notebook.ActivePage = 'Import3' then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Import2'); 
    SetControls(false, false);
  end;
  if Notebook.ActivePage = 'Localize3' then 
  begin
    Notebook.PageIndex := Notebook.Pages.IndexOf('Localize2'); 
    SetControls(false, false);
  end;
end;

procedure TDialogLocalize.BitBtn10Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  ShellExecute(Handle, 'open', PChar(AssertDir(AutoFolder.Text) + 'mTranslator.exe'), 
    '', PChar('"' + PROJDIR + '"'), SW_SHOW);
  {$ELSE}
  {$IFDEF DARWIN}
  LaunchAppAndWait(AssertDir(AutoFolder.Text) + 'mTranslator.app/Contents/MacOS/mTranslator', '', True, false);
  {$ELSE}
  LaunchAppAndWait(AssertDir(AutoFolder.Text) + 'mTranslator', '', True, false);
  {$ENDIF}
  {$ENDIF}
end;

procedure TDialogLocalize.BitBtn11Click(Sender: TObject);
begin
  AutoFolder.Text := ExportFolder.Text;
  Notebook.PageIndex := Notebook.Pages.IndexOf('Task');
  Localize.Checked := True;
  NextClick(Self);
end;

procedure TDialogLocalize.BitBtn12Click(Sender: TObject);
begin
  ImportFolder.Text := AutoFolder.Text;
  Notebook.PageIndex := Notebook.Pages.IndexOf('Task');
  Import.Checked := True;
  NextClick(Self);
end;

procedure TDialogLocalize.BitBtn1Click(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory(SExportToFolder, '', s) then
    ExportFolder.Text := s;
end;

procedure TDialogLocalize.BitBtn4Click(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory(SImportFromFolder, '', s) then
    ImportFolder.Text := s;
end;

function TDialogLocalize.DoExport(Path: String): Boolean;

var
  i, j, k: Integer;
  l: TStrings;
  Map, Trans, Defs, Index: TextFile;
  WriteDefs: Boolean;

procedure GetCommandStrings(StringList: TStrings;
  ClassText, DisplayText, Indices: String; Period: Integer);
var
  i, j: Integer;
  l: TStringList;
begin
  if WriteDefs then 
  begin
    WriteLn(Defs, ClassText);
    WriteLn(Defs, DisplayText);
  end;
  if StringList.Count <> 0 then
  begin
    l := TStringList.Create;
    l.CommaText := Indices;
    for i := 1 to StringList.Count do
      if i mod Period = 1 then
        for j := 1 to l.Count do
        begin
          
            WriteLn(Index, StringList[i -1]);
          WriteLn(Trans, StringList[i + StrToInt(l[j -1])]);
          WriteLn(Map, ClassText);
        end;
    l.Free;
  end;
end;

begin
  Result := True;
  AssignFile(Index, Path + ProjectStruct.Name + '.mtx',cp_utf8); 
  ReWrite(Index);
  AssignFile(Trans, Path + 'translations.Original',cp_utf8); 
  ReWrite(Trans);
  AssignFile(Defs, Path + 'translations.Definition',cp_utf8); 
  ReWrite(Defs);
  AssignFile(Map, Path + 'translations.Map',cp_utf8); 
  ReWrite(Map);
  for i := 1 to DialogFiles.Count do
    if AnsiPos('.', ExtractFileNameOnly(DialogFiles[i -1])) = 0 then
    begin
      DoingWork.Caption := SDialog + ExtractFileName(DialogFiles[i -1]);
      Application.ProcessMessages;
      l := GetFormStringsEx(PROJDIR + DialogFiles[i -1]);
      for j := 1 to l.Count do
        if j mod 2 = 0 then
        begin
          WriteLn(Trans, l[j -1]);
          WriteLn(Index, l[j -2]);
          WriteLn(Map, ExtractFileName(DialogFiles[i -1]));
        end;
      if l.Count <> 0 then
      begin
        WriteLn(Defs, ExtractFileName(DialogFiles[i -1]));
        WriteLn(Defs, ExtractFileNameOnly(DialogFiles[i -1]) + ' Dialog'); 
      end;
      l.Free;
    end;
  
  try
    k := ui.CurrentUnit.TabIndex;
    for i := 1 to ui.CurrentUnit.Tabs.Count -1 do
    begin
      if i >= ui.CurrentUnit.Tabs.Count then
      begin
        
        CloseFile(Map);
        CloseFile(Defs);
        CloseFile(Trans);
        CloseFile(Index);
        Result := false;
        Exit;
      end;
      DoingWork.Caption := 'Script: ' + ui.CurrentUnit.Tabs[i]; 
      Application.ProcessMessages;
      
      ui.CurrentUnit.TabIndex := i;
      
      WriteDefs := i = 1;
      
      GetCommandStrings(SetVariable, 'SetVariable', 
        'Set Variable Commands', 
        '1', 3);
      GetCommandStrings(LocVar, 'LocVariable', 
        'Localized Variable Commands', 
        '1', 3);
      GetCommandStrings(FileType, 'FileType', 
        'Create (Advertised) File Type Commands', 
        '0,2', 8); 
      GetCommandStrings(Short, 'Shortcut', 
        'Create (Advertised) Shortcut Commands', 
        '1,3', 10); 
      
      GetCommandStrings(DefComponent, 'DefComponent', 
        'Define Component Commands', 
        '0,2', 4); 
      GetCommandStrings(GetComponent, 'GetComponent', 
        'Get Component Selection State Commands', 
        '0', 3);
      
      GetCommandStrings(xMessageBox, 'xMessageBox', 
        'MessageBox Commands', 
        '0,1', 6); 
      
      GetCommandStrings(SetComponent, 'SetComponent', 
        'Set Component Selection Commands', 
        '0', 3);
      GetCommandStrings(SpaceFeatures, 'SpaceFeatures', 
        'Set Component Space Commands', 
        '0', 3);
      GetCommandStrings(xIf, 'If', 
        'If Commands', 
        '0,2', 5); 
      GetCommandStrings(xWhile, 'While', 
        'While Commands', 
        '0,2', 5); 
      GetCommandStrings(xUntil, 'Until', 
        'Until Commands', 
        '0,2', 5); 
      
      GetCommandStrings(DelComp, 'DelComp', 
        'Delete Component Commands', 
        '0', 2);
      GetCommandStrings(SetVisibility, 'HideComp', 
        'Set Component Visibility Commands', 
        '0', 3);
      GetCommandStrings(SetChoice, 'BarComp', 
        'Set Component Choice Commands', 
        '0', 3);
      GetCommandStrings(GetSpace, 'GetSpace', 
        'Get Component Space Commands', 
        '0', 3);
      
      GetCommandStrings(xPromptForText, 'Prompt for Text', 
        'Prompt for Text Commands', 
        '0,2', 4);
      GetCommandStrings(xBrowseFile, 'Browse for File', 
        'Browse for File Commands', 
        '0,6', 8);
      GetCommandStrings(xBrowseFolder, 'Browse for Folder', 
        'Browse for Folder Commands', 
        '0', 4);
      
      GetCommandStrings(FormatStr, 'Format String', 
        'Format String Commands', 
        '1', 4);
      GetCommandStrings(RegEx, 'Match Regular Expression', 
        'Match Regular Expression Commands', 
        '1', 4);
      
    end;
  finally
    ui.CurrentUnit.TabIndex := k;
  end;
  CloseFile(Map);
  CloseFile(Defs);
  CloseFile(Trans);
  CloseFile(Index);
end;

function TDialogLocalize.GetFormStrings(Form: String): TStrings;
var
  s, t: TFileStream;
  r: TextFile;
  TempForm: String;
  ObjectName, PropertyName: String;
  BOM: Char;
begin
  Result := TStringList.Create;
  
  TempForm := TEMPDIR + ExtractFileNameOnly(Form) + '.dfmx'; 
  Result := TStringList.Create;
  try
    s := TFileStream.Create(Form, fmOpenRead or fmShareDenyWrite);
    t := TFileStream.Create(TempForm, fmCreate or fmShareExclusive);
    ObjectResourceToText(s, t);
    t.Free;
    s.Free;
  except
    s.Free;
    t.Free;
    FileCopyFile(PChar(Form), PChar(TempForm), false); 
  end;
  
  AssignFile(r, TempForm,cp_utf8);
  Reset(r);
  if not eof(r) then
  begin
    read(r, BOM);
    if ansicomparetext(BOM, #$FEFF) <> 0 then
    begin
      closefile(r);
      reset(r);
    end;
  end;
  while not EOF(r) do
  begin
    ReadLn(r, PropertyName);
    
    if (AnsiPos('object', PropertyName) <> 0) and 
      (AnsiPos(':', PropertyName) <> 0) then
    begin
      if AnsiPos('object', PropertyName) = 1 then 
        ObjectName := ExtractFileName(Form) 
      else
      begin
        Delete(PropertyName, AnsiPos('object', PropertyName), Length('object')); 
        Delete(PropertyName, AnsiPos(':', PropertyName), Length(PropertyName));
        ObjectName := Trim(PropertyName);
      end;
    end
    
    else
      if (AnsiPos('Caption = ', PropertyName) <> 0) or 
        (AnsiPos('Text = ', PropertyName) <> 0) then 
      begin
        
        if AnsiPos('Caption = ', PropertyName) <> 0 then 
          Delete(PropertyName, AnsiPos('Caption = ', PropertyName), Length('Caption = ')) 
        else
          Delete(PropertyName, AnsiPos('Text = ', PropertyName), Length('Text = ')); 
        
        if AnsiPos('''', PropertyName) <> RightAnsiPos('''', PropertyName) then
        begin
          
          PropertyName := Trim(PropertyName);
          if PropertyName <> '' then
          begin
            Result.Add(ObjectName);
            Result.Add(PropertyName);
          end;
        end;
      end;
  end;
  CloseFile(r);
  DeleteFile(TempForm);
end;

function TDialogLocalize.GetFormStringsEx(Form: String): TStrings;
var
  
  s: String;
  i: Integer;
  frmDesignX: TfrmDesign;
  
  rdi: TRFInspector;
begin
  Result := TStringList.Create;
  
  rdi := TRFInspector.Create(nil);
  
  RegisterClasses([TLabel,TEdit,TMemo,TButton,TListBox,TCheckBox,TRadioButton,
    TComboBox,TGroupBox,TPanel,TBitBtn,TSpeedButton,TMaskEdit,TImage,TShape,
    TBevel,TStaticText,TFileLabel,TTrackBar,TProgressBar,TUpDown,TCheckListBox,TTreeView,
    TShellTreeView,TScrollBox]);
  frmToolForm := TfrmToolForm.Create(nil);
  frmDesignX := TfrmDesign.Create(nil);
  
  GetDir(0, s);
  ChDir(ExtractFilePath(Form));
  
  frmDesignX.cmpFormDesigner.LoadFromDFM(Form, dfmText);
  ChDir(s);
  
  Result.Add(ExtractFileName(Form));
  Result.Add(frmDesignX.Caption);
  for i := frmDesignX.ComponentCount downto 1 do
  begin
    
    if frmDesignX.Components[i -1] is TTabSheet then
    begin
      Result.Add(TTabSheet(frmDesignX.Components[i -1]).Name);
      Result.Add(TTabSheet(frmDesignX.Components[i -1]).Caption);
    end
    else
    if frmDesignX.Components[i -1] is TLabel then
    begin
      Result.Add(TLabel(frmDesignX.Components[i -1]).Name);
      Result.Add(TLabel(frmDesignX.Components[i -1]).Caption);
    end
    else
    if frmDesignX.Components[i -1] is TFileLabel then
    begin
      Result.Add(TFileLabel(frmDesignX.Components[i -1]).Name);
      Result.Add(TFileLabel(frmDesignX.Components[i -1]).FileName);
    end
    else
    
    if frmDesignX.Components[i -1] is TPanel then
    begin
      Result.Add(TPanel(frmDesignX.Components[i -1]).Name);
      Result.Add(TPanel(frmDesignX.Components[i -1]).Caption);
    end
    else
    if frmDesignX.Components[i -1] is TGroupBox then
    begin
      Result.Add(TGroupBox(frmDesignX.Components[i -1]).Name);
      Result.Add(TGroupBox(frmDesignX.Components[i -1]).Caption);
    end
    else
    if frmDesignX.Components[i -1] is TStaticText then
    begin
      Result.Add(TStaticText(frmDesignX.Components[i -1]).Name);
      Result.Add(TStaticText(frmDesignX.Components[i -1]).Caption);
    end
    else
    if frmDesignX.Components[i -1] is TButton then
    begin
      Result.Add(TButton(frmDesignX.Components[i -1]).Name);
      Result.Add(TButton(frmDesignX.Components[i -1]).Caption);
    end
    else
    
    if frmDesignX.Components[i -1] is TSpeedButton then
    begin
      Result.Add(TSpeedButton(frmDesignX.Components[i -1]).Name);
      Result.Add(TSpeedButton(frmDesignX.Components[i -1]).Caption);
    end
    else
    if frmDesignX.Components[i -1] is TBitBtn then
    begin
      Result.Add(TBitBtn(frmDesignX.Components[i -1]).Name);
      Result.Add(TBitBtn(frmDesignX.Components[i -1]).Caption);
    end
    else
    
    if frmDesignX.Components[i -1] is TListBox then
    begin
      Result.Add(TListBox(frmDesignX.Components[i -1]).Name);
      Result.Add(MultiLineToSingleLine(TListBox(frmDesignX.Components[i -1]).Items.Text));
    end
    else
    if frmDesignX.Components[i -1] is TCheckListBox then
    begin
      Result.Add(TCheckListBox(frmDesignX.Components[i -1]).Name);
      Result.Add(MultiLineToSingleLine(TCheckListBox(frmDesignX.Components[i -1]).Items.Text));
    end
    else
    if frmDesignX.Components[i -1] is TComboBox then
    begin
      Result.Add(TComboBox(frmDesignX.Components[i -1]).Name);
      Result.Add(MultiLineToSingleLine(TComboBox(frmDesignX.Components[i -1]).Items.Text));
    end
    else
    if frmDesignX.Components[i -1] is TEdit then
    begin
      Result.Add(TEdit(frmDesignX.Components[i -1]).Name);
      Result.Add(TEdit(frmDesignX.Components[i -1]).Text);
    end
    else
    if frmDesignX.Components[i -1] is TMaskEdit then
    begin
      Result.Add(TMaskEdit(frmDesignX.Components[i -1]).Name);
      Result.Add(TMaskEdit(frmDesignX.Components[i -1]).Text);
    end;
  end;
  
  frmDesignX.Free;
  frmToolForm.Free;
  rdi.Free; 
end;

procedure TDialogLocalize.BitBtn2Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  ShellExecute(Handle, 'open', PChar(AssertDir(ExportFolder.Text) + 'mTranslator.exe'), 
    '', PChar('"' + PROJDIR + '"'), SW_SHOW);
  {$ELSE}
  {$IFDEF DARWIN}
  LaunchAppAndWait(AssertDir(ExportFolder.Text) + 'mTranslator.app/Contents/MacOS/mTranslator', '', True, false);
  {$ELSE}
  LaunchAppAndWait(AssertDir(ExportFolder.Text) + 'mTranslator', '', True, false);
  {$ENDIF}
  {$ENDIF}
end;

procedure TDialogLocalize.BitBtn5Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to Langs.Count do
    Langs.Checked[i -1] := false;
end;

procedure TDialogLocalize.BitBtn3Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to Langs.Count do
    Langs.Checked[i -1] := True;
end;

procedure TDialogLocalize.BitBtn6Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  ShellExecute(Handle, 'open', PChar(AssertDir(EXEDIR) + 'trans\mTranslator.exe'), 
    '', PChar('"' + PROJDIR + '"'), SW_SHOW);
  {$ELSE}
  {$IFDEF DARWIN}
  LaunchAppAndWait(AssertDir(EXEDIR) + 'trans/mTranslator.app/Contents/MacOS/mTranslator', '', True, false);
  {$ELSE}
  LaunchAppAndWait(AssertDir(EXEDIR) + 'trans/mTranslator', '', True, false);
  {$ENDIF}
  {$ENDIF}
end;

procedure TDialogLocalize.BitBtn7Click(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory('Automatic Translation Folder', '', s) then
    AutoFolder.Text := s;
end;

procedure TDialogLocalize.BitBtn8Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to AutoLanguages.Count do
    AutoLanguages.Checked[i -1] := True;
end;

procedure TDialogLocalize.BitBtn9Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to AutoLanguages.Count do
    AutoLanguages.Checked[i -1] := false;
end;

function TDialogLocalize.ReconcileTrans(NewFile, PreserveFile: String): Boolean;
var
  fNew, fFinal, fPreserve, fIndex, fMap: TextFile;
  lPreserve: TStringList;
  s1, s2, sX: String;
  i, j: Integer;
  guidRepeat: Integer;
  lastGuid: String;
  BOM: Char;
begin
  try
    Result := True;
    lPreserve := TStringList.Create;
    lPreserve.LoadFromFile(PreserveFile, TEncoding.UTF8);
    AssignFile(fNew, NewFile,cp_utf8);
    Reset(fNew);
    if not eof(fNew) then
    begin
      read(fNew, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(fNew);
        reset(fNew);
      end;
    end;
    AssignFile(fPreserve, PreserveFile,cp_utf8);
    AssignFile(fFinal, PreserveFile + '.out',cp_utf8); 
    ReWrite(fFinal);
    AssignFile(fIndex, AssertDir(ExtractFilePath(NewFile)) +
      ProjectStruct.Name + '.mtx',cp_utf8); 
    Reset(fIndex);
    if not eof(fIndex) then
    begin
      read(fIndex, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(fIndex);
        reset(fIndex);
      end;
    end;
    AssignFile(fMap, AssertDir(ExtractFilePath(NewFile)) +
      'translations.Map',cp_utf8); 
    Reset(fMap);
    if not eof(fMap) then
    begin
      read(fMap, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(fMap);
        reset(fMap);
      end;
    end;
    guidRepeat := -1;
    lastGuid := '';
    while not EOF(fIndex) do
    begin
      ReadLn(fIndex, s1);
      ReadLn(fMap, s2);
      ReadLn(fNew, sX);
      if CompareText(ExtractFileExt(s2), '.dfm') = 0 then 
        guidRepeat := -1 
      else
        if lastGuid <> s1 then
        begin
          guidRepeat := 0; 
          lastGuid := s1; 
        end;
      for i := 1 to OldIndex.Count do
        if CompareText(OldIndex[i -1], s1) = 0 then
          if CompareText(OldMap[i -1], s2) = 0 then
          begin
            if guidRepeat = -1 then
              sX := lPreserve[i -1]
            else
            begin
              sX := lPreserve[i -1 + guidRepeat];
              guidRepeat := guidRepeat +1;
            end;
            Break;
          end;
      WriteLn(fFinal, sX);
    end;
    CloseFile(fMap);
    CloseFile(fIndex);
    CloseFile(fFinal);
    CloseFile(fNew);
    Erase(fPreserve);
    Rename(fFinal, PreserveFile);
    lPreserve.Free;
  except
    Application.MessageBox(PChar(SUnableToReconcileTranslationsPle),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Result := false;
  end;
end;

procedure TDialogLocalize.FormCreate(Sender: TObject);
begin
  if MyFileExists(EXEDIR + 'dbwork.avi') then 
  begin
    
  end;
end;

procedure TDialogLocalize.FormHide(Sender: TObject);
begin
  ui.PopStatusStack;
end;

initialization
  OldMap := TStringList.Create;
  OldIndex := TStringList.Create;

finalization
  if Assigned(OldMap) then
    FreeAndNil(OldMap);
  if Assigned(OldIndex) then
    FreeAndNil(OldIndex);

end.

