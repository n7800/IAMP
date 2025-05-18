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
program miaxstub;

{$mode objfpc}{$H+}
{$IFDEF DARWIN}
{$modeswitch objectivec1}
{$ENDIF}
{$DEFINE UseCThreads}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  mUtils,
  {$IFDEF LINUX}
  fpimgreaderelftypes,
  {$ENDIF}
  {$IFNDEF NOGUI}Interfaces, 
  Forms, uSetupInit, uSetupSplash, LCLType,{$ENDIF}
  mScriptExec, SysUtils, IniFiles, LCLIntf,
  {$IFDEF DARWIN}MacOSAll,{$ELSE}Process,{$ENDIF}{$IFNDEF WINDOWS}BaseUnix,
  Unix, Dos,{$ELSE}ShellAPI,{$ENDIF}Classes, uDlgAPI, uSevenZipAPI, uDirectExtractMedia{$IFNDEF NOGUI},
  uImageListPool, ufolderbrowsepool{$ENDIF}{$IFDEF WINDOWS}, Windows,
  win32purefilesizelazarus {$IFNDEF NOGUI}, uLazPopup{$ENDIF}{$ENDIF};

{$R *.res}

{$IFDEF WINDOWS}
type
  PImageDosHeader = ^TImageDosHeader;
  TImageDosHeader = packed record
    e_magic: Word;
    e_ignore: packed array [0..28] of Word;
    _lfanew: Longint;
  end;
{$ENDIF}

var
  szError: String;
  
  ExePath, TempPath, ArchivePath, ExeNameOnly: String;
  CloakDialogLoader: Boolean = false;
  
  Types, References, Derefs, Comm, Web: THashedStringList;
  GlobalLists: TList;
  
  MinTop, MinLeft: Integer;
  
  CmdLineList: TStringList;

function GetExeSize(Executable: THandle): Cardinal;
{$IFDEF LINUX}
var
  fs: TFileStream;
  eh: Elf64_EHdr;
{$ENDIF}
begin
  Result := 0; 
  {$IFDEF LINUX}
  fs := TFileStream.Create(MyParamStr(0), fmOpenRead);
  fs.ReadBuffer(eh, SizeOf(Elf64_EHdr));
  fs.Free;
  Result := eh.e_shoff + eh.e_shnum * eh.e_shentsize;
  Exit;
  {$ENDIF}
  {$IFDEF WINDOWS}
  Result := GetWin32LazEXESize; 
  
  {$ENDIF}
end;

function ExtractStubData(StubExecutable, OutputText: String; StubInstance: THandle; ForceSize: Integer = 0): Boolean;
var
  f: File;
  i: Integer;
  p: Pointer;
  StubPos: Integer;
begin
  
  FileMode := 0;
  StubPos := GetEXESize(StubInstance);
  if ForceSize <> 0 then
    StubPos := ForceSize;
  if SuperData = '' then
    AssignFile(f, StubExecutable)
  else
    AssignFile(f, SuperData);
  Reset(f, 1);
  i := FileSize(f);
  if SuperData = '' then
  begin
    if i = StubPos then
    begin
      CloseFile(f);
      Result := false;
      Exit;
    end;
    
    GetMem(p, i);
    BlockRead(f, p^, StubPos);
  end
  else
    GetMem(p, i);
  BlockRead(f, p^, i - StubPos);
  CloseFile(f);
  AssignFile(f, OutputText);
  ReWrite(f, 1);
  if SuperData = '' then
    BlockWrite(f, p^, i - StubPos)
  else
    BlockWrite(f, p^, i);
  CloseFile(f);
  FreeMem(p);
  Result := True;
end;

var
  i, j, k: Integer;
  s, sX, sZ: String;
  StubPos: Integer;
  f: File;
  p: Pointer;
  t: TextFile;
  BOM: Char;
  ui: LongWord;
  datei, sY: String;
  {$IFDEF LINUX}
  {$IFDEF NOGUI}
  tp: TProcess;
  xTerm, xTitle, xRun: String;
  {$ENDIF}
  {$ENDIF}

function LoopExtractArchive: Boolean;
begin
  Result := false;
  
  WriteToLog('    <ExtractArchive>');
  if not MyFileExists(ArchivePath) then
  begin
    if not SilentInstall then
      if not CloakDialogLoader then
        MyApplicationMessageBox(PChar(msg1), PChar(BrandEx), mb_Ok or mb_IconStop)
      else
        MyApplicationMessageBox(PChar(msg1), PChar(BrandEx), mb_Ok or mb_IconStop);
    ExitCode := 14; 
    Exit;
  end;
  if not ExtractArchiveContents(ArchivePath, '', CachedSupportDir, True, True,
    szError, nil, nil, nil, nil, nil) then
  begin
    if not SilentInstall then
       
        MyApplicationMessageBox(PChar(msg2), PChar(BrandEx), mb_Ok or mb_IconStop);
    ExitCode := 15; 
    Exit;
  end;
  {$IFDEF NOGUI}
  if MyFileExists(CachedSupportDir + 'miacstub') then
    if not MyFileExists(CachedSupportDir + 'miaxstub') then
      
      MoveFile(PChar(CachedSupportDir + 'miacstub'), PChar(CachedSupportDir + 'miaxstub'));
  {$ENDIF}
  WriteToLog('    </ExtractArchive>');
  Result := True;
end;

begin
{$IFDEF LINUX}try{$ENDIF}
  
  {$IFDEF DARWIN}
  if AnsiCompareText(ExtractFileName(MyParamStr(0)), 'miafstub') = 0 then
  begin
    {$IFNDEF NOGUI} 
    
    RequireDerivedFormResource := True;
    Application.Scaled:=True;
    Application.Initialize;
    Application.CreateForm(TImageListPool, ImageListPool);
    ImageListPool.Width := 0;
    ImageListPool.Height := 0;
    Application.Run;
    {$ENDIF}
    Exit;
  end;
  {$ENDIF}
  
  sZ := '';
  {$IFDEF DARWIN}
  
  {$ENDIF}
  {$IFNDEF NOGUI}
  RequireDerivedFormResource := True;
  Application.Title := 'InstallAware Multi Platform Setup';
  Application.Scaled := True;
  Application.Initialize;
  {$ENDIF}
  sZ := MyCreateGUID; 
  
  CachedSupportDir := '';
  
  ExePath := AssertDir(ExtractFilePath(MyParamStr(0)));
  ExeNameOnly := ExtractFileName(ChangeFileExt(MyParamStr(0),''));
  TempPath := MyGetTempPathEx;
  CachedTempDir := TempPath;
  ForceDirectories(TempPath);
  
  {$IFDEF BYHAND}
  
  ArchivePath := 'e:\testing project\release\uncompressed\script.res'; 
  {$ELSE}
  if SuperData = '' then
    ArchivePath := ExePath + ExeNameOnly + '.res'
  else
    ArchivePath := SuperData + '.res';
  {$ENDIF}
  CommandLine := MyGetCommandLine;
  
  {$IFDEF WINDOWS}
  if AnsiPos('"', CommandLine) = 1 then
  begin
    Delete(CommandLine, 1, 1);
    Delete(CommandLine, AnsiPos('"', CommandLine), 1); 
  end
  else
    if AnsiPos(' ' , CommandLine) = 0 then 
      CommandLine := ''
    else
      Delete(CommandLine, 1, AnsiPos(' ', CommandLine) ); 
  {$ENDIF}
  
  SilentInstall := FindCmdLineSwitch('s', ['/', '-'], True) or FindCmdLineSwitch('qn', ['/', '-'], True); 
  LoggedInstall := '';
  
  SFXFileName := '';
  for i := 1 to ParamCount do
  begin
    if (AnsiPos('/m=', AnsiLowerCase(MyParamStr(i))) <> 0) or
      (AnsiPos('-m=', AnsiLowerCase(MyParamStr(i))) <> 0) then
      begin
        SFXFileName := MyParamStr(i); 
        Delete(SFXFileName, 1, 3);
        
        Break;
      end;
  end;
  for i := 1 to ParamCount do
    if (AnsiPos('/l=', AnsiLowerCase(MyParamStr(i))) <> 0) or
      (AnsiPos('-l=', AnsiLowerCase(MyParamStr(i))) <> 0) then
      begin
        LoggedInstall := MyParamStr(i); 
          Delete(LoggedInstall, 1, 3);
        LoggedInstall := ExpandFileName(LoggedInstall);
        Break;
      end;
  
  for i := 1 to ParamCount do
    if (MyParamStr(i)[1] <> '/') and (MyParamStr(i)[1] <> '-') then
      if AnsiPos('=', MyParamStr(i)) <> 0 then
      begin
        sX := MyParamStr(i);
        OverrideVars.Add(AnsiUpperCase(Copy(sX, 1, AnsiPos('=', sX) -1)));
        Delete(sX, 1, AnsiPos('=', sX));
        OverrideVars.Add(sX);
      end;
  for i := 1 to ParamCount do
    if (MyParamStr(i)[1] <> '/') and (MyParamStr(i)[1] <> '-') then
      if AnsiPos(':', MyParamStr(i)) <> 0 then
      begin
        sX := MyParamStr(i);
        OverrideVarsEx.Add(AnsiUpperCase(Copy(sX, 1, AnsiPos(':', sX) -1)));
        Delete(sX, 1, AnsiPos(':', sX));
        OverrideVarsEx.Add(sX);
      end;
  
  WriteToLog('<InstallAware>');
  
  WriteToLog('    <SupportDir>');
  i := 0;
  repeat
    i := i +1;
  until (not DirectoryExists(TempPath + 'miax' + IntToStr(i)))
    and (not MyFileExists(TempPath + 'miax' + IntToStr(i)));
  CachedSupportDir := TempPath + 'miax' + IntToStr(i) + PathDelim;
  ForceDirectories(CachedSupportDir);
  WriteToLog('    </SupportDir>');
  try
    {$IFNDEF BYHAND}
    {$IFDEF DARWIN} 
    if not LoopExtractArchive then
      Exit; 
    WriteToLog('    <StubData>');
    FileMode := 0;
    AssignFile(f, CachedSupportDir + ExtractFileNameOnly(ExtractFileName(DeAssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(MyParamStr(0))))))))) + '.msi');
    
    Reset(f, 1);
    i := FileSize(f);
    GetMem(p, i);
    BlockRead(f, p^, i);
    CloseFile(f);
    AssignFile(f, TempPath + sZ);
    ReWrite(f, 1);
    BlockWrite(f, p^, i);
    CloseFile(f);
    FreeMem(p);
    DeleteFile(ExtractFileNameOnly(MyParamStr(0)) + '.msi');
    WriteToLog('    </StubData>');
    {$ELSE}
    
    if SuperData = '' then 
    begin
      WriteToLog('    <StubSize>');
      FileMode := 0;
      StubPos := GetEXESize(HInstance);
      AssignFile(f, MyParamStr(0));
      Reset(f, 1);
      i := FileSize(f);
      if i = StubPos then
      begin
        CloseFile(f);
        if not SilentInstall then 
          MyApplicationMessageBox('For internal use only', PChar(BrandEx), mb_Ok or mb_IconStop);
        ExitCode := 13; 
        Exit;
      end;
      WriteToLog('    </StubSize>');
      
      WriteToLog('    <StubData>');
      GetMem(p, i);
      BlockRead(f, p^, GetEXESize(HInstance));
      BlockRead(f, p^, i - GetEXESize(HInstance));
      CloseFile(f);
      
      AssignFile(f, TempPath + sZ);
      ReWrite(f, 1);
      BlockWrite(f, p^, i - GetEXESize(HInstance));
      CloseFile(f);
      FreeMem(p);
      WriteToLog('    </StubData>');
    end
    else
    begin
      WriteToLog('    <StubDataSuper>');
      FileMode := 0;
      AssignFile(f, MyParamStr(0) + '.stubdata');
      
      Reset(f, 1);
      i := FileSize(f);
      GetMem(p, i);
      BlockRead(f, p^, i);
      CloseFile(f);
      AssignFile(f, TempPath + sZ);
      ReWrite(f, 1);
      BlockWrite(f, p^, i);
      CloseFile(f);
      FreeMem(p);
      WriteToLog('    </StubDataSuper>');
    end;
    {$ENDIF}
    {$ELSE}
    {$ENDIF}
    
    WriteToLog('    <GlobalLists>');
    GlobalLists := TList.Create;
    Types := THashedStringList.Create;
    References := THashedStringList.Create;
    Derefs := THashedStringList.Create;
    Comm := THashedStringList.Create;
    Web := THashedStringList.Create;
    
    {$IFNDEF BYHAND}
    AssignFile(t, TempPath + sZ, cp_utf8);
    {$ELSE}
    
    AssignFile(t, 'e:\testing project\release\uncompressed\script.exe', cp_utf8);
    {$ENDIF}
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
    while s <> '$' do
    begin
      Types.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      References.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      Derefs.Add(s);
      ReadLn(t, s);
    end;
    while Derefs.IndexOf('$WILD_DOLLAR$') <> -1 do
      Derefs[Derefs.IndexOf('$WILD_DOLLAR$')] := '$';
    while Derefs.IndexOf('$DOLLAR$') <> -1 do
      Derefs[Derefs.IndexOf('$DOLLAR$')] := '$';
    ReadLn(t, s);
    while s <> '$' do
    begin
      Comm.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, ProductGUID);
    ReadLn(t, CachedTitle);
    CachedTitleOrgLang := CachedTitle; 
    
    ReadLn(t, s);
    while s <> '$' do
    begin
      
      ReadLn(t, s);
    end;
    ReadLn(t, carPublisher);
    ReadLn(t, carContact);
    ReadLn(t, carHelp);
    ReadLn(t, carUpdates);
    ReadLn(t, carComments);
    ReadLn(t, ProjectStructVersion);
    ReadLn(t, s);
    while s <> '$' do
    begin
      WeblockPasswords.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      Web.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, MediaLayout);
    ReadLn(t, s);
    while s <> '$' do
    begin
      ComponentSpaces.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, RevisionGUID);
    ReadLn(t, s);
    while s <> '$' do
    begin
      NewSourceListSource.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    CachedMultiLang := s = 'TRUE';
    ReadLn(t, CachedDefaultLanguage);
    CachedDefaultLanguageEx := CachedDefaultLanguage;
    ReadLn(t, s);
    while s <> '$' do
    begin
      CommandHeaders.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      CompilerVariableDirect.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, ui);
    ReadLn(t, s);
    while s <> '$' do
    begin
      PullMapDirect.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, NativeTotal);
    ReadLn(t, s);
    while s <> '$' do
    begin
      NativeFileSourceStack.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      IncludeDepthDirect.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, datei);
    CloseFile(t);
    {$IFDEF NOGUI}
    
    if MyFileExists(AssertDir(ExtractFilePath(MyParamStr(0))) + ExtractFileNameOnly(MyParamStr(0)) + 'Ex'
      {$IFDEF WINDOWS} + '.exe' {$ENDIF}) then
    begin
      
      CmdLineList := TStringList.Create;
      for i := 1 to ParamCount do
        CmdLineList.Add(MyParamStr(i));
      
      i := LaunchAppAndWait2(AssertDir(ExtractFilePath(MyParamStr(0))) + ExtractFileNameOnly(MyParamStr(0)) + 'Ex'
        {$IFDEF WINDOWS} + '.exe' {$ENDIF}, CmdLineList, True, True);
      
      CmdLineList.Free;
      if i <> 127 then
      begin
        {$IFDEF DARWIN} 
        
        if CachedSupportDir <> '' then
          if DirectoryExists(CachedSupportDir) then
          begin
            WipeFolder(CachedSupportDir, True);
            WipeFolder(CachedSupportDir, True);
            WipeFolder(CachedSupportDir, True);
            RemoveDir(PChar(CachedSupportDir));
          end;
        
        {$ENDIF}
        DeleteFile(PChar(TempPath + sZ));
        ExitCode := i; 
        Exit;
      end;
      
      {$IFDEF LINUX} 
      if not IsConsoleAvailable then
      begin
        tp := TProcess.Create(nil);
        try
          if MyFileExists('/usr/bin/x-terminal-emulator') then
          begin
            xTerm := '/usr/bin/x-terminal-emulator';
            xTitle := '--title';
            xRun := '-e';
          end
          else
          if MyFileExists('/usr/bin/gnome-terminal') then
          begin
            xTerm := '/usr/bin/gnome-terminal';
            xTitle := '--title';
            xRun := '-x';
          end
          else
          if MyFileExists('/usr/bin/xterm') then
          begin
            xTerm := '/usr/bin/xterm';
            xTitle := '-T';
            xRun := '-e';
          end
          else
          if MyFileExists('/usr/bin/mate-terminal') then
          begin
            xTerm := '/usr/bin/mate-terminal';
            xTitle := '--title';
            xRun := '-x';
          end
          else
          if MyFileExists('/usr/bin/konsole') then
          begin
            xTerm := '/usr/bin/konsole';
            xTitle := '--title';
            xRun := '-e';
          end
          else
          begin
            
            ExitCode := 256;
            Exit;
          end;
          
          tp.Executable := xTerm;
          tp.Parameters.Add(xTitle);
          tp.Parameters.Add('InstallAware');
          tp.Parameters.Add(xRun);
          tp.Parameters.Add(ParamStr(0)); 
          tp.Parameters.Add('ff'); 
          for i := 1 to ParamCount do
            tp.Parameters.Add(MyParamStr(i));
          tp.CurrentDirectory := AssertDir(ExtractFilePath(ParamStr(0)));
          tp.Options := [poWaitOnExit];
          
          tp.Execute;
          
          tp.WaitOnExit;
          
          ExitCode := tp.ExitCode; 
          if (AnsiCompareText(RuntimeSubstituteCompilerVariables('#BUILDMODE#'), 'CD') <> 0) then 
            while not MyFileExists(tp.CurrentDirectory + 'ff') do
              Sleep(314);
          
          tp.Free;
        except
          ExitCode := 256;
          
        end;
        Exit;
        
      end;
      {$ENDIF}
      
    end;
    {$ENDIF}
    
    if ((AnsiCompareText(RuntimeSubstituteCompilerVariables('#UAC#'),
      'requireAdministrator') = 0) and ({$IFNDEF WINDOWS}FpGetEUID <> 0{$ELSE}not IsUserAdmin{$ENDIF})) then
    begin
      CmdLineList := TStringList.Create;
      for i := 1 to ParamCount do
        CmdLineList.Add(MyParamStr(i));
      {$IFDEF DARWIN}macOSElevator{$ELSE}{$IFDEF LINUX}LinuxElevator{$ELSE}WindowsElevator{$ENDIF}{$ENDIF}
        ({$IFDEF DARWIN}StringReplace({$ENDIF}MyParamStr(0){$IFDEF DARWIN},
        '/' + Ventura +  '/miaxstub', '/MacOS/miaxstub', [rfReplaceAll, rfIgnoreCase]){$ENDIF}, CmdLineList);
        
      CmdLineList.Free;
      DeleteFile(PChar(TempPath + sZ));
      {$IFDEF DARWIN} 
      
      if CachedSupportDir <> '' then
        if DirectoryExists(CachedSupportDir) then
        begin
          WipeFolder(CachedSupportDir, True);
          WipeFolder(CachedSupportDir, True);
          WipeFolder(CachedSupportDir, True);
          RemoveDir(PChar(CachedSupportDir));
        end;
      
      {$ENDIF}
      Exit;
    end;
    
    if Length(datei) = 8 then
    begin
      Insert('-', datei, 7);
      Insert('-', datei, 5);
    end;
    CachedLanguageCompilerVariableValueEx := RuntimeSubstituteCompilerVariables('#LOCALIZATION_PRECEDENCE#');
    if AnsiCompareText(RuntimeSubstituteCompilerVariables('#CLOAK_DIALOG_LOADER#'), 'TRUE') = 0 then
      CloakDialogLoader := True;
    
    {$IFNDEF NOGUI}
    if false then 
    begin
      WriteToLog('  <SetupSplash>');
      if not SilentInstall then
        if not (FindCmdLineSwitch('update', ['/', '-'], True) or FindCmdLineSwitch('updatesetup', ['/', '-'], True)) then
        begin
          SetupSplash := TSetupSplash.Create(nil);
          SetupInit := TSetupInit.Create(nil);
          if MyFileExists(ExePath + 'setup.png') then
          begin
            SetupSplash.Image.Picture.LoadFromFile(ExePath + 'setup.png');
            SetupSplash.Image.AutoSize := True;
            SetupSplash.Position := poScreenCenter;
            SetupSplash.AutoSize := True;
            SetupSplash.Show;
            SetupSplash.Update;
            SetupInit.Left := SetupSplash.Left + SetupSplash.Width div 2 + 50;
            SetupInit.Top := SetupSplash.Top + SetupSplash.Height + 25;
            MinTop := Screen.Height - 45 - SetupInit.Height;
            MinLeft := Screen.Width - 25 - SetupInit.Width;
            if SetupInit.Top > MinTop then SetupInit.Top := MinTop;
            if SetupInit.Left > MinLeft then SetupInit.Left := MinLeft;
          end
          else
            SetupInit.Position := poScreenCenter;
          SetupInit.Show;
          SetupInit.Update;
        end;
    end;
    {$ENDIF}
    
    GlobalLists.Add(Derefs);
    DeleteFile(PChar(TempPath + sZ));
    WriteToLog('    </GlobalLists>');
    {$IFNDEF DARWIN}
    if not LoopExtractArchive then Exit;
    if MyFileExists(CachedSupportDir + 'libeay32.dll') then
      FileCopyFile(PChar(CachedSupportDir + 'libeay32.dll'),
        PChar(AssertDir(ExtractFilePath(MyParamStr(0))) + 'libeay32.dll'),
        false);
    if MyFileExists(CachedSupportDir + 'ssleay32.dll') then
      FileCopyFile(PChar(CachedSupportDir + 'ssleay32.dll'),
        PChar(AssertDir(ExtractFilePath(MyParamStr(0))) + 'ssleay32.dll'),
        false);
    if MyFileExists(CachedSupportDir + 'libcrypto.so.1.1') then
    begin
      FileCopyFile(PChar(CachedSupportDir + 'libcrypto.so.1.1'),
        PChar(AssertDir(ExtractFilePath(MyParamStr(0))) + 'libcrypto.so.1.1'),
        false);
      
      LoadLibrary(PChar(AssertDir(ExtractFilePath(MyParamStr(0))) + 'libcrypto.so.1.1'));
      
    end;
    if MyFileExists(CachedSupportDir + 'libssl.so.1.1') then
    begin
      FileCopyFile(PChar(CachedSupportDir + 'libssl.so.1.1'),
        PChar(AssertDir(ExtractFilePath(MyParamStr(0))) + 'libssl.so.1.1'),
        false);
      LoadLibrary(PChar(AssertDir(ExtractFilePath(MyParamStr(0))) + 'libssl.so.1.1'));
    end;
    {$ENDIF}
    
    CachedDataDir := ExePath + 'data' + PathDelim;
    SuperCachedDataDirBackup := CachedDataDir; 
    WriteToLog('    <Dialogs>');
    j := 0;
    for i := 1 to Types.Count do
      if Types[i -1] = 'Display Dialog' then
        if Comm[i -1] <> 'C' then
          j := j +1;
    if false then
      if not SilentInstall then
        if not (FindCmdLineSwitch('update', ['/', '-'], True) or FindCmdLineSwitch('updatesetup', ['/', '-'], True)) then
        begin
          {$IFNDEF NOGUI}
          SetupInit.ProgressBar.Min := 0;
          SetupInit.ProgressBar.Max := j;
          SetupInit.ProgressBar.Position := 1;
          SetupInit.Update;
          {$ENDIF}
        end;
    InitializeDlgApi(CachedSupportDir, True);
    for i := 1 to Types.Count do
      if Types[i -1] = 'Display Dialog' then
        if Comm[i -1] <> 'C' then
        begin
          LoadDesign(IntToStr(i -1), PChar(GetDialogResourcePath(ReadOffset(GlobalLists, References[i -1], 1))));
          if not SilentInstall then
            if not (FindCmdLineSwitch('update', ['/', '-'], True) or FindCmdLineSwitch('updatesetup', ['/', '-'], True)) then
              if false then
              begin
                {$IFNDEF NOGUI}
                SetupInit.ProgressBar.Position := SetupInit.ProgressBar.Position +1;
                SetupInit.Update;
                if SetupSplash.Visible then SetupSplash.Update;
                {$ENDIF}
              end;
        end;
    WriteToLog('    </Dialogs>');
    
    if not SilentInstall then
      if not (FindCmdLineSwitch('update', ['/', '-'], True) or FindCmdLineSwitch('updatesetup', ['/', '-'], True)) then
        if false then
        begin
          {$IFNDEF NOGUI}
          SetupInit.Hide;
          SetupInit.Free;
          if SetupSplash.Visible then
          begin
            SetupSplash.Hide;
            SetupSplash.Free;
          end;
          {$ENDIF}
        end;
    {$IFNDEF NOGUI}
    if not CloakDialogLoader then
      WriteToLog('  </SetupSplash>');
    {$ENDIF}
    WriteToLog('  <RunScript>');
    {$IFNDEF LICENSED}
    Randomize;
    
    if Random(5) = 1 then 
    begin
      MyMessageBox(0, PChar('This installation was created with ' + Brand + '.'
        + MyLineEnding + MyLineEnding
        + 'Setups built with the licensed version of InstallAware Multi Platform do not display this notice.'),
        PChar(BrandEx), mb_OK or mb_IconExclamation);
      OpenURL('https://www.installaware.com/buyx.asp');
    end;
    {$ENDIF}
    
    RunScript(Types, References, Comm, Web, GlobalLists, nil, 
      
      IncludeTrailingPathDelimiter(ExtractFilePath(MyParamStr(0)))
        {$IFNDEF DARWIN}
        + ExtractFileNameOnly(MyParamStr(0))
        {$ELSE}
        + ExtractFileNameOnly(ExcludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(MyParamStr(0))))))))
        {$ENDIF}
        + '.msi');
    WriteToLog('  </RunScript>');
    WriteToLog('  <Free>');
    GlobalLists.Free;
    Types.Free;
    References.Free;
    Derefs.Free;
    Comm.Free;
    Web.Free;
    
    WriteToLog('  </Free>');
  except
    on E: Exception do
    begin
      if not SilentInstall then
        MyApplicationMessageBox(PChar(msg4 + E.Message), PChar(BrandEx), mb_Ok or mb_IconStop);
      ExitCode := 11;
    end;
  end;
  WriteToLog('  <CachedSupportDir>');
  if CachedSupportDir <> '' then
    if DirectoryExists(CachedSupportDir) then
    begin
      WipeFolder(CachedSupportDir, True);
      WipeFolder(CachedSupportDir, True);
      WipeFolder(CachedSupportDir, True);
      RemoveDir(PChar(CachedSupportDir));
    end;
  WriteToLog('  </CachedSupportDir>');
  WriteToLog('</InstallAware>');
  {$IFDEF WINDOWS}
  if SingleDanger then
    TerminateProcess(GetCurrentProcess, 0); 
  {$ENDIF}
{$IFDEF LINUX}
finally
  if AnsiCompareText(ParamStr(1), 'ff') = 0 then
  begin
    
    AssignFile(t, AssertDir(ExtractFilePath(ParamStr(0))) + 'ff');
    ReWrite(t);
    CloseFile(t);
    
  end;
  
end;
{$ENDIF}
end.

