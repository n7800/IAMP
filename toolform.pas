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
unit ToolForm;

{$MODE Delphi}

interface

uses
  Messages, SysUtils, MaskEdit, CheckLst, LCLType,
  Classes, Graphics, Controls, Forms, Dialogs, uDlgAPI,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, Clipbrd, Menus,
  RunFus, ToolWin, mUtils, FDAlPal, FileLbl, FileUtil,
  LCLIntf, ShellCtrls, FDMain, FDCmpPal;

resourcestring
  miAllow = 'Allow &Multiple Instances';
  miDeny = 'Disallow &Multiple Instances';

type

  TfrmToolForm = class(TForm)
    pgcMain: TPageControl;
    AppEx: TApplicationProperties;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N5: TMenuItem;
    Pages: TPageControl;
    sbtOpen: TSpeedButton;
    sbtSave: TSpeedButton;
    sbtLock: TSpeedButton;
    sbtCut: TSpeedButton;
    sbtCopy: TSpeedButton;
    sbtPaste: TSpeedButton;
    sbtDelete: TSpeedButton;
    opdMain: TOpenDialog;
    svdMain: TSaveDialog;
    pmnMain: TPopupMenu;
    mniLock: TMenuItem;
    mniAlignToGrid: TMenuItem;
    mniCut: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    mniDelete: TMenuItem;
    sbtSetup: TSpeedButton;
    sbtAbout: TSpeedButton;
    mniBringToFront: TMenuItem;
    mniSendToBack: TMenuItem;
    mniSep2: TMenuItem;
    mniSelectAll: TMenuItem;
    sbtTabOrder: TSpeedButton;
    sbtSelectAll: TSpeedButton;
    sbtObjectInspector: TSpeedButton;
    sbtNew: TSpeedButton;
    sbtTest: TSpeedButton;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ImageList: TImageList;
    Edot1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N2: TMenuItem;
    SelectAll1: TMenuItem;
    miLock: TMenuItem;
    TabOrder1: TMenuItem;
    Standard: TTabSheet;
    Additional: TTabSheet;
    Win32: TTabSheet;
    Tools1: TMenuItem;
    Options1: TMenuItem;
    ObjectInspector1: TMenuItem;
    TestDialog1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    N3: TMenuItem;
    View1: TMenuItem;
    AlignmentPalette1: TMenuItem;
    N4: TMenuItem;
    Align1: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    N6: TMenuItem;
    AllowMultipleInstances1: TMenuItem;
    N8: TMenuItem;
    procedure AppExException(Sender: TObject; E: Exception);
    function AppExHelp(Command: Word; Data: PtrInt; var CallHelp: Boolean
      ): Boolean;
    procedure DeletePage1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PreviousPage1Click(Sender: TObject);
    procedure NextPage1Click(Sender: TObject);
    procedure NewPage1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sbtPaletteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eveLock(Sender: TObject);
    procedure eveAlign(Sender: TObject);
    procedure eveDelete(Sender: TObject);
    procedure eveCut(Sender: TObject);
    procedure evePaste(Sender: TObject);
    procedure eveCopy(Sender: TObject);
    procedure sbtOpenClick(Sender: TObject);
    procedure sbtSaveClick(Sender: TObject);
    procedure pmnMainPopup(Sender: TObject);
    procedure sbtSetupClick(Sender: TObject);
    procedure sbtAboutClick(Sender: TObject);
    procedure mniBringToFrontClick(Sender: TObject);
    procedure mniSendToBackClick(Sender: TObject);
    procedure sbtAlignClick(Sender: TObject);
    procedure sbtSizeClick(Sender: TObject);
    procedure eveSelectAll(Sender: TObject);
    procedure eveAlignPalette(Sender: TObject);
    procedure eveTabOrder(Sender: TObject);
    procedure sbtObjectInspectorClick(Sender: TObject);
    procedure sbtTestClick(Sender: TObject);
    procedure sbtNewClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure AllowMultipleInstances1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eveUndo(Sender: TObject);
    procedure eveRedo(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure UndoLoad(Sender: TObject; Stream: TStream);
    procedure UndoSave(Sender: TObject; Stream: TStream);
    procedure Edot1Click(Sender: TObject);
  private
    
    FAlignPalette: TfrmAlignmentPalette;
  public
    ComponentClass: TComponentClass;
    procedure SaveFormToFile(FileName: String; UpdateInternal: Boolean);
    procedure LoadForm(FileName: String);
    procedure UpdateUI(Testing: Boolean);
    procedure UTF8HackSavedForm(FileName: String);
    procedure UTF8HackClipboard;
  end;

var
  frmToolForm: TfrmToolForm;
  FormName, Baggage: String;
  GlobDirty: Boolean = false;

implementation

uses Design, SetupEx, About, OIForm, Rules, mscriptexec;

{$R *.lfm}

{$R ToolFormBitmaps.res}

function ExtractFileNameOnly(Name: String): String;
var
  s: String;
begin
  Name := ExtractFileName(Name);
  s := ExtractFileExt(Name);
  Delete(Name, AnsiPos(s, Name), Length(s));
  Result := Name;
end;

procedure TfrmToolForm.eveUndo(Sender: TObject);
begin
end;

procedure TfrmToolForm.UndoLoad(Sender: TObject; Stream: TStream);
begin
end;

procedure TfrmToolForm.UndoSave(Sender: TObject; Stream: TStream);
begin
end;

procedure TfrmToolForm.UpdateUI(Testing: Boolean);
var
  s: String;
begin
  if Testing then s := ' [Testing]';
  if FormName = '' then
    frmToolForm.Caption := 'untitled' + s + ' - ' + Brand + ' (User Interface Editor)'
  else
    frmToolForm.Caption := ExtractFileNameOnly(FormName) + s +
      ' - ' + Brand + ' (User Interface Editor)';
end;

procedure TfrmToolForm.UTF8HackSavedForm(FileName: String);
var
  sX: String;
  s, t: TextFile;
begin
  AssignFile(s, FileName);
  Reset(s);
  AssignFile(t, FileName + '.san');
  ReWrite(t);
  while not EOF(s) do
  begin
    ReadLn(s, sX);
    WriteLn(t, StringReplace(sX, '#194', '', [rfReplaceAll, rfIgnoreCase]));
  end;
  CloseFile(s);
  CloseFile(t);
  DeleteFile(FileName);
  RenameFile(FileName + '.san', FileName);
end;

procedure TfrmToolForm.UTF8HackClipboard;
var  p: PChar;
  s: String;
begin
  s := Clipboard.AsText;
  s := StringReplace(s, '#194', '', [rfReplaceAll, rfIgnoreCase]);
  Clipboard.SetTextBuf(PChar(s));
end;

procedure TfrmToolForm.LoadForm(FileName: String);
var
  s, sX: String;
  t: TextFile;
  i: Integer;
  hDef: TCursor;
  BOM: Char;
begin
  sX := '';
  if (AnsiCompareText(ExtractFileExt(FileName), '.miaf') = 0) or (AnsiCompareText(ExtractFileExt(FileName),'.baggage') = 0) then
  begin
    FileName := StringReplace(FileName, '.baggage', '', [rfReplaceAll, rfIgnoreCase]);
    sX := FileName;
    FileName := StringReplace(FileName, '.miaf', '', [rfReplaceAll, rfIgnoreCase]);
    if AnsiCompareText(ExtractFileExt(sX), '.miaf') <> 0 then
      sX := '';
    if not MyFileExists(sX) then
      sX := '';
    if not MyFileExists(FileName) then Exit;
  end;
  
  GetDir(0, s);
  ChDir(ExtractFilePath(FileName));
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  
    frmDesign.cmpFormDesigner.LoadFromDFM(FileName, dfmText);
  
  frmDesign.Tag := 1;
  if MyFileExists(FileName + '.miaf') then
    frmRules.Existing.Items.LoadFromFile(FileName + '.miaf', TEncoding.UTF8)
  else
    frmRules.Existing.Items.Clear;
  if MyFileExists(FileName + '.baggage') then
  begin
    AssignFile(t, FileName + '.baggage',cp_utf8);
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
    ReadLn(t, Baggage);
    CloseFile(t);
  end
  else Baggage := '';
  FormName := FileName;
  UpdateUI(false);
  SetCursor(hDef);
  ChDir(s);
  GlobDirty := false;
end;

procedure TfrmToolForm.sbtPaletteButtonClick(Sender: TObject);
begin
  ComponentClass:=(Sender as TPaletteButton).ComponentClass;
  if Assigned(ComponentClass) then frmDesign.cmpFormDesigner.PlaceComponentClass(ComponentClass)
    else frmDesign.cmpFormDesigner.CancelPlacing;
  
end;

procedure TfrmToolForm.FormShow(Sender: TObject);
var
  i, j: Integer;
  f: TextFile;
  ss: TShiftState;
  w: Word;
  s: String;
  BOM: Char;
begin
  Application.Title := Brand + ' (User Interface Editor)';
  frmDesign.Show;
  frmDesign.Top := frmToolForm.Top + frmToolForm.Height + DetermineTitlebarHeight(frmToolForm);
  frmDesign.Left := frmObjectInspector.Left + frmObjectInspector.Width;
  frmObjectInspector.Top := frmToolForm.Top + frmToolForm.Height + DetermineTitlebarHeight(frmToolForm);
  CreatePalettePage(pgcMain, 'Standard', [TLabel, TEdit, TMemo, TButton, TCheckBox, TRadioButton, TListBox, TComboBox, TGroupBox, TPanel, TScrollBox], sbtPaletteButtonClick);
  CreatePalettePage(pgcMain, 'Additional', [TBitBtn, TSpeedButton, TMaskEdit, TImage, TShape, TBevel, TScrollBox, TStaticText, TFileLabel], sbtPaletteButtonClick);
  CreatePalettePage(pgcMain, 'Extra', [TTrackBar, TProgressBar, TUpDown, TCheckListBox, TTreeView, TShellTreeView], sbtPaletteButtonClick);
  
  if MyFileExists(ParamStr(1)) then
    LoadForm(ParamStr(1))
  else
  begin
    globDirty := false;
    sbtNewClick(Self);
  end;
  UpdateUI(false);
  GlobDirty := false;
  if MyFileExists(AssertDir(ExtractFilePath(ParamStr(0))) + 'miauix.dat') then
  begin
    AssignFile(f, AssertDir(ExtractFilePath(ParamStr(0))) + 'miauix.dat',cp_utf8);
    Reset(f);
    if not eof(f) then
    begin
      read(f, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(f);
        reset(f);
      end;
    end;
    ReadLn(f, s);
    if not MyStrToBool(s, True)  then
      AllowMultipleInstances1.Caption := miAllow
    else
      AllowMultipleInstances1.Caption := miDeny;
    CloseFile(f);
  end;
  frmObjectInspector.Show;
  {$IFDEF DARWIN}
  
  for i := 1 to MainMenu.Items.Count do
    for j := 1 to MainMenu.Items[i -1].Count do
    begin
      ShortcutToKey(MainMenu.Items[i -1].Items[j -1].ShortCut, w, ss);
      if ssCtrl in ss then
      begin
        ss := ss - [ssCtrl];
        ss := ss + [ssMeta];
        MainMenu.Items[i -1].Items[j -1].ShortCut := KeyToShortcut(w, ss);
      end;
    end;
  
  for i := 1 to pmnMain.Items.Count do
  begin
    ShortcutToKey(pmnMain.Items[i -1].ShortCut, w, ss);
    if ssCtrl in ss then
    begin
      ss := ss - [ssCtrl];
      ss := ss + [ssMeta];
      pmnMain.Items[i -1].ShortCut := KeyToShortcut(w, ss);
    end;
  end;
  {$ENDIF}
end;

procedure TfrmToolForm.eveLock(Sender: TObject);
var
  i,IDX: Integer;
begin
  if Sender<>sbtLock then sbtLock.Down:=not sbtLock.Down;
  {$IFDEF TFD1COMPATIBLE}
  with frmDesign.cmpFormDesigner,FixedControls do
  {$ELSE}
  with frmDesign.cmpFormDesigner,LockedControls do
  {$ENDIF}
    for i:=0 to Pred(ControlCount) do
    begin
      IDX:=IndexOf(Controls[i].Name);
      if sbtLock.Down then
      begin
        if IDX=-1 then Add(Controls[i].Name);
      end
      else
        if IDX<>-1 then Delete(IDX);
    end;
end;

procedure TfrmToolForm.pmnMainPopup(Sender: TObject);
begin
  
  mniLock.Checked:=sbtLock.Down;
  
end;

procedure TfrmToolForm.eveAlign(Sender: TObject);
var
  i: Integer;
begin
  with frmDesign.cmpFormDesigner do
    for i:=0 to Pred(ControlCount) do
      if not IsLocked(Controls[i]) then
      begin
        AlignToGrid(Controls[i]);
        
      end;
end;

procedure TfrmToolForm.eveDelete(Sender: TObject);
begin
  frmObjectInspector.cmpObjectInspector.DeleteSelected;
  if sbtDelete.Enabled then
  begin
    with frmDesign.cmpFormDesigner do
      while ControlCount>0 do
      	if Controls[0] is TComponentContainer then TComponentContainer(Controls[0]).Component.Free
        else Controls[0].Free;
	end;
  with frmObjectInspector,cmbObjectInspector do
  begin
    Root:=frmDesign;
    Instance:=frmDesign;
    cmpObjectInspector.Instance:=frmDesign;
  end;
  
end;

procedure TfrmToolForm.eveCut(Sender: TObject);
begin
  if sbtCut.Enabled then
  begin
    frmDesign.cmpFormDesigner.CutToClipboard;
    UTF8HackClipboard;
  end;
end;

procedure TfrmToolForm.evePaste(Sender: TObject);
begin
  if sbtPaste.Enabled then
    frmDesign.cmpFormDesigner.PasteFromClipboard;
end;

procedure TfrmToolForm.eveCopy(Sender: TObject);
begin
  if sbtCopy.Enabled then
  begin
    frmDesign.cmpFormDesigner.CopyToClipboard;
    UTF8HackClipboard;
  end;
end;

procedure TfrmToolForm.sbtOpenClick(Sender: TObject);
var
  i: Integer;
  CurDir, NewDir: String;
begin
  GetDir(0, CurDir);
  with opdMain do
    if Execute then
    begin
      if GlobDirty then
      begin
        i := Application.MessageBox('Save changes to current form?',
          PChar(Application.Title), mb_YesNoCancel + mb_IconQuestion);
        if i = id_Cancel then Exit;
        if i = id_Yes then
        begin
          if FormName = '' then
            sbtSaveClick(Self)
          else
            SaveFormToFile(FormName, True);
          if GlobDirty then Exit; 
        end;
      end;
      GetDir(0, NewDir);
      ChDir(CurDir);
      ChDir(NewDir);
      LoadForm(FileName);
    end;
end;

procedure TfrmToolForm.sbtSaveClick(Sender: TObject);
begin
  with svdMain do
    if Execute then
      SaveFormToFile(FileName, True);
end;

procedure TfrmToolForm.sbtSetupClick(Sender: TObject);
begin
  frmSetup.ShowModal;
end;

procedure TfrmToolForm.sbtAboutClick(Sender: TObject);
begin
  if FormName = '' then
    sbtSaveClick(Self)
  else
    SaveFormToFile(FormName, True);
end;

procedure TfrmToolForm.mniBringToFrontClick(Sender: TObject);
var
  i: Integer;
begin
  with frmDesign.cmpFormDesigner do
  begin
    for i:=Pred(ControlCount) downto 0 do Controls[i].BringToFront;
    Update;
  end;
end;

procedure TfrmToolForm.mniSendToBackClick(Sender: TObject);
var
  i: Integer;
begin
  with frmDesign.cmpFormDesigner do
  begin
    for i:=Pred(ControlCount) downto 0 do Controls[i].SendToBack;
    Update;
  end;
end;

procedure TfrmToolForm.sbtAlignClick(Sender: TObject);
begin
  
end;

procedure TfrmToolForm.sbtSizeClick(Sender: TObject);
begin
  
end;

procedure TfrmToolForm.eveSelectAll(Sender: TObject);
begin
  frmDesign.cmpFormDesigner.SelectAll;
end;

procedure TfrmToolForm.eveAlignPalette(Sender: TObject);
begin
  frmDesign.cmpFormDesigner.ShowAlignmentPalette;
end;

procedure TfrmToolForm.eveTabOrder(Sender: TObject);
var
  b: Boolean;
begin
  b := frmDesign.cmpFormDesigner.TabOrderDialog;
  GlobDirty := GlobDirty or b;
  
end;

procedure TfrmToolForm.sbtObjectInspectorClick(Sender: TObject);
begin
  frmObjectInspector.Show;
end;

procedure TfrmToolForm.sbtTestClick(Sender: TObject);
var
  hDef: TCursor;
  ResultEx: String;
  b: Boolean;
  {$IFDEF DARWIN}
  Left, Top: Integer;
  {$ENDIF}
begin
  b := GlobDirty;
  {$IFDEF DARWIN}
  Left := frmDesign.Left;
  Top := frmDesign.Top;
  {$ENDIF}
  try
    hDef := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    
    VarCache.Add('TITLE'); Variables.Add('Testing Application');
    VarCache.Add('STARTMENU'); Variables.Add('Testing Application Start Menu Group');
    {$IFDEF DARWIN}
    VarCache.Add('TARGETDIR'); Variables.Add('/Applications/Testing Application.app');
    VarCache.Add('PROGRESSTEXT'); Variables.Add('Copying Testing Application files...'#13'/Applications/');
    {$ELSE}
    {$IFDEF WINDOWS}
    VarCache.Add('TARGETDIR'); Variables.Add('C:\Program Files\Testing Application');
    VarCache.Add('PROGRESSTEXT'); Variables.Add('Copying Testing Application files...'#13'C:\Program Files\');
    {$ELSE}
    VarCache.Add('TARGETDIR'); Variables.Add('/bin/Testing Application');
    VarCache.Add('PROGRESSTEXT'); Variables.Add('Copying Testing Application files...'#13'/bin/');
    {$ENDIF}
    {$ENDIF}
    VarCache.Add('USER'); Variables.Add('Testing Application Licensed User');
    VarCache.Add('COMPANY'); Variables.Add('Testing Application Licensed Company');
    VarCache.Add('PROGRESS'); Variables.Add('65');
    VarCache.Add('PROGRESSMODE'); Variables.Add('MARQUEE');
    VarCache.Add('MAINTENANCE'); Variables.Add('TRUE');
    RootFolder :=  EXEDIR + 'dlgtemplates' + DirectorySeparator; 
    ClearComponents;
    AddComponent('Testing Application', 'This component contains the main program', True);
    AddComponent('Testing Application\Program Files', 'This component installs the main files', True);
    AddComponent('Testing Application\Help Files', 'This component installs the help files', false);
    AddComponent('Clip Art\Icons', 'This component installs some icons', True);
    AddComponent('Clip Art\Bitmaps', 'This component installs some bitmaps', false);
    ComponentSpaces.Clear;
    ComponentSpaces.Add('TESTING APPLICATION');
    ComponentSpaces.Add('1234567');
    ComponentSpaces.Add('TESTING APPLICATION\PROGRAM FILES');
    ComponentSpaces.Add('12345678');
    ComponentSpaces.Add('TESTING APPLICATION\HELP FILES');
    ComponentSpaces.Add('123456');
    ComponentSpaces.Add('CLIP ART\ICONS');
    ComponentSpaces.Add('12345678');
    ComponentSpaces.Add('CLIP ART\BITMAPS');
    ComponentSpaces.Add('123456789');
    
    InitializeDlgAPI(RootFolder);
     
    SaveFormToFile(ExtractFilePath(ParamStr(0)) + 'test.frm', false);
    {$IFDEF DARWIN}
    frmDesign.Hide;
    {$ENDIF}
    LoadDesign('test', ExtractFilePath(ParamStr(0)) + 'test.frm');
    BindControls('test');
    UpdateUI(True);
    Screen.Cursor := hDef;
    ShowDesign('test', ResultEx, True, false);
    UpdateUI(false);
    FinalizeDlgAPI;
     
  finally
    {$IFDEF DARWIN}
    frmDesign.Show;
    frmDesign.Left := Left;
    frmDesign.Top := Top;
    {$ENDIF}
    Screen.Cursor := hDef;
    GlobDirty := b;
  end;
end;

procedure TfrmToolForm.SaveFormToFile(FileName: String; UpdateInternal: Boolean);
var
  
  t: TextFile;
  
  tnfActivate, tnfCreate, tnfShow: TNotifyEvent;
  hDef: TCursor;
  
begin
  
  hDef := Screen.Cursor;
  try 
    Screen.Cursor := crHourGlass;
    tnfActivate := frmDesign.OnActivate;
    frmDesign.OnActivate := nil;
    tnfCreate := frmDesign.OnCreate;
    frmDesign.OnCreate := nil;
    tnfShow := frmDesign.OnShow;
    frmDesign.Tag := 0;
    frmDesign.OnShow := nil;
    
    frmDesign.Hide;
    SetFileAttributes(PChar(FileName), FILE_ATTRIBUTE_NORMAL);
    frmDesign.cmpFormDesigner.SaveToDFM(FileName, TDFMFormat(1));
    UTF8HackSavedForm(FileName); 
     
    if Baggage <> '' then
    begin
      AssignFile(t, FileName + '.baggage',cp_utf8);
      ReWrite(t);
      WriteLn(t, AssertDir(ExtractFilePath(FileName)) + ExtractFileName(Baggage));
      CloseFile(t);
      if ExtractFilePath(Baggage) = '' then
        Baggage := AssertDir(ExtractFilePath(FormName)) + Baggage;
      SetFileAttributes(PChar(AssertDir(ExtractFilePath(FileName)) + ExtractFileName(Baggage)), FILE_ATTRIBUTE_NORMAL);
      FileCopyFile(PChar(Baggage), PChar(AssertDir(ExtractFilePath(FileName)) + ExtractFileName(Baggage)),
        false);
      Baggage := AssertDir(ExtractFilePath(FileName)) + ExtractFileName(Baggage);
    end;
    
    frmDesign.Show;
    frmDesign.Tag := 1;
    SetFileAttributes(PChar(FileName + '.miaf'), FILE_ATTRIBUTE_NORMAL);
    frmRules.Existing.Items.SaveToFile(FileName + '.miaf', TEncoding.UTF8);
    frmDesign.OnActivate := tnfActivate;
    frmDesign.OnCreate := tnfCreate;
    frmDesign.OnShow := tnfShow;
    if UpdateInternal then FormName := FileName;
    UpdateUI(false);
  finally
    SetCursor(hDef);
    GlobDirty := false;
  end;
end;

procedure TfrmToolForm.sbtNewClick(Sender: TObject);
var
  i: Integer;
begin
  if GlobDirty then
  begin
    i := Application.MessageBox('Save changes to current form?',
      PChar(Application.Title), mb_YesNoCancel + mb_IconQuestion);
    if i = id_Cancel then Exit;
    if i = id_Yes then
    begin
      if FormName = '' then
        sbtSaveClick(Self)
      else
        SaveFormToFile(FormName, True);
      if GlobDirty then Exit; 
    end;
  end;
  FormName := '';
  
  frmDesign.cmpFormDesigner.ClearForm;
  frmDesign.Tag := 1;
  UpdateUI(false);
  
  GlobDirty := false;
end;

procedure TfrmToolForm.Exit1Click(Sender: TObject);
var
  b: Boolean;
begin
  b := True;
  FormCloseQuery(Self, b);
  if b then
    Application.Terminate;
end;

procedure TfrmToolForm.About1Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmToolForm.AllowMultipleInstances1Click(Sender: TObject);
var
  f: TextFile;
  s: String;
begin
  AssignFile(f, AssertDir(ExtractFilePath(ParamStr(0))) + 'miauix.dat',cp_utf8);
  ReWrite(f);
  WriteLn(f, AllowMultipleInstances1.Caption = miAllow);
  CloseFile(f);
  if AllowMultipleInstances1.Caption = miAllow then
    AllowMultipleInstances1.Caption := miDeny
  else
    AllowMultipleInstances1.Caption := miAllow;
end;

procedure TfrmToolForm.eveRedo(Sender: TObject);
begin
end;

procedure TfrmToolForm.ToolButton2Click(Sender: TObject);
begin
end;

procedure TfrmToolForm.FormCreate(Sender: TObject);
begin
  opdMain.InitialDir :=
    AssertDir(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))))) + 'dialogs' + PathDelim;
  svdMain.InitialDir :=
    AssertDir(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))))) + 'dialogs' + PathDelim;
  {$IFNDEF BACKIDE}
  Application.HelpFile := AssertDir(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))))) + 'miae.chm';
  {$ENDIF}
end;

procedure TfrmToolForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  CanClose := false;
  if GlobDirty then
  begin
    i := Application.MessageBox('Save changes to current form?',
      PChar(Application.Title), mb_YesNoCancel + mb_IconQuestion);
    if i = id_Cancel then Exit;
    if i = id_Yes then
    begin
      if FormName = '' then
        sbtSaveClick(Self)
      else
        SaveFormToFile(FormName, True);
      if GlobDirty then Exit; 
    end;
  end;
  CanClose := True;
end;

procedure TfrmToolForm.NewPage1Click(Sender: TObject);
begin
end;

procedure TfrmToolForm.NextPage1Click(Sender: TObject);
begin
end;

procedure TfrmToolForm.PreviousPage1Click(Sender: TObject);
begin
end;

procedure TfrmToolForm.DeletePage1Click(Sender: TObject);
begin
end;

procedure TfrmToolForm.AppExException(Sender: TObject;
  E: Exception);
begin
  
end;

function TfrmToolForm.AppExHelp(Command: Word; Data: PtrInt;
  var CallHelp: Boolean): Boolean;
var
  s: String;
begin
  s := PChar(Data);
  if AnsiPos('.htm', s) = 0 then
    s := s + '.htm';
  OpenURL('https://www.installaware.com/helpx.asp?topic=' + s);
  CallHelp := false;
end;

procedure TfrmToolForm.MenuItem1Click(Sender: TObject);
begin
  frmRules.PageControl.ActivePageIndex := 0;
  frmRules.ShowModal;
end;

procedure TfrmToolForm.MenuItem2Click(Sender: TObject);
begin
  frmRules.PageControl.ActivePageIndex := 1;
  frmRules.ShowModal;
end;

procedure TfrmToolForm.Edot1Click(Sender: TObject);
begin
  
end;

end.
