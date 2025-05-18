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
unit mAutomate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, INIFiles, mUtils;

type
  TProjectStruct = record
    
    BuildDebug: Boolean;
    BuildLayout: Integer;
    CompressProfile: array[0..MAX_PATH *4] of Char;
    BuildInFolder: Boolean;
    BuildCustomFolder: array[0..MAX_PATH *4] of Char;
    OutputFile: array[0..MAX_PATH *4] of Char;
    AutoIncrement: Boolean;
    AutoHash: Boolean;
    Conditionals: array[0..MAX_PATH *100] of Char; 
    
    Manufacturer, Name, Code, UpgradeCode, Version, Language: array[0..MAX_PATH *4] of Char;
    Title, Subject, Author, Comments, Revision: array[0..MAX_PATH *4] of Char;
    
    arPublisher, arContact, arHelp, arUpdates, arComments: array[0..MAX_PATH *4] of Char;
    
    aSign: Boolean; aCertificate, aKey, aTimeStamp, aInfo: array[0..MAX_PATH *4] of Char;
    
    pDisplay, pDescription, pClass: array[0..MAX_PATH *4] of Char;
    pWhole, pMissing, pLarge, pRemove, pCreate, pDebug: Boolean;
    
    MultiLang: Boolean;
    
    PassEnabled: Boolean;
    Password: array[0..MAX_PATH *4] of Char;
    CodeSignPassword: array[0..MAX_PATH *4] of Char;
    
    cFiles, cRegistry, cFeatures, cHashes: Boolean;
  end;

{$IFNDEF SCRIPTING}

function InitializeBuildContext(Project, Conditionals: String;
  LanguageEx: String = ''; PasswordEx: String = ''; OverBuildMode: Integer = -1;
  CompressGrade: Integer = -1; SkipSign: Boolean = false): String;
function InjectIncludesFromFile(FileName: String; Position: Integer): Boolean;
procedure FinalizeBuildContext;
{$ENDIF}

procedure InitializeProject(ProjectStruct: TProjectStruct);
procedure SetScriptFile(ScriptFile: String);
procedure ClearProjectDialogs;
procedure ClearProjectSupport;
procedure ClearProjectInclude;
procedure AddProjectDialog(Dialog: String);
procedure AddProjectSupport(Support: String);
procedure AddProjectInclude(Script: String);
procedure FinalizeProject(SaveFile: String; ScriptLines: Integer);

procedure InitializeScript;
procedure EmitAddCommand(Command: String; Parameters: String);
procedure FinalizeScript(SaveFile: String);
function GetTotalLines: Integer;

var
  
  thBuildToFolder, thCurrentProjectName: String;
  thProjectStruct: TProjectStruct;
  thScriptTypes, thScriptReferences, thScriptComments, thScriptFetches, thProhibitedScriptFetches: THashedStringList;
  thDialogFiles, thSupportFiles, thMergeFiles, thPatchFiles, thIncludeFiles, thGlobal: THashedStringList;
  thGlobalLists: TList;
  
  IncludeDepthInteger: Integer;
  IncludeDepthStack: TStringList;

implementation

{$IFNDEF SCRIPTING}
uses
  mscriptexec;
{$ENDIF}

var
  Types, References, Dereferences: TStringList;
  Struct: TProjectStruct;
  DialogFiles, SupportFiles, MergeFiles, PatchFiles, IncludeFiles: THashedStringList;
  Script: String;

procedure InitializeProject(ProjectStruct: TProjectStruct);
begin
  DialogFiles := THashedStringList.Create;
  SupportFiles := THashedStringList.Create;
  MergeFiles := THashedStringList.Create;
  PatchFiles := THashedStringList.Create;
  IncludeFiles := THashedStringList.Create;
  Struct.BuildDebug := ProjectStruct.BuildDebug;
  Struct.BuildLayout := ProjectStruct.BuildLayout;
  Struct.CompressProfile := ProjectStruct.CompressProfile;
  Struct.BuildInFolder := ProjectStruct.BuildInFolder;
  Struct.BuildCustomFolder := ProjectStruct.BuildCustomFolder;
  Struct.Manufacturer := ProjectStruct.Manufacturer;
  Struct.Name := ProjectStruct.Name;
  Struct.Code := ProjectStruct.Code;
  Struct.UpgradeCode := ProjectStruct.UpgradeCode;
  Struct.Version := ProjectStruct.Version;
  Struct.Language := ProjectStruct.Language;
  Struct.Title := ProjectStruct.Title;
  Struct.Subject := ProjectStruct.Subject;
  Struct.Author := ProjectStruct.Author;
  Struct.Comments := ProjectStruct.Comments;
  Struct.Revision := ProjectStruct.Revision;
  Struct.arPublisher := ProjectStruct.arPublisher;
  Struct.arContact := ProjectStruct.arContact;
  Struct.arHelp := ProjectStruct.arHelp;
  Struct.arUpdates := ProjectStruct.arUpdates;
  Struct.arComments := ProjectStruct.arComments;
  Struct.OutputFile := ProjectStruct.OutputFile;
  Struct.AutoIncrement := ProjectStruct.AutoIncrement;
  Struct.AutoHash := ProjectStruct.AutoHash;
  Struct.aSign := ProjectStruct.aSign;
  Struct.aCertificate := ProjectStruct.aCertificate;
  Struct.aKey := ProjectStruct.aKey;
  Struct.aTimeStamp := ProjectStruct.aTimeStamp;
  Struct.aInfo := ProjectStruct.aInfo;
  Struct.Conditionals := ProjectStruct.Conditionals;
  Struct.pDisplay := ProjectStruct.pDisplay;
  Struct.pDescription := ProjectStruct.pDescription;
  Struct.pClass := ProjectStruct.pClass;
  Struct.pWhole := ProjectStruct.pWhole;
  Struct.pMissing := ProjectStruct.pMissing;
  Struct.pLarge := ProjectStruct.pLarge;
  Struct.pRemove := ProjectStruct.pRemove;
  Struct.pCreate := ProjectStruct.pCreate;
  Struct.pDebug := ProjectStruct.pDebug;
  Struct.MultiLang := ProjectStruct.MultiLang;
  Struct.PassEnabled := ProjectStruct.PassEnabled;
  Struct.Password := ProjectStruct.Password;
  Struct.CodeSignPassword := ProjectStruct.CodeSignPassword;
  Struct.cFiles := ProjectStruct.cFiles;
  Struct.cRegistry := ProjectStruct.cRegistry;
  Struct.cFeatures := ProjectStruct.cFeatures;
  Struct.cHashes := ProjectStruct.cHashes;
end;

procedure SetScriptFile(ScriptFile: String);
begin
  Script := ScriptFile;
end;

procedure ClearProjectDialogs;
begin
  DialogFiles.Clear;
end;

procedure ClearProjectSupport;
begin
  SupportFiles.Clear;
end;

procedure ClearProjectMerge;
begin
  MergeFiles.Clear;
end;

procedure ClearProjectPatch;
begin
  PatchFiles.Clear;
end;

procedure ClearProjectInclude;
begin
  IncludeFiles.Clear;
end;

procedure AddProjectDialog(Dialog: String);
begin
  
  Dialog := StringReplace(Dialog, '/', PathDelim, [rfReplaceAll, rfIgnoreCase]);
  Dialog := StringReplace(Dialog, '\', PathDelim, [rfReplaceAll, rfIgnoreCase]);
  
  DialogFiles.Add(Dialog);
  DialogFiles.Add(Dialog + '.miaf'); 
end;

procedure AddProjectSupport(Support: String);
begin
  SupportFiles.Add(Support);
end;

procedure AddProjectMerge(Merge: String);
begin
  MergeFiles.Add(Merge);
end;

procedure AddProjectPatch(Patch: String);
begin
  PatchFiles.Add(Patch);
end;

procedure AddProjectInclude(Script: String);
begin
  IncludeFiles.Add(Script);
end;

procedure FinalizeProject(SaveFile: String; ScriptLines: Integer);
var
  s: String;
  i: Integer;
  PROJDIR: String;
  t, tXX: TextFile;
  tX: TextFile;
  BOM: Char;
begin
  PROJDIR := AssertDir(ExtractFilePath(SaveFile));
  DeleteFile(SaveFile);
  AssignFile(t, SaveFile,cp_utf8);
  ReWrite(t);
  FileCopyFile(PChar(Script), PChar(PROJDIR + ExtractFileNameOnly(Script) + '.miax'), 
    false);
  WriteLn(t, ExtractFileNameOnly(Script) + '.miax'); 
  for i := 1 to DialogFiles.Count do
  begin
    FileCopyFile(PChar(DialogFiles[i -1]),
      PChar(PROJDIR + ExtractFileName(DialogFiles[i -1])), false);
    if MyFileExists(DialogFiles[i -1] + '.baggage') then 
    begin
      FileMode :=0;
      AssignFile(tX, DialogFiles[i -1] + '.baggage',cp_utf8); 
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
      ReadLn(tX, s);
      CloseFile(tX);
      if ExtractFilePath(s) = '' then
        s := AssertDir(ExtractFilePath(DialogFiles[i -1])) + s;
      FileCopyFile(PChar(s), PChar(PROJDIR + ExtractFileName(s)), false);
      DeleteFile(DialogFiles[i -1] + '.baggage'); 
      AssignFile(tXX, DialogFiles[i -1] + '.baggage',cp_utf8); 
      ReWrite(tXX);
      WriteLn(tXX, ExtractFileName(s));
      SupportFiles.Add(s);
      CloseFile(tXX);
    end;
    WriteLn(t, ExtractFileName(DialogFiles[i -1]));
  end;
  WriteLn(t, '$');
  for i := 1 to SupportFiles.Count do
  begin
    FileCopyFile(PChar(SupportFiles[i -1]),
      PChar(PROJDIR + ExtractFileName(SupportFiles[i -1])), false);
    WriteLn(t, ExtractFileName(SupportFiles[i -1]));
  end;
  WriteLn(t, '$');
  for i := 1 to ScriptLines do
    WriteLn(t); 
  WriteLn(t, '$');
  WriteLn(t, '$'); 
  WriteLn(t, Struct.BuildLayout);
  WriteLn(t, Struct.CompressProfile);
  WriteLn(t, Struct.BuildInFolder);
  WriteLn(t, Struct.BuildCustomFolder);
  WriteLn(t, Struct.Manufacturer);
  WriteLn(t, Struct.Name);
  WriteLn(t, Struct.Code);
  WriteLn(t, Struct.UpgradeCode);
  WriteLn(t, Struct.Version);
  WriteLn(t, Struct.Language);
  WriteLn(t, Struct.Title);
  WriteLn(t, Struct.Subject);
  WriteLn(t, Struct.Author);
  WriteLn(t, Struct.Comments);
  WriteLn(t, Struct.Revision);
  WriteLn(t, Struct.arPublisher);
  WriteLn(t, Struct.arContact);
  WriteLn(t, Struct.arHelp);
  WriteLn(t, Struct.arUpdates);
  WriteLn(t, Struct.arComments);
  WriteLn(t, Struct.BuildDebug);
  WriteLn(t, Struct.OutputFile);
  WriteLn(t, Struct.AutoIncrement);
  WriteLn(t, Struct.aSign);
  WriteLn(t, Struct.aCertificate);
  WriteLn(t, Struct.aKey);
  WriteLn(t, Struct.aTimeStamp);
  WriteLn(t, Struct.aInfo);
  WriteLn(t, Struct.Conditionals);
  WriteLn(t, Struct.pDisplay);
  WriteLn(t, Struct.pDescription);
  WriteLn(t, Struct.pClass);
  WriteLn(t, Struct.pWhole);
  WriteLn(t, Struct.pMissing);
  WriteLn(t, Struct.pLarge);
  WriteLn(t, Struct.pRemove);
  WriteLn(t, Struct.pCreate);
  WriteLn(t, Struct.pDebug);
  WriteLn(t, Struct.MultiLang);
  WriteLn(t, Struct.PassEnabled);
  WriteLn(t, Struct.Password);
  for i := 1 to IncludeFiles.Count do
    WriteLn(t, IncludeFiles[i -1]);
  WriteLn(t, '$');
  WriteLn(t, Struct.AutoHash);
  WriteLn(t, Struct.CodeSignPassword);
  WriteLn(t, Struct.cFiles);
  WriteLn(t, Struct.cRegistry);
  WriteLn(t, Struct.cFeatures);
  WriteLn(t, Struct.cHashes);
  CloseFile(t);
  DialogFiles.Free;
  SupportFiles.Free;
  MergeFiles.Free;
  PatchFiles.Free;
  IncludeFiles.Free;
end;

procedure InitializeScript;
begin
  Types := TStringList.Create;
  References := TStringList.Create;
  Dereferences := TStringList.Create;
end;

procedure EmitAddCommand(Command: String; Parameters: String);
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  s := MyCreateGUID;
  Types.Add(Command);
  References.Add(s);
  if Parameters <> '' then
  begin
    Dereferences.Add(s);
    l := TStringList.Create;
    l.CommaText := Parameters;
    for i := 1 to l.Count do
      Dereferences.Add(
        {$IFDEF SWAPQUOTES}
        
        StringReplace({$ENDIF}
        
          l[i -1]
          {$IFDEF SWAPQUOTES}
          , '`', '"', [rfReplaceAll, rfIgnoreCase]){$ENDIF});
    l.Free;
  end;
end;

procedure FinalizeScript(SaveFile: String);
var
  i: Integer;
  t: TextFile;
begin
  DeleteFile(SaveFile);
  AssignFile(t, SaveFile,cp_utf8);
  ReWrite(t);
  for i := 1 to Types.Count do
    WriteLn(t, Types[i -1]);
  WriteLn(t, '$');
  for i := 1 to References.Count do
    WriteLn(t, References[i -1]);
  WriteLn(t, '$');
  for i := 1 to Dereferences.Count do
    WriteLn(t, Dereferences[i -1]);
  WriteLn(t, '$');
  for i := 1 to Types.Count do
    WriteLn(t);
  WriteLn(t, '$');
  for i := 1 to Types.Count do
    WriteLn(t);
  WriteLn(t, '$');
  CloseFile(t);
  Types.Free;
  References.Free;
  Dereferences.Free;
end;

function GetTotalLines: Integer;
begin
  Result := Types.Count;
end;

{$IFNDEF SCRIPTING}
function InjectIncludesFromFile(FileName: String; Position: Integer): Boolean;
var
  t: TextFile;
  i: Integer;
  s: String;
  BOM: Char;
begin
  Result := false; 
  for i := 1 to thIncludeFiles.Count do
    if CompareText(ExtractFileNameOnly(thIncludeFiles[i -1]), FileName) = 0 then
    begin
      FileName := thIncludeFiles[i -1];
      Break;
    end;
  
  if not MyFileExists(FileName) then
    raise Exception.Create('Include File "' + FileName + '" does not exist');
  AssignFile(t, FileName,cp_utf8);
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
  s := '';
  i := 0;
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then
    begin
      
      if IncludeDepthInteger > 1 then
      begin
        IncludeDepthDirect.Insert(Position, IncludeDepthStack[IncludeDepthStack.Count -1] + '*' + IntToStr(IncludeDepthInteger));
        PullMapDirect.Insert(Position +i, FileName + '*' + IntToStr(i));
      end
      else
      begin
        IncludeDepthDirect.Insert(0, IncludeDepthStack[IncludeDepthStack.Count -1] + '*' + IntToStr(IncludeDepthInteger));
        PullMapDirect.Insert(0 +i, FileName + '*' + IntToStr(i));
      end;
      thScriptTypes.Insert(Position +i, s);
      i := i +1;
      Result := True;
    end;
  end;
  if Result then
  begin
    thScriptTypes.Delete(Position +i);
    if IncludeDepthInteger > 1 then
    begin
      IncludeDepthDirect.Delete(Position +i);
      PullMapDirect.Delete(Position +i);
    end;
  end;
  s := '';
  i := 0;
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then
    begin
      thScriptReferences.Insert(Position +i, s);
      i := i +1;
    end;
  end;
  if Result then
    thScriptReferences.Delete(Position +i);
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s = '$' then Break
      else
      begin
        if s = '$DOLLAR$' then
          thGlobal.Add('$')
        else
          thGlobal.Add(s);
      end;
  end;
  s := '';
  i := 0;
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then
    begin
      thScriptComments.Insert(Position +i, s);
      i := i +1;
    end;
  end;
  if Result then
    thScriptComments.Delete(Position +i);
  s := '';
  i := 0;
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then
    begin
      thScriptFetches.Insert(Position +i, s);
      i := i +1;
    end;
  end;
  if Result then
    thScriptFetches.Delete(Position +i);
  CloseFile(t);
end;

function InitializeBuildContext(Project, Conditionals: String;
  LanguageEx: String = ''; PasswordEx: String = ''; OverBuildMode: Integer = -1;
  CompressGrade: Integer = -1; SkipSign: Boolean = false): String;
var
  b: Boolean;
  t: TextFile;
  i, j: Integer;
  ScriptFile: String;
  s, sX: String;
  l: TList;
  BOM: Char;
  Wide1, Wide2: String;
begin
  Result := '';
  
  thScriptTypes := THashedStringList.Create;
  thScriptReferences := THashedStringList.Create;
  thScriptComments := THashedStringList.Create;
  thScriptFetches := THashedStringList.Create;
  thProhibitedScriptFetches := THashedStringList.Create;
  thDialogFiles := THashedStringList.Create;
  thSupportFiles := THashedStringList.Create;
  thMergeFiles := THashedStringList.Create;
  thPatchFiles := THashedStringList.Create;
  thIncludeFiles := THashedStringList.Create;
  IncludeDepthStack := TStringList.Create;
  thGlobal := THashedStringList.Create;
  thGlobalLists := TList.Create;
  thGlobalLists.Add(thGlobal);
  
  thCurrentProjectName := Project;
  FileMode := 0;
  AssignFile(t, thCurrentProjectName,cp_utf8);
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
  ReadLn(t, ScriptFile);
  ScriptFile := AbsolutizePath(ScriptFile, ExtractFilePath(Project));
  ReadLn(t, s);
  while s <> '$' do
  begin
    thDialogFiles.Add(s);
    ReadLn(t, s);
  end;
  ReadLn(t, s);
  while s <> '$' do
  begin
    thSupportFiles.Add(s);
    ReadLn(t, s);
  end;
  ReadLn(t, s);
  while s <> '$' do
    
    ReadLn(t, s);
  ReadLn(t, s);
  while s <> '$' do
    
    ReadLn(t, s);
  
  ReadLn(t, s);
  thProjectStruct.BuildLayout := StrToInt(s);
  if OverBuildMode <> -1 then
    thProjectStruct.BuildLayout := OverBuildMode;
  ReadLn(t, thProjectStruct.CompressProfile);
  if CompressGrade <> -1 then
    StrLCopy(thProjectStruct.CompressProfile, PChar(IntToStr(CompressGrade)), High(thProjectStruct.CompressProfile));
  ReadLn(t, s);
  thProjectStruct.BuildInFolder:= StrToBool(s);
  ReadLn(t, thProjectStruct.BuildCustomFolder);
  ReadLn(t, thProjectStruct.Manufacturer);
  ReadLn(t, thProjectStruct.Name);
  ReadLn(t, thProjectStruct.Code);
  ReadLn(t, thProjectStruct.UpgradeCode);
  ReadLn(t, thProjectStruct.Version);
  ReadLn(t, thProjectStruct.Language);
  ReadLn(t, thProjectStruct.Title);
  ReadLn(t, thProjectStruct.Subject);
  ReadLn(t, thProjectStruct.Author);
  ReadLn(t, thProjectStruct.Comments);
  ReadLn(t, thProjectStruct.Revision);
  ReadLn(t, thProjectStruct.arPublisher);
  ReadLn(t, thProjectStruct.arContact);
  ReadLn(t, thProjectStruct.arHelp);
  ReadLn(t, thProjectStruct.arUpdates);
  ReadLn(t, thProjectStruct.arComments);
  ReadLn(t, s);
  thProjectStruct.BuildDebug := StrToBool(s);
  ReadLn(t, thProjectStruct.OutputFile);
  ReadLn(t, s);
  thProjectStruct.AutoIncrement := StrToBool(s);
  
  if not EOF(t) then
  begin
    ReadLn(t, s);
    thProjectStruct.aSign := StrToBool(s);
    ReadLn(t, thProjectStruct.aCertificate);
    ReadLn(t, thProjectStruct.aKey);
    ReadLn(t, thProjectStruct.aTimeStamp);
    ReadLn(t, thProjectStruct.aInfo);
  end
  else
  
  begin
    thProjectStruct.aSign := false;
    thProjectStruct.aCertificate := '';
    thProjectStruct.aKey := '';
    thProjectStruct.aTimeStamp := '';
    thProjectStruct.aInfo := '';
  end;
  if SkipSign then
  begin
    thProjectStruct.aSign := false;
    thProjectStruct.aCertificate := '';
    thProjectStruct.aKey := '';
    thProjectStruct.aTimeStamp := '';
    thProjectStruct.aInfo := '';
  end;
  if not EOF(t) then
    
    ReadLn(t, thProjectStruct.Conditionals)
  else
    
    thProjectStruct.Conditionals := '';
  if not EOF(t) then
  begin
    ReadLn(t, thProjectStruct.pDisplay);
    ReadLn(t, thProjectStruct.pDescription);
    ReadLn(t, thProjectStruct.pClass);
    ReadLn(t, s);
    thProjectStruct.pWhole := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.pMissing := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.pLarge := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.pRemove := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.pCreate := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.pDebug := StrToBool(s);
  end
  else
  begin
    thProjectStruct.pDisplay := '';
    thProjectStruct.pDescription := '';
    thProjectStruct.pClass := 'Service Pack'; 
    thProjectStruct.pWhole := false;
    thProjectStruct.pLarge := false;
    thProjectStruct.pMissing := false;
    thProjectStruct.pRemove := True;
    thProjectStruct.pCreate := True;
    thProjectStruct.pDebug := false;
  end;
  
  if not EOF(t) then
  begin
    ReadLn(t, s);
    thProjectStruct.MultiLang := StrToBool(s);
  end
  else
    thProjectStruct.MultiLang := false;
  if not EOF(t) then
  begin
    ReadLn(t, s);
    thProjectStruct.PassEnabled := StrToBool(s);
    ReadLn(t, thProjectStruct.Password);
  end
  else
  begin
    thProjectStruct.PassEnabled := false;
    thProjectStruct.Password := '';
  end;
  if not EOF(t) then
  begin
    ReadLn(t, s);
    while s <> '$' do
    begin
      s := AbsolutizePath(s, ExtractFilePath(Project));
      
      if MyFileExists(AssertDir(ExtractFilePath(Project)) + s) then
        s := AssertDir(ExtractFilePath(Project)) + s
      else
      
        if MyFileExists(EXEDIR + 'runtimes\' + s) then 
          s := EXEDIR + 'runtimes\' + s; 
      thIncludeFiles.Add(s);
      ReadLn(t, s);
    end;
  end
  else
    thIncludeFiles.Clear;
  if not EOF(t) then
  begin
    ReadLn(t, s);
    thProjectStruct.AutoHash := StrToBool(s);
  end
  else
    thProjectStruct.AutoHash := false;
  if not EOF(t) then
    ReadLn(t, thProjectStruct.CodeSignPassword)
  else
    thProjectStruct.CodeSignPassword := '';
  if not EOF(t) then
  begin
    ReadLn(t, s);
    thProjectStruct.cFiles := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.cRegistry := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.cFeatures := StrToBool(s);
    ReadLn(t, s);
    thProjectStruct.cHashes := StrToBool(s);
  end
  else
  begin
    thProjectStruct.cFiles := false;
    thProjectStruct.cRegistry := false;
    thProjectStruct.cFeatures := True;
    thProjectStruct.cHashes := false;
  end;
  CloseFile(t);
  
  if ExtractFilePath(ScriptFile) = '' then
    ScriptFile := AssertDir(ExtractFilePath(thCurrentProjectName)) + ScriptFile;
  s := '';
  AssignFile(t, ScriptFile,cp_utf8);
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
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then thScriptTypes.Add(s);
  end;
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then thScriptReferences.Add(s);
  end;
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s = '$' then Break
      else
      begin
        if s = '$DOLLAR$' then
          thGlobal.Add('$')
        else
          thGlobal.Add(s);
      end;
  end;
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then thScriptComments.Add(s);
  end;
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then thScriptFetches.Add(s);
  end;
  CloseFile(t);
  
  PullMapDirect.Clear;
  IncludeDepthDirect.Clear;
  IncludeDepthInteger := 0;
  IncludeDepthStack.Clear;
  IncludeDepthStack.Add(IntToStr(IncludeDepthInteger));
  j := 0;
  repeat
    j := j +1; 
    for i := thScriptTypes.Count downto 1 do
    begin
      
      if thScriptTypes[i -1] = 'Include Script' then 
      begin
        b := thScriptComments[i -1] <> 'C';
        if b then
        begin
          WidenColonDelimParam(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +1], Wide1, Wide2);
          IncludeDepthInteger := IncludeDepthInteger +j;
          IncludeDepthStack.Add(Wide2);
          b := InjectIncludesFromFile(Wide1, i -1);
          IncludeDepthInteger := IncludeDepthInteger -j;
          IncludeDepthStack.Delete(IncludeDepthStack.Count -1);
        end;
        if not b then 
        begin
          thScriptTypes[i -1] := 'Ignore'; 
          PullMapDirect.Insert(0, ScriptFile + '*' + IntToStr(i -1)); 
          IncludeDepthDirect.Insert(0, IncludeDepthStack[IncludeDepthStack.Count -1] + '*' + IntToStr(IncludeDepthInteger));
        end;
      end
      else
      if j = 1 then
      begin 
        PullMapDirect.Insert(0, ScriptFile + '*' + IntToStr(i -1));
        IncludeDepthDirect.Insert(0, IncludeDepthStack[IncludeDepthStack.Count -1] + '*' + IntToStr(IncludeDepthInteger));
      end;
    end;
  until thScriptTypes.IndexOf('Include Script') = -1; 
  
  if Conditionals <> '' then
  begin
    if thProjectStruct.Conditionals = '' then
      StrCopy(thProjectStruct.Conditionals, PChar(Conditionals))
      
    else
      StrCopy(thProjectStruct.Conditionals, PChar(Conditionals + ',' +
        thProjectStruct.Conditionals));
      
  end;
  if LanguageEx <> '' then
    StrCopy(thProjectStruct.Language, PChar(LanguageEx));
    
  if PasswordEx <> '' then
  begin
    thProjectStruct.PassEnabled := True;
    StrCopy(thProjectStruct.Password, PChar(PasswordEx));
    
  end;
  sX := thProjectStruct.Conditionals;
  SetMakeContext(thGlobalLists, thScriptTypes, thScriptReferences, thScriptComments,
    sX, l, s, thProjectStruct.BuildLayout,
    thProjectStruct.Language, thProjectStruct.Name,
    thProjectStruct.aSign);
  StrCopy(thProjectStruct.Conditionals, PChar(sX));
  
  thGlobalLists.Free;
  thGlobalLists := l;
  thGlobal.Free;
  thGlobal := THashedStringList(l[0]);
end;

procedure FinalizeBuildContext;
begin
  SetEditContext(thGlobalLists, thScriptTypes);
  thScriptTypes.Free;
  thScriptReferences.Free;
  thScriptComments.Free;
  thScriptFetches.Free;
  thProhibitedScriptFetches.Free;
  thDialogFiles.Free;
  thSupportFiles.Free;
  thMergeFiles.Free;
  thPatchFiles.Free;
  thIncludeFiles.Free;
  IncludeDepthStack.Free;
   
end;
{$ENDIF}

end.

