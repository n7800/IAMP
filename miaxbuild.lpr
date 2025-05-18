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
program miaxbuild;

{$APPTYPE CONSOLE}
{$mode objfpc}{$H+}
{$DEFINE UseCThreads}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  mUtils,
  SysUtils, Controls, Classes, mbuild, mbuildthread, mAutomate, mscriptexec,
  interfaces{$IFDEF WINDOWS}, Windows{$ENDIF};
  
var
  CurrentDir: String;
  i, j: Integer;
  l: TStringList;
  p: PChar;
  s, sX: String;
  ProjectFile: String;
  Conditionals: String;
  BuildMode, CompressionGrade: Integer;
  OutputFolder: String;
  PackagePassword, PackageLanguage: String;
  CompileError: String;
  CompileLine: Integer;
  PatchReference: String;
  SkipSign: Boolean;

procedure EnsureOverriddenConditional(var Conditionals: String; Conditional, EnsureValue: String);
var
  i: Integer;
  l: TStringList;
  s, sX: String;
begin
  l := TStringList.Create;
  l.CommaText := Conditionals;
  for i := 1 to l.Count do
  begin
    s := Copy(l[i -1], 1, AnsiPos('=', l[i -1]) -1);
    sX := Copy(l[i -1], AnsiPos('=', l[i -1]) +1, Length(l[i -1]));
    if AnsiCompareText(s, Conditional) = 0 then
    begin
      l[i -1] := s + '=' + EnsureValue;
      Break;
    end
    else
      if i = l.Count then
        l.Add(Conditional + '=' + EnsureValue);
  end;
  if l.Count = 0 then
    l.Add(Conditional + '=' + EnsureValue);
  Conditionals := l.CommaText;
  l.Free;
end;

procedure EnsureOverriddenConditionalEx(var Conditionals: String; ConditionalPair: String);
var
  s, sX: String;
begin
  s := Copy(ConditionalPair, 1, AnsiPos('=', ConditionalPair) -1);
  sX := Copy(ConditionalPair, AnsiPos('=', ConditionalPair) +1, Length(ConditionalPair));
  EnsureOverriddenConditional(Conditionals, s, sX);
end;

begin
  
  j := mrCancel;
  s := '';
  CurrentDir := MyGetCurrentDir;
  
  WriteLn(' _____ ______   ________');
  {$IFDEF DARWIN}
  WriteLn('|\   _ \  _   \|\   __  \ InstallAware Multi Platform Compiler (Anatolian Pars)');
  {$ELSE}
  {$IFDEF WINDOWS}
  WriteLn('|\   _ \  _   \|\   __  \ InstallAware Multi Platform Compiler (Loop)');
  {$ELSE}
  WriteLn('|\   _ \  _   \|\   __  \ InstallAware Multi Platform Compiler (Point Reyes)');
  {$ENDIF}
  {$ENDIF}
  WriteLn('\ \  \\\__\ \  \ \  \|\  \ Copyright(C) 1996-2025 InstallAware Software.');
  WriteLn(' \ \  \\|__| \  \ \   ____\ All rights reserved.');
  WriteLn('  \ \  \    \ \  \ \  \___|');
  WriteLn('   \ \__\    \ \__\ \__\');
  WriteLn('    \|__|     \|__|\|__|');
  WriteLn;
  
  ProjectFile := ParamStr(1);
  if ProjectFile <> '' then
    ProjectFile := MyExtractFileDriveFixUp(ProjectFile, CurrentDir);
  if not MyFileExists(ProjectFile) then s := 'ERROR: Project file not found';
  
  PackageLanguage := '';
  for i := 2 to ParamCount do
    if (Pos('/l=', AnsiLowerCase(ParamStr(i))) <> 0) or
      (Pos('-l=', AnsiLowerCase(ParamStr(i))) <> 0) then
      begin
        PackageLanguage := ParamStr(i);
        Delete(PackageLanguage, 1, 3);
        Break;
      end;
  
  PackagePassword := '';
  for i := 2 to ParamCount do
    if (Pos('/p=', AnsiLowerCase(ParamStr(i))) <> 0) or
      (Pos('-p=', AnsiLowerCase(ParamStr(i))) <> 0) then
      begin
        PackagePassword := ParamStr(i);
        Delete(PackagePassword, 1, 3);
        Break;
      end;
  
  OutputFolder := '';
  for i := 2 to ParamCount do
    if (Pos('/o=', AnsiLowerCase(ParamStr(i))) <> 0) or
      (Pos('-o=', AnsiLowerCase(ParamStr(i))) <> 0) then
      begin
        OutputFolder := ParamStr(i);
        Delete(OutputFolder, 1, 3);
        Break;
      end;
  if OutputFolder <> '' then
  begin
    OutputFolder := MyExtractFileDriveFixUp(OutputFolder, CurrentDir);
    if not DirectoryExists(OutputFolder) then
    try
      if not SysUtils.ForceDirectories(OutputFolder) then
        s := 'ERROR: Invalid output folder';
    except
      s := 'ERROR: Invalid output folder';
    end;
  end;
  
  ConsoleBuildMirrorBufferFile := '';
  for i := 2 to ParamCount do
    if (Pos('/d=', AnsiLowerCase(ParamStr(i))) <> 0) or
      (Pos('-d=', AnsiLowerCase(ParamStr(i))) <> 0) then
      begin
        ConsoleBuildMirrorBufferFile := ParamStr(i);
        Delete(ConsoleBuildMirrorBufferFile, 1, 3);
        Break;
      end;
  if ConsoleBuildMirrorBufferFile <> '' then
  begin
    ConsoleBuildMirrorBufferFile := MyExtractFileDriveFixUp(ConsoleBuildMirrorBufferFile, CurrentDir);
    if not DirectoryExists(ExtractFilePath(ConsoleBuildMirrorBufferFile)) then
    try
      if not SysUtils.ForceDirectories(ExtractFilePath(ConsoleBuildMirrorBufferFile)) then
        s := 'ERROR: Invalid log file path';
      if not DirectoryExists(ExtractFilePath(ConsoleBuildMirrorBufferFile)) then
        s := 'ERROR: Invalid log file path';
    except
      s := 'ERROR: Invalid log file path';
    end;
  end;
  
  ConsoleBuildMirrorBuffer.Add(' _____ ______   ________');
  {$IFDEF DARWIN}
  ConsoleBuildMirrorBuffer.Add('|\   _ \  _   \|\   __  \ InstallAware Multi Platform Compiler (Anatolian Pars)');
  {$ELSE}
  {$IFDEF WINDOWS}
  ConsoleBuildMirrorBuffer.Add('|\   _ \  _   \|\   __  \ InstallAware Multi Platform Compiler (Loop)');
  {$ELSE}
  ConsoleBuildMirrorBuffer.Add('|\   _ \  _   \|\   __  \ InstallAware Multi Platform Compiler (Point Reyes)');
  {$ENDIF}
  {$ENDIF}
  ConsoleBuildMirrorBuffer.Add('\ \  \\\__\ \  \ \  \|\  \ Copyright(C) 1996-2025 InstallAware Software.');
  ConsoleBuildMirrorBuffer.Add(' \ \  \\|__| \  \ \   ____\ All rights reserved.');
  ConsoleBuildMirrorBuffer.Add('  \ \  \    \ \  \ \  \___|');
  ConsoleBuildMirrorBuffer.Add('   \ \__\    \ \__\ \__\');
  ConsoleBuildMirrorBuffer.Add('    \|__|     \|__|\|__|');
  ConsoleBuildMirrorBuffer.Add('');
  
  BuildMode := -1;
  for i := 2 to ParamCount do
    if (Pos('/b=', AnsiLowerCase(ParamStr(i))) <> 0) or
      (Pos('-b=', AnsiLowerCase(ParamStr(i))) <> 0) then
      begin
        sX := ParamStr(i);
        Delete(sX, 1, 3);
        try
          BuildMode := StrToInt(sX);
        except
          s := 'ERROR: Invalid build type';
          BuildMode := -1;
        end;
        if (BuildMode < 0) or (BuildMode > 3) then
          s := 'ERROR: Invalid build type';
        Break;
      end;
  
  CompressionGrade := -1;
  for i := 2 to ParamCount do
    if (Pos('/7=', AnsiLowerCase(ParamStr(i))) <> 0) or
      (Pos('-7=', AnsiLowerCase(ParamStr(i))) <> 0) then
      begin
        sX := ParamStr(i);
        Delete(sX, 1, 3);
        try
          CompressionGrade := StrToInt(sX);
        except
          s := 'ERROR: Invalid compression grade';
          CompressionGrade := -1;
        end;
        if (CompressionGrade < 0) or (CompressionGrade > 8) then
          s := 'ERROR: Invalid compression grade';
        Break;
      end;
  
  SkipSign := false;
  for i := 2 to ParamCount do
    if AnsiPos('/nosign', AnsiLowerCase(ParamStr(i))) <> 0 then
      SkipSign := True;
  
  Conditionals := '';
  
  for i := 2 to ParamCount do
    if (ParamStr(i)[1] <> PathDelim) and (ParamStr(i)[1] <> '-') then
      if Pos('=', ParamStr(i)) <> 0 then
      begin
        EnsureOverriddenConditionalEx(Conditionals, ParamStr(i));
        
      end;
  if not (s = '') then
  begin
    WriteLn('Usage: miaxbuild <projectfile> [/o=<outputfolder>] [/b=<buildtype>] [/r]');
    WriteLn('                 [+qf | -qf] [+qr | -qr] [+qi | -qi] [+qib | -qib]');
    WriteLn('                 [/p=<password>] [/l=<language>] [/pr=<patch reference>]');
    WriteLn('                 [/d=<logfile>] [/7=<grade>] [/nosign]');
    WriteLn('                 [COMPILERVAR1=VALUE1 ... COMPILERVARN=VALUEN]');
    WriteLn;
    WriteLn('       /o          Override default output folder');
    WriteLn('       /b          Override default build type');
    WriteLn('       buildtype   0  Uncompressed directory layout');
    WriteLn('                   1  Compressed Single Self Installing File');
    WriteLn('                   2  Compressed Web-Based File');
    WriteLn('       /r          Generate new revision code');
    WriteLn('       /p          Specify 256 bit AES encryption password');
    WriteLn('       /l          Specify default installation language');
    WriteLn('       /d          Specify path to save full build output');
    WriteLn('       /7          Override default compression grade');
    WriteLn('       grade       0  Store data uncompressed');
    WriteLn('                   1  Fastest compression using all CPU cores');
    WriteLn('                   2  Fast compression using all CPU cores');
    WriteLn('                   3  Good compression using up to 3 CPU cores');
    WriteLn('                   4  Best 32-bit compression using up to 2 CPU cores');
    WriteLn('                   5  Better 64-bit compression using up to 2 CPU cores');
    WriteLn('                   6  Best 64-bit compression using up to 2 CPU cores');
    WriteLn('                   7  64-bit-only compression with binary optimization');
    WriteLn('                   8  64-bit-only compression with heuristic optimization');
    WriteLn('       /nosign     Skip code signing');
    WriteLn;
    WriteLn(s);
    ExitCode := 2;
    Flush(Output);
    Exit;
    
  end;
  
  try
    PROJDIR := AssertDir(ExtractFilePath(ProjectFile));
    s := InitializeBuildContext(ProjectFile, Conditionals, PackageLanguage, PackagePassword, BuildMode, CompressionGrade, SkipSign);
    thProjectStruct.BuildDebug := false; 
    if s <> '' then
      raise Exception.Create(s);
    if OutputFolder <> '' then
    begin
      thProjectStruct.BuildInFolder:= false;
      StrCopy(thProjectStruct.BuildCustomFolder, PChar(AssertDir(OutputFolder)));
      
    end;
    if BuildMode <> -1 then
      thProjectStruct.BuildLayout := BuildMode;
    if FindCmdLineSwitch('r', True) then
      StrCopy(thProjectStruct.Revision, PChar(CreateGUIDUp));
      
    CompileLine := CompileScript(thScriptTypes, thScriptReferences, thScriptComments, thGlobalLists, CompileError);
    if CompileLine <> -1 then
    begin
      WriteLn('Source File  : ' + GetUnitName(PullMapDirect[CompileLine]));
      WriteLn('Line Number  : ' + IntToStr(GetLineNumber(PullMapDirect[CompileLine]) +1));
      WriteLn;
      WriteLn('Compile Error: ' + CompileError);
      Flush(Output);
      if ConsoleBuildMirrorBufferFile <> '' then
        ConsoleBuildMirrorBuffer.SaveToFile(ConsoleBuildMirrorBufferFile, TEncoding.UTF8);
      ExitCode := 3;
      FinalizeBuildContext;
      Flush(Output);
      if ConsoleBuildMirrorBufferFile <> '' then
        ConsoleBuildMirrorBuffer.SaveToFile(ConsoleBuildMirrorBufferFile, TEncoding.UTF8);
      Exit;
    end;
    Build := TBuild.Create(nil);
    mbuild.IsConsole := True;
    
    Build.FormShow(nil);
    j := Build.ModalResult;
    
    for i := 1 to Build.Output.Lines.Count do
      WriteLn(Build.Output.Lines[i -1]);
    
    Build.Free;
    
    FinalizeBuildContext;
    
  except
    on E: Exception do
    begin
      
      WriteLn('ERROR: ' + E.Message);
      ExitCode := 3;
      Flush(Output);
      if ConsoleBuildMirrorBufferFile <> '' then
        ConsoleBuildMirrorBuffer.SaveToFile(ConsoleBuildMirrorBufferFile, TEncoding.UTF8);
      
      Exit;
      
    end;
  end;
  
  WriteLn;
  if j = mrOk then
  begin
    j := 0;
    WriteLn('Build completed successfully');
  end
  else
  begin
    j := 1;
    WriteLn('Build failed');
    
  end;
  ExitCode := j;
  Flush(Output);
  if ConsoleBuildMirrorBufferFile <> '' then
    ConsoleBuildMirrorBuffer.SaveToFile(ConsoleBuildMirrorBufferFile, TEncoding.UTF8);
  Exit;
end.
