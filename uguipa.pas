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
unit uguipa;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, mUtils, uScanner, ComCtrls, uGlobals,
  mAutomate{$IFNDEF WINDOWS}, BaseUnix{$ENDIF};

type

  TGuiPA = class(TForm)
    AppEx: TApplicationProperties;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Notebook: TNotebook;
    p1: TPage;
    p2: TPage;
    p3: TPage;
    p4: TPage;
    PreScan: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PostScan: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ReBaseLine: TButton;
    Label12: TLabel;
    Label13: TLabel;
    GenerateSetup: TButton;
    Label7: TLabel;
    Label14: TLabel;
    ReCreateBaseLine: TButton;
    ReScanChanges: TButton;
    Label15: TLabel;
    Label16: TLabel;
    ScanSettings: TButton;
    Label18: TLabel;
    LoadingScan: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    SaveDialog: TSaveDialog;
    procedure AppExException(Sender: TObject; E: Exception);
    procedure ScanSettingsClick(Sender: TObject);
    procedure ReScanChangesClick(Sender: TObject);
    procedure PostScanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReBaseLineClick(Sender: TObject);
    procedure PreScanClick(Sender: TObject);
    procedure GenerateSetupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    
  public
    procedure CheckGui;
  end;

var
  GuiPA: TGuiPA;

implementation

uses uScanning, uGuiBar;

{$IFnDEF FPC}
  {$R *.lfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

function MakeGuid: String;
begin
  Result := MyCreateGuid;
end;

procedure TGuiPA.PreScanClick(Sender: TObject);
begin
  FirstScan := True;
  Scanning.ShowModal;
  CheckGui;
end;

procedure TGuiPA.ReBaseLineClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Are you sure you wish to redo the baseline scan?' + #13#13 +
    'Do this only if you haven''t already run the installation to convert.'),
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
  begin
    ClearScanObjects;
    FirstScan := True;
    Scanning.ShowModal;
    CheckGui;
  end;
end;

procedure TGuiPA.CheckGui;
var
  i, j: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  Notebook.PageIndex := 0;
  try
    if MyFileExists(DataDir + 'postscan') then
    begin
      if MyFileExists(DataDir + 'prescan') then
      begin
        Notebook.PageIndex := 3;
        l.LoadFromFile(DataDir + 'index');
        for i := 1 to l.Count do
        begin
          LoadingScan.Caption := 'Drive ' + l[i -1];
          Application.ProcessMessages;
          if MyFileExists(DataDir + 'Added' + l[i -1]) then
          begin
            LoadScanObject('Added' + l[i -1],
              DataDir + 'Added' + l[i -1]);
            LoadScanObject('Modified' + l[i -1],
              DataDir + 'Modified' + l[i -1]);
            LoadScanObject('Removed' + l[i -1],
              DataDir + 'Removed' + l[i -1]);
          end
          else
          begin
            raise Exception.Create('Unable to locate scans!');
            
          end;
        end;
        Notebook.PageIndex := 2;
      end
      else
      begin
        raise Exception.Create('Unable to locate scans!');
      end;
    end
    else
    if MyFileExists(DataDir + 'prescan') then
    begin
      Notebook.PageIndex := 3;
      l.LoadFromFile(DataDir + 'index');
      for i := 1 to l.Count do
      begin
        LoadingScan.Caption := 'Drive ' + l[i -1];
        Application.ProcessMessages;
        if MyFileExists(DataDir + l[i -1]) then
          LoadScanObject('PreScan' + l[i -1],
            DataDir + l[i -1])
        else
          Exit;
      end;
      Notebook.PageIndex := 1;
    end;
  finally
    l.Free;
  end;
end;

procedure TGuiPA.FormShow(Sender: TObject);
begin
  {$IFNDEF LINUX}
  Label1.Caption := 'Welcome to PackageAware. [Multi Platform]';
  {$ELSE}
  Label1.Caption := 'PackageAware [Multi Platform]';
  {$ENDIF}
  CheckGui;
end;

procedure TGuiPA.PostScanClick(Sender: TObject);
begin
  FirstScan := false;
  Scanning.ShowModal;
  CheckGui;
end;

procedure TGuiPA.ReScanChangesClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Are you sure you wish to redo the changes scan?' + #13#13 +
    'Do this only if you forgot to install some parts of the setup you are capturing.'),
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
  begin
    ClearScanObjects;
    DeleteFile(DataDir + 'postscan');
    FirstScan := false;
    CheckGui;
    Scanning.ShowModal;
    CheckGui;
  end;
end;

procedure TGuiPA.ScanSettingsClick(Sender: TObject);
begin
  frmSettings.ShowModal;
end;

procedure TGuiPA.AppExException(Sender: TObject; E: Exception);
begin
  
end;

function RefactorPaths(Items: TStrings; var SniffedProduct, SniffedCompany, SniffedShortcut: String): TStringList;
var
  b: Boolean;
  s, sX: String;
  i, j: Integer;
  l, lX: TStringList;
begin
  Result := nil;
  
  l := TStringList.Create;
  lX := TStringList.Create;
  l.CommaText := Items.CommaText;
  while l.Count > 0 do
  begin
    s := '';
    repeat
      j := 0;
      for i := l.Count downto 1 do
      begin
        b := True;
        
        sX := DeAssertDir(ExtractFilePath(l[i -1]));
        if (Length(sX) > 2) and (ExtractFileName(l[i -1]) <> '') then 
          if sX[Length(sX)] <> '$' then 
          begin
            
            if s = '' then
              s := sX
            else
            begin
              
              if AnsiPos(sX, s) <> 0 then
                s := sX
              else
                
                if AnsiPos(s, sX) = 0 then
                  b := false;
            end;
          end;
        if b then
        begin
          l.Delete(i -1);
          j := j +1;
        end;
      end;
    until j = 0;
    lX.Add(s);
    sX := s;
  end;
  
  Result := TStringList.Create;
  for i := 1 to lX.Count do
    if ReverseInjectCommand(lX[i -1]) <> '' then
      if Result.IndexOf(ReverseInjectCommand(lX[i -1])) = -1 then
        Result.Add(ReverseInjectCommand(lX[i -1]));
  if Result.Count = 0 then
  begin
    Result.Free;
    Result := nil;
  end;
  
  {$IFNDEF DARWIN} 
  SniffCompanyProduct(lX, Items, '$PROGRAMFILES$', '$TARGETDIR$', s, sX);
  {$ELSE}
  SniffCompanyProduct(lX, Items, '$COMMONFILES$', '$TARGETDIR$', s, sX);
  {$ENDIF}
  if sX = '' then
  begin
    SniffedCompany := 'My Company';
    SniffedProduct := 'My Repackaged Installation';
  end
  else
  begin
    SniffedCompany := s;
    SniffedProduct := sX;
  end;
  {$IFNDEF DARWIN} 
  SniffCompanyProduct(lX, Items, '$STARTMENU$', '$PLATFORMMENU$', s, sX);
  if sX = '' then                                   
    SniffCompanyProduct(lX, Items, '$STARTMENUALL$', '$PLATFORMMENU$', s, sX);
  {$ELSE}
  SniffCompanyProduct(lX, Items, '$COMMONFILES$', '$PLATFORMMENU$', s, sX);
  {$ENDIF}
  if sX = '' then
    SniffedShortcut := 'My Company' + PathDelim + 'My Repackaged Installation'
  else
  begin
    if s = '' then
      SniffedShortcut := sX
    else
      SniffedShortcut := s + PathDelim + sX;
  end;
  l.Free;
  lX.Free;
end;

procedure TGuiPA.GenerateSetupClick(Sender: TObject);
var
  
  ScriptLineCount: Integer;
  ProjectFolder, ProjectFile, ScriptFile: String;
  
  c: Char;
  l: TList;
  i, j: Integer;
  lX, lY: TStringList;
  s, sX, sY, SniffedProduct, SniffedCompany, SniffedShortcut: String;
  FileAddList, FileModList, FileAddListEx, FileRemoveList,
  ShortcutList: TStringList;
  sr: TScanRecord;
  hDef: TCursor;
  t: TextFile;
  
  ps: TProjectStruct;
  s1, s2: String;
begin
  try
    hDef := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    FileAddList := TStringList.Create;
    FileAddListEx := TStringList.Create;
    FileModList := TStringList.Create;
    FileRemoveList := TStringList.Create;
    ShortcutList := TStringList.Create;
    PrepareToParse;
    
    {$IFDEF WINDOWS}
    for c := 'A' to 'Z' do
    {$ELSE}
    for c := '-' to '-' do
    {$ENDIF}
    begin
      l := FindScanObject('Added' + c);
      if l <> nil then
        for i := 1 to SizeScanObject('Added' + c) do
        begin
          PokeScanObject('Added' + c, i -1, sr);
          FileAddList.Add(sr.FileName);
        end;
      l := FindScanObject('Modified' + c);
      if l <> nil then
        for i := 1 to SizeScanObject('Modified' + c) do
        begin
          PokeScanObject('Modified' + c, i -1, sr);
          FileModList.Add(sr.FileName);
        end;
      l := FindScanObject('Removed' + c);
      if l <> nil then
        for i := 1 to SizeScanObject('Removed' + c) do
        begin
          PokeScanObject('Removed' + c, i -1, sr);
          FileRemoveList.Add(sr.FileName);
        end;
    end;
    for i := 1 to FileRemoveList.Count do
      FileRemoveList[i -1] := ReverseInvokePath(FileRemoveList[i -1], false);
    for i := 1 to FileAddList.Count do
      FileAddListEx.Add(ReverseInvokePath(FileAddList[i -1], false));
    for i := 1 to FileModList.Count do
      FileAddListEx.Add(ReverseInvokePath(FileModList[i -1], false));
    
    lX := RefactorPaths(FileAddListEx, SniffedProduct, SniffedCompany, SniffedShortcut);
    
    {$IFNDEF WINDOWS}
    GetSpecialFolder($3e, sY);
    SaveDialog.InitialDir := sY;
    {$ENDIF}
    
    SaveDialog.FileName := SniffedProduct + '.mprx';
    if not SaveDialog.Execute then Exit;
    
    ProjectFolder := IncludeTrailingPathDelimiter(ExtractFilePath(SaveDialog.FileName))
      + ExtractFileNameOnly(SaveDialog.Filename) + PathDelim;
    ForceDirectories(ProjectFolder);
    {$IFNDEF WINDOWS}
    FpChMod(ProjectFolder, &777);
    {$ENDIF}
    ScriptFile := ProjectFolder + ExtractFileNameOnly(SaveDialog.FileName) + '.miax';
    ProjectFile := ProjectFolder + ExtractFileNameOnly(SaveDialog.FileName) + '.mprx';
    
    InitializeScript;
    EmitAddCommand('Comment', '""');
    
    EmitAddCommand('Comment', '" _____ ______   ________"');
    EmitAddCommand('Comment', '"|\   _ \  _   \|\   __  \ PackageAware Multi Platform Captured Setup Project"');
    EmitAddCommand('Comment', '"\ \  \\\__\ \  \ \  \|\  \ Copyright© 1996-2025 InstallAware Software"');
    EmitAddCommand('Comment', '" \ \  \\|__| \  \ \   ____\ All rights reserved"');
    EmitAddCommand('Comment', '"  \ \  \    \ \  \ \  \___|"');
    EmitAddCommand('Comment', '"   \ \__\    \ \__\ \__\"');
    EmitAddCommand('Comment', '"    \|__|     \|__|\|__|"');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Comment', PChar('"            Project Name: ' + SniffedProduct + '"'));
    EmitAddCommand('Comment', PChar('"                 Company: ' + SniffedCompany + '"'));
    EmitAddCommand('Comment', '"             Description: InstallAware Multi Platform Installation Script"');
    EmitAddCommand('Comment', '"                Comments: Generated by PackageAware [Multi Platform]"');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Code Folding Region', '"TRUE","Application Dependencies"');
    EmitAddCommand('Comment', '"Check Setup Prereqs"');
    EmitAddCommand('Set Variable', '"PREREQ","FALSE"');
    EmitAddCommand('Set Variable', '"PRELIST",""');
    EmitAddCommand('If', '"RECOMMENDEDUPGRADE","0","TRUE","FALSE"');
    EmitAddCommand('Set Variable', '"PREREQ","TRUE"');
    EmitAddCommand('Set Variable', '"PRELIST","$PRELIST$$NEWLINE$Previous Version Removal"');
    EmitAddCommand('End', '');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Comment', '"Install Setup Prereqs"');
    EmitAddCommand('If', '"PREREQ","0","FALSE","TRUE"');
    EmitAddCommand('Display Dialog', '"prereq","WIZARD","TRUE","","TRUE","FALSE"');
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"');
    EmitAddCommand('Terminate Install', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Display Dialog', '"progressprereq","WIZARD","FALSE","","TRUE","FALSE"');
    EmitAddCommand('If', '"RECOMMENDEDUPGRADE","0","TRUE","FALSE"');
    EmitAddCommand('Comment', '"Bind to external setup log"');
    EmitAddCommand('Set Variable', '"NATIVE_LOGGING","$NATIVE_OLDLOG$"');
    EmitAddCommand('Apply Changes', '"","NATIVE_UNINSTALL","FALSE","TRUE"');
    EmitAddCommand('If', '"NATIVE_UNINSTALL","0","REBOOT","FALSE"');
    EmitAddCommand('MessageBox', '"$TITLE$ Setup",' +
      '"Your computer needs to be restarted before $TITLE$ Setup can continue.$NEWLINE$$NEWLINE$Please save your work in all running programs and click OK to restart your computer. Setup will resume once your computer restarts.$NEWLINE$$NEWLINE$If you click CANCEL, setup will exit. You will have to run setup again at a later time to install $TITLE$.",' +
      '"0","2","REBOOTNOW"');
    EmitAddCommand('If', '"REBOOTNOW","0","OK","FALSE"');
    EmitAddCommand('Reboot and Resume', '');
    EmitAddCommand('Else', '');
    EmitAddCommand('Terminate Install', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Else', '');
    EmitAddCommand('If', '"NATIVE_UNINSTALL","0","COMPLETE","TRUE"');
    EmitAddCommand('MessageBox', '"$TITLE$ Setup",' +
      '"Unable to uninstall old version of $TITLE$. It is strongly recommended that you uninstall it yourself using Control Panel Add-Remove Programs before attempting to install this product.$NEWLINE$$NEWLINE$$LASTERROR$$NEWLINE$$NEWLINE$Click OK to quit $TITLE$ Setup.$NEWLINE$$NEWLINE$Click Cancel to continue $TITLE$ Setup anyways (not recommended).",' +
      '"0","2","NATIVE_UNINSTALL"');
    EmitAddCommand('If', '"NATIVE_UNINSTALL","0","OK","FALSE"');
    EmitAddCommand('Terminate Install', '');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Comment', '"Bind to internal setup log"');
    EmitAddCommand('Set Variable', '"NATIVE_LOGGING",""');
    EmitAddCommand('End', '');
    EmitAddCommand('Hide Dialog', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Code Folding Region', '"TRUE","Setup Globals"');
    EmitAddCommand('Comment', '"Define Setup Features"');
    EmitAddCommand('Define Component', '"' + SniffedProduct + '","TRUE","System changes as detected by PackageAware [Multi Platform] snapshot based setup capture."');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Comment', '"Initialize Setup Variables"');
    EmitAddCommand('Set Variable', '"DELAYUNTIL_APPLYCHANGES","TRUE"');
    EmitAddCommand('Set Variable', '"NATIVE_OVERWRITE","NEVER"');
    EmitAddCommand('Get Folder Location', '"LOCALAPPDATA","28","0"');
    EmitAddCommand('Get Folder Location', '"SYSTEMAPPDATA","15","1"');
    EmitAddCommand('Get Folder Location', '"USERAPPDATA","15","0"');
    EmitAddCommand('Get Folder Location', '"PROGRAMFILES","20","0"');
    EmitAddCommand('Get Folder Location', '"COMMONFILES","20","1"');
    EmitAddCommand('Get Folder Location', '"STARTMENUALL","14","TRUE"');
    EmitAddCommand('Get Folder Location', '"STARTMENU","14","FALSE"');
    EmitAddCommand('Get Folder Location', '"DESKTOP","17","FALSE"');
    EmitAddCommand('Get Folder Location', '"DOCUMENTS","2","TRUE"');
     
    EmitAddCommand('Code Folding Region', '"TRUE","Captured Folder Paths"');
    if lX <> nil then
    begin
      for i := 1 to lX.Count do
        EmitAddCommand('Get Folder Location', PChar(lX[i -1]));
      lX.Free;
    end;
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('If', '"MAINTENANCE","0","TRUE","FALSE"');
    EmitAddCommand('GoTo Label', '"MAINTENANCE"');
    EmitAddCommand('End', '');
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Code Folding Region', '"TRUE","User Interview"');
    EmitAddCommand('Comment', '"First Time Install"');
    EmitAddCommand('Label', '"Introduction"');
    EmitAddCommand('Display Dialog', '"welcome","WIZARD","1","","1","0"');
    EmitAddCommand('If', '"WIZARD","0","CANCEL","0"');
    EmitAddCommand('GoTo Label', '"Main Install"');
    EmitAddCommand('End', '');
    EmitAddCommand('Label', '"Read Me"');
    EmitAddCommand('Display Dialog', '"readme","WIZARD","1","","1","0"');
    EmitAddCommand('If', '"WIZARD","0","BACK","0"');
    EmitAddCommand('GoTo Label', '"Introduction"');
    EmitAddCommand('Else', '');
    EmitAddCommand('If', '"WIZARD","0","CANCEL","0"');
    EmitAddCommand('GoTo Label', '"Main Install"');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Label', '"License Agreement"');
    EmitAddCommand('Display Dialog', '"licensecheck","WIZARD","1","","1","0"');
    EmitAddCommand('If', '"WIZARD","0","BACK","0"');
    EmitAddCommand('GoTo Label', '"Read Me"');
    EmitAddCommand('Else', '');
    EmitAddCommand('If', '"WIZARD","0","CANCEL","0"');
    EmitAddCommand('GoTo Label', '"Main Install"');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Label', '"Destination Select"');
    EmitAddCommand('Display Dialog', '"destination","WIZARD","1","","1","0"');
    EmitAddCommand('If', '"WIZARD","0","BACK","0"');
    EmitAddCommand('GoTo Label', '"License Agreement"');
    EmitAddCommand('Else', '');
    EmitAddCommand('If', '"WIZARD","0","CANCEL","0"');
    EmitAddCommand('GoTo Label', '"Main Install"');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Label', '"Installation Type"');
    EmitAddCommand('Display Dialog', '"setuptype","WIZARD","1","","1","0"');
    EmitAddCommand('If', '"WIZARD","0","BACK","0"');
    EmitAddCommand('GoTo Label', '"Destination Select"');
    EmitAddCommand('Else', '');
    EmitAddCommand('If', '"WIZARD","0","STANDARD","0"');
    EmitAddCommand('Set Component State', '"' + SniffedProduct + '","TRUE"');
    EmitAddCommand('End', '');
    EmitAddCommand('GoTo Label', '"Main Install"');
    EmitAddCommand('End', '');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Comment', '"Repair Install/Change Features/Uninstall"');
    EmitAddCommand('Label', '"Maintenance"');
    EmitAddCommand('Display Dialog', '"maintenance","WIZARD","TRUE","","TRUE","FALSE"');
    EmitAddCommand('If', '"WIZARD","0","REMOVE","FALSE"');
    EmitAddCommand('Set Variable', '"REMOVE","TRUE"');
    EmitAddCommand('End', '');
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Code Folding Region', '"TRUE","Execute Setup Tasks"');
    EmitAddCommand('Label', '"Main Install"');
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"');
    EmitAddCommand('Terminate Install', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Comment', '"Process (un)installation"');
    EmitAddCommand('Set Variable', '"SUCCESS",""');
    EmitAddCommand('Set Variable', '"LASTERROR",""');
    EmitAddCommand('If', '"PLATFORM","0","MACOS","FALSE"');
    EmitAddCommand('Set Variable', '"PLATFORMMENU","/Applications"');
    EmitAddCommand('Else', '');
    EmitAddCommand('If', '"ALLUSERS","0","TRUE","FALSE"');
    EmitAddCommand('Set Variable', '"PLATFORMMENU","$STARTMENUALL$"');
    EmitAddCommand('Else', '');
    EmitAddCommand('Set Variable', '"PLATFORMMENU","$STARTMENU$"');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Display Dialog', '"progress","WIZARD","FALSE","","TRUE","FALSE"');
    EmitAddCommand('Code Folding Region', '"TRUE","Execute Uninstall Jobs"');
    EmitAddCommand('If', '"REMOVE","0","TRUE","FALSE"');
    EmitAddCommand('Set Variable', '"PROGRESSTEXT","Removing $TITLE$"');
    EmitAddCommand('Comment', '"TODO: Insert any custom uninstall commands here"');
    EmitAddCommand('Apply Changes', '"","SUCCESS","FALSE","TRUE"');
    EmitAddCommand('Set Variable', '"PROGRESS","100"');
    EmitAddCommand('Else', '');
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Code Folding Region', '"TRUE","Execute Install Jobs"');
    EmitAddCommand('Set Variable', '"PROGRESSTEXT","Adding $TITLE$"');
    EmitAddCommand('If', '"MAINTENANCE","0","TRUE","FALSE"');
    EmitAddCommand('Comment', '"Facilitate removal of deselected features and repair of remaining ones"');
    EmitAddCommand('Apply Changes', '"","SUCCESS","FALSE","TRUE"');
    EmitAddCommand('If', '"SUCCESS","0","CANCEL","FALSE"');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Web Media Block', '"","","FALSE"'); 
    EmitAddCommand('Comment', '"TODO: Move mandatory product features here"');
    EmitAddCommand('Create Shortcut', '"$UNINSTALLLINK$|0","$TITLE$ Maintenance","$PLATFORMMENU$|0","Add or remove $TITLE$ features","","|0","|0","|","0|"');
    EmitAddCommand('Web Media Block', '"' + SniffedProduct + ' #PLATFORM#","https://www.installaware,com/' + SniffedProduct + ' #PLATFORM#.7zip","FALSE"');
    EmitAddCommand('Get Component State', '"' + SniffedProduct + '","SELECTED"');
    EmitAddCommand('If', '"SELECTED","0","TRUE","0"');
    EmitAddCommand('Code Folding Region', '"TRUE","Captured New Files, Links, and Shortcuts"');
    
      for i := 1 to FileAddList.Count do
      begin
        if (AnsiPos('$WINSYSDIR$', FileAddListEx[i -1]) = 1)
          
        then
          s := 'TRUE'
        else
          s := 'FALSE';
        if ExtractFileName(FileAddList[i -1]) = '' then
        begin
          {$IFNDEF WINDOWS}
          
          if fpReadLink(FileAddListEx[i -1]) = '' then
          {$ENDIF}
            EmitAddCommand('Create Folder', PChar('"' + FileAddListEx[i -1] + '"'));
        end
        else
          if CompareText(ExtractFileExt(FileAddList[i -1]), {$IFDEF WINDOWS}'.lnk'{$ELSE}{$IFDEF LINUX}'.desktop'{$ELSE}'.ipenduru'{$ENDIF}{$ENDIF}) <> 0 then
          begin
            sX := AssertDir(ExtractFilePath(FileAddListEx[i -1]));
            while AnsiPos(PathDelim + PathDelim, sX) <> 0 do
              sX := StringReplace(sX, PathDelim + PathDelim, PathDelim, [rfReplaceAll, rfIgnoreCase]); 
            if AnsiPos('*', FileAddList[i -1]) <> 0 then
            begin
              EmitAddCommand('Install Files', PChar('"' + FileAddList[i -1] + '",' +
                '"TRUE","' + sX + '","FALSE","FALSE","FALSE",' +
                '"FALSE","FALSE","FALSE","' + s + '","FALSE","FALSE"'));
            end
            else
            begin
            {$IFNDEF WINDOWS}
            
            if fpReadLink(FileAddList[i -1]) = '' then
            {$ENDIF}
                EmitAddCommand('Install Files', PChar('"' + FileAddList[i -1] + '",' +
                  '"FALSE","' + sX + '","FALSE","FALSE","FALSE",' +
                  '"FALSE","FALSE","FALSE","' + s + '","FALSE","FALSE"'));
            end;
          end
          else
          begin
            lX := GetLinkTarget(FileAddList[i -1]);
            if lX <> nil then
            begin
              EmitAddCommand('Create Shortcut', PChar('"' +
                Reparse(lX[0]) + '","' +
                {$IFDEF WINDOWS}ExtractFileNameOnly(FileAddList[i -1]){$ELSE}lX[6]{$ENDIF} + '","' +
                DeAssertDir(ExtractFilePath(FileAddListEx[i -1])) + '","' +
                lX[1] + '","' +
                lX[3] + '","' +
                Reparse(lX[2]) + '","' +
                Reparse(lX[4]) + '","' +
                lX[5] + '","0"'
                ));
              lX.Free;
            end;
          end;
      end;
    {$IFNDEF WINDOWS}
    for i := 1 to FileAddList.Count do
    begin
      if (AnsiPos('$WINSYSDIR$', FileAddListEx[i -1]) = 1)
        
      then
        s := 'TRUE'
      else
        s := 'FALSE';
      if ExtractFileName(FileAddList[i -1]) = '' then
      begin
        
        if fpReadLink(FileAddListEx[i -1]) <> '' then
          
          EmitAddCommand('Create Link', PChar('"' + FileAddListEx[i -1] + '",' +
            '"' + fpReadLink(FileAddListEx[i -1]) + '","TRUE","FALSE","' + s + '"'))
          
      end
      else
        if CompareText(ExtractFileExt(FileAddList[i -1]), {$IFDEF LINUX}'.desktop'{$ELSE}'.ipenduru'{$ENDIF}) <> 0 then
        begin
          sX := AssertDir(ExtractFilePath(FileAddListEx[i -1]));
          while AnsiPos(PathDelim + PathDelim, sX) <> 0 do
            sX := StringReplace(sX, PathDelim + PathDelim, PathDelim, [rfReplaceAll, rfIgnoreCase]); 
          if AnsiPos('*', FileAddList[i -1]) <> 0 then
          begin
            
            lY := FindAllLinks(FileAddList[i -1]);
            for j := 1 to lY.Count do
              EmitAddCommand('Create Link', PChar('"' + lY[j -1] + '",' +
                '"' + fpReadLink(lY[j -1]) + '","TRUE","FALSE","' + s + '"'));
            lY.Free;
          end
          else
          begin
            
            if fpReadLink(FileAddList[i -1]) <> '' then
              EmitAddCommand('Create Link', PChar('"' + FileAddList[i -1] + '",' +
                '"' + fpReadLink(FileAddList[i -1]) + '","TRUE","FALSE","' + s + '"'));
          end;
        end;
    end;
    {$ENDIF}
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Code Folding Region', '"TRUE","Captured Modified Files, Links, and Shortcuts"');
    for i := 1 to FileModList.Count do
    begin
      s1 := FileAddListEx[FileAddList.Count + i -1]; 
      s2 := FileModList[i -1]; 
      s := 'TRUE';
      if ExtractFileName(s2) = '' then
      begin
        
        {$IFNDEF WINDOWS}
        if fpReadLink(s1) = '' then
        {$ENDIF}
          EmitAddCommand('Create Folder', PChar('"' + s1 + '"'));
      end
      else
        if CompareText(ExtractFileExt(s2), {$IFDEF WINDOWS}'.lnk'{$ELSE}{$IFDEF LINUX}'.desktop'{$ELSE}'.ipenduru'{$ENDIF}{$ENDIF}) <> 0 then
        begin
          sX := AssertDir(ExtractFilePath(s1));
          while AnsiPos(PathDelim + PathDelim, sX) <> 0 do
            sX := StringReplace(sX, PathDelim + PathDelim, PathDelim, [rfReplaceAll, rfIgnoreCase]); 
          if AnsiPos('*', s2) <> 0 then
          begin
            EmitAddCommand('Install Files', PChar('"' + s2 + '",' +
              '"TRUE","' + sX + '","FALSE","FALSE","FALSE",' +
              '"FALSE","FALSE","FALSE","' + s + '","FALSE","FALSE"'));
          end
          else
          begin
            {$IFNDEF WINDOWS}
            
            if fpReadLink(s2) = '' then
            {$ENDIF}
              EmitAddCommand('Install Files', PChar('"' + s2 + '",' +
                '"FALSE","' + sX + '","FALSE","FALSE","FALSE",' +
                '"FALSE","FALSE","FALSE","' + s + '","FALSE","FALSE"'));
          end;
        end
        else
        begin
          lX := GetLinkTarget(s2);
          if lX <> nil then
          begin
            EmitAddCommand('Create Shortcut', PChar('"' +
              Reparse(lX[0]) + '","' +
              {$IFDEF WINDOWS}ExtractFileNameOnly(s2){$ELSE}lX[6]{$ENDIF} + '","' +
              DeAssertDir(ExtractFilePath(s1)) + '","' +
              lX[1] + '","' +
              lX[3] + '","' +
              Reparse(lX[2]) + '","' +
              Reparse(lX[4]) + '","' +
              lX[5] + '","0"'
              ));
            lX.Free;
          end;
        end;
    end;
    {$IFNDEF WINDOWS}
    
    for i := 1 to FileModList.Count do
    begin
      s1 := FileAddListEx[FileAddList.Count + i -1]; 
      s2 := FileModList[i -1]; 
      s := 'TRUE';
      if ExtractFileName(s2) = '' then
      begin
        
        if fpReadLink(s1) <> '' then
          EmitAddCommand('Create Link', PChar('"' + s1 + '",' +
            '"' + fpReadLink(s1) + '","TRUE","FALSE","' + s + '"'))
      end
      else
        if CompareText(ExtractFileExt(s2), {$IFDEF LINUX}'.desktop'{$ELSE}'.ipenduru'{$ENDIF}) <> 0 then
        begin
          sX := AssertDir(ExtractFilePath(s1));
          while AnsiPos(PathDelim + PathDelim, sX) <> 0 do
            sX := StringReplace(sX, PathDelim + PathDelim, PathDelim, [rfReplaceAll, rfIgnoreCase]); 
          if AnsiPos('*', s2) <> 0 then
          begin
            
            lY := FindAllLinks(s2);
            for j := 1 to lY.Count do
              EmitAddCommand('Create Link', PChar('"' + lY[j -1] + '",' +
                '"' + fpReadLink(lY[j -1]) + '","TRUE","FALSE","' + s + '"'));
            lY.Free;
          end
          else
          begin
            
            if fpReadLink(s2) <> '' then
              EmitAddCommand('Create Link', PChar('"' + s2 + '",' +
                '"' + fpReadLink(s2) + '","TRUE","FALSE","' + s + '"'));
          end;
        end;
    end;
    {$ENDIF}
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Code Folding Region', '"TRUE","Captured File Deletions"');
    for i := 1 to FileRemoveList.Count do
      if AnsiPos('*', FileRemoveList[i -1]) <> 0 then
        EmitAddCommand('Remove Directory',
          PChar('"' + AssertDir(ExtractFilePath(FileRemoveList[i -1]))) + '"')
      else
        EmitAddCommand('Delete Files', PChar('"' +
          DeAssertDir(ExtractFilePath(Reparse(FileRemoveList[i -1]))) + '","' +
          ExtractFileName(Reparse(FileRemoveList[i -1])) + '","' +
          'TRUE","FALSE"'));
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('End', '');
    EmitAddCommand('Apply Changes', '"","SUCCESS","1","0"');
    EmitAddCommand('Set Variable', '"PROGRESS","100"');
    EmitAddCommand('End', '');
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Comment', '""');
    EmitAddCommand('Code Folding Region', '"TRUE","End of Installation"');
    EmitAddCommand('Comment', '"Finish Setup"');
    EmitAddCommand('Hide Dialog', '');
    EmitAddCommand('Display Dialog', '"finish","WIZARD","TRUE","","TRUE","FALSE"');
    EmitAddCommand('If', '"REMOVE","0","FALSE","FALSE"');
    EmitAddCommand('If', '"RUNAPP","0","TRUE","FALSE"');
    EmitAddCommand('If', '"PLATFORM","0","MACOS","TRUE"');
    EmitAddCommand('Comment', '"TODO: Insert command that starts your application here"');
    EmitAddCommand('Else', '');
    EmitAddCommand('Comment', '"TODO: Insert command that starts your application from inside the application bundle here"');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('End', '');
    EmitAddCommand('Code Folding Region', '"FALSE",""');
    EmitAddCommand('Comment', '""');
    ScriptLineCount := GetTotalLines;
    FinalizeScript(PChar(ScriptFile));
    {$IFNDEF WINDOWS}
    FpChMod(ScriptFile, &777);
    {$ENDIF}
    AssignFile(t, AssertDir(ExtractFilePath(ScriptFile))
      + ExtractFileNameOnly(ScriptFile) + '.fldx');
    ReWrite(t);
    WriteLn(t, 'Application Dependencies');
    WriteLn(t, 'Setup Globals');
    WriteLn(t, 'Captured Folder Paths');
    WriteLn(t, 'User Interview');
    WriteLn(t, 'Execute Setup Tasks');
    WriteLn(t, 'Execute Uninstall Jobs');
    WriteLn(t, 'Execute Install Jobs');
    WriteLn(t, 'Captured New Files and Shortcuts');
    WriteLn(t, 'Captured File Deletions');
    WriteLn(t, 'End of Installation');
    CloseFile(t);
    {$IFNDEF WINDOWS}
    FpChMod(AssertDir(ExtractFilePath(ScriptFile))
      + ExtractFileNameOnly(ScriptFile) + '.fldx', &777);
    {$ENDIF}
    
    ps.BuildDebug := false;
    ps.BuildLayout := 0;
    ps.CompressProfile := '5';
    ps.BuildInFolder := True;
    ps.BuildCustomFolder := '';
    ps.OutputFile := '';
    ps.AutoIncrement := True;
    ps.AutoHash := false;
    ps.Conditionals := 'UAC=requireAdministrator,IGNOREMISSINGFILES=TRUE,DOFOLLOW=FALSE';
    
    ps.Manufacturer := SniffedCompany;
    ps.Name := SniffedProduct;
    ps.Code := MyCreateGuid;
    ps.UpgradeCode := MyCreateGuid;
    ps.Version := '1.0';
    ps.Language := 'English';
    ps.Title := SniffedProduct + ' Captured Installation';
    ps.Subject := 'InstallAware Multi Platform';
    ps.Author := 'Captured by PackageAware [Multi Platform]';
    ps.Comments := 'InstallAware Software';
    ps.Revision := MyCreateGUID;
    
    ps.arPublisher := SniffedCompany;
    ps.arContact := 'https://www.installaware.com/';
    ps.arHelp := 'https://www.installaware.com/';
    ps.arUpdates := 'https://www.installaware.com/';
    ps.arComments := 'InstallAware Software';
    
    ps.aSign := false;
    ps.aCertificate := '';
    ps.aKey := '';
    ps.aTimeStamp := '';
    ps.aInfo := 'https://www.installaware.com/';
    
    ps.pDisplay := '';
    ps.pDescription := '';
    ps.pClass := '';
    ps.pWhole := false;
    ps.pMissing := false;
    ps.pLarge := false;
    ps.pRemove := false;
    ps.pCreate := false;
    ps.pDebug := false;
    
    ps.MultiLang := false;
    
    ps.PassEnabled := false;
    ps.Password := '';
    ps.CodeSignPassword := '';
    
    ps.cFiles := false;
    ps.cRegistry := false;
    ps.cFeatures := false;
    ps.cHashes := false;
    InitializeProject(ps);
    SetScriptFile(PChar(ScriptFile));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/destination.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/finish.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/licensecheck.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/maintenance.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/prereq.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/progress.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/progressprereq.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/readme.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/setuptype.lfm'));
    AddProjectDialog(PChar(EXEDIR + 'Dialogs/macOS/welcome.lfm'));
    FinalizeProject(PChar(ProjectFile), ScriptLineCount);
    
    {$IFNDEF WINDOWS}
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'destination.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'destination.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'finish.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'finish.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'licensecheck.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'licensecheck.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'maintenance.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'maintenance.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'prereq.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'prereq.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'progress.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'progress.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'progressprereq.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'progressprereq.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'readme.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'readme.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'setuptype.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'setuptype.lfm.miaf', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'welcome.lfm', &777);
    FpChMod(AssertDir(ExtractFilePath(ProjectFile)) +
      'welcome.lfm.miaf', &777);
    
    FpChMod(ProjectFile, &777);
    {$ENDIF}
    
    Application.MessageBox('Project created successfully. You may now open it in InstallAware.',
      PChar(Application.Title), mb_Ok + mb_IconInformation);
    AssignFile(t, DataDir + 'remodulateshieldnutation');
    ReWrite(t);
    CloseFile(t);
    Application.Terminate;
  finally
    FileAddList.Free;
    FileAddListEx.Free;
    FileModList.Free;
    FileRemoveList.Free;
    ShortcutList.Free;
    SetCursor(hDef);
  end;
end;

procedure TGuiPA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    FileExclude.SaveToFile(DataDir + 'fileexclude.txt');
  except
    
  end;
end;

end.
