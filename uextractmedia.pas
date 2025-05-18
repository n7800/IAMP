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
unit uExtractMedia;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf,  LMessages,
{$ENDIF}
{$IFNDEF NOGUI}Forms,{$ENDIF}
{$IFDEF WINDOWS}
  ShlObj, Windows,
{$ELSE}
  BaseUnix,
{$ENDIF}
  mUtils, SysUtils, 
  uSevenZipAPI, Classes, FileUtil;

type
  TExtractMedia = class(TThread)
  private
  protected
    procedure Execute; override;
    procedure SetFinished;
  end;

function CopyFolderDecrypt(Source, Target: String): Boolean;

function MoveFolder(Source, Target: String; Move, Recurse: Boolean): Boolean;

var
  tem: TExtractMedia;
  
  thxWindow: THandle;
  thxLocal, thxFolder: String;
  thxOnCD: Boolean;
  thxPassword: String;
  thxProgressTextHeader: String;
  
  thxFailedMoveOptimization: Boolean;
  
  thxFreak7Zip: Boolean;
  thxExternalResult: Boolean;
  thxFinished: Boolean;
  
implementation

uses
  mscriptexec, uDlgAPI;

var
  thxProgress: Integer;
  thxResult: Boolean;
  thxProgressText: String;

resourcestring
  STheArchiveCannotBeOpenedUnsuppor = 'The archive cannot be opened: unsupported archive or incorrect password';

function ExtractProgress(lpCurrentFileName: PCHAR; uiCompleted, uiTotal: Int64): Integer; stdcall;
var
  i: Integer;
  bY: Boolean;
begin
  
    i := ((uiCompleted * 100) div uiTotal) +1;
    if i >= 100 then thxProgress := 100
      else thxProgress := i;
    thxProgressText := ExtractFileName(lpCurrentFileName) + ', ' + IntToStr(thxProgress) + msg20;
    DelegateBindProgress(thxProgressTextHeader + #13 + thxProgressText, thxProgress, 100, 0);
    {$IFDEF USEVARMANAGER}
    bY := VarManager['MYAH_thCancelled'] = 'TRUE';
    {$ELSE}
    bY := MyStrToBool(GETVARIABLE('MYAH_thCancelled'));
    {$ENDIF}
    if bY then
    begin
      Result := 0;
    end
    else
    begin
      Result := 1;
    end;

  {$IFNDEF LINUX}
  {$IFNDEF NOGUI}
  SendMessage(thxWindow, 0, 0, 0); 
  {$ENDIF}
  {$ENDIF}
end;

function CopyFolderDecrypt(Source, Target: String): Boolean;
var
  i: Integer;
  b: Boolean;
  l: TStringList;
  s: String;
begin
  Result := false;
  Source := AssertDir(Source);
  Target := AssertDir(Target);
  l := MyFindAllFiles(Source, '*', True);
  for i := 1 to l.Count do
  begin
    s := ExtractFilePath(l[i -1]);
    Delete(s, 1, Length(Source));
    if s <> '' then
      s := AssertDir(s);
    ForceDirectories(Target + s);
    b := FileCopyFile(PChar(l[i -1]), PChar(Target + s + ExtractFileName(l[i -1])), false);
    if not b then
    begin
      l.Free;
      Exit;
    end;
    {$IFNDEF WINDOWS}
    LazShimSetExecutable(Target + s + ExtractFileName(l[i -1]), l[i -1]);
    {$ENDIF}
    {$IFDEF DARWIN}
    if AnsiCompareText(RuntimeSubstituteCompilerVariables('#MYAH_SIGNED#'), 'TRUE') = 0 then
      if FpAccess(Target + s + ExtractFileName(l[i -1]), X_OK) = 0 then
        EncryptFileEx(Target + s + ExtractFileName(l[i -1]), '$');
    {$ENDIF}
  end;
  l.Free;
  Result := True;
end;

function MoveFolder(Source, Target: String; Move, Recurse: Boolean): Boolean;
var
  i: Integer;
  b: Boolean;
  l: TStringList;
  s: String;
begin
  Result := false;
  Source := AssertDir(Source);
  Target := AssertDir(Target);
  l := MyFindAllFiles(Source, '*', True);
  for i := 1 to l.Count do
  begin
    s := ExtractFilePath(l[i -1]);
    Delete(s, 1, Length(Source));
    if s <> '' then
      s := AssertDir(s);
    ForceDirectories(Target + s);
    if Move then
    begin
      {$IFDEF WINDOWS}
      SetFileAttributes(PChar(Target + s + ExtractFileName(l[i -1])), FILE_ATTRIBUTE_NORMAL);
      {$ENDIF}
      DeleteFile(PChar(Target + s + ExtractFileName(l[i -1])));
      b := MoveFile(PChar(l[i -1]), PChar(Target + s + ExtractFileName(l[i -1])));
    end
    else
    begin
      b := FileCopyFile(PChar(l[i -1]), PChar(Target + s + ExtractFileName(l[i -1])), false);
      
      {$IFNDEF WINDOWS}
      LazShimSetExecutable(Target + s + ExtractFileName(l[i -1]), l[i -1]);
      {$ENDIF}
    end;
    if not b then
    begin
      l.Free;
      Exit;
    end;
  end;
  l.Free;
  if Move then
  begin
    WipeFolder(Source, True);
    WipeFolder(Source, True);
    WipeFolder(Source, True);
    RemoveDir(Source);
  end;
  Result := True;
end;

procedure TExtractMedia.SetFinished;
begin
  
  if not thxOnCD then 
    DeleteFile(thxLocal);
  thxFinished := True;
  thxExternalResult := thxResult;
  
end;

procedure TExtractMedia.Execute;
var
  i, j: Integer;
  l: TStringList;
  s, sX, sY, sZ: String;
  sXW, sYW: String;
  p: PChar;
  TargetDir, TargetFile, SourceFile: String;
  szError: String;
  pws: String;
  FileNameOnlyW, SourceFileW, TargetFileW: String;
  UnicodeB: Boolean;
begin
  
  {$IFDEF WINDOWS}
  GetMem(p, (MAX_PATH+1)*8);
  SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT, p);
  s := AssertDir(p) +  MyCreateGUID + PathDelim;
  FreeMem(p);
  {$ELSE}
  s := ExpandFileName('~/'  + MyCreateGUID);
  {$ENDIF}
  
  ForceDirectories(s); 
  ForceDirectories(thxFolder);
  thxResult := ExtractArchiveContents(thxLocal, thxPassword,
    s, True, True, szError, nil, ExtractProgress, nil, nil, nil);
  
  if AnsiCompareText(ExtractFileNameOnly(thxLocal), 'data') = 0 then
    sZ := 'data' + PathDelim
  else
    sZ := '';
  thxFreak7Zip := szError = STheArchiveCannotBeOpenedUnsuppor;
  if thxResult then
  begin
    
    if GetVariable('COPYWEBLOCK') <> '' then
      FileCopyFile(thxLocal,
        AssertDir(GetVariable('COPYWEBLOCK')) + ExtractFileName(thxLocal), false);
    
    thxResult := false;
    UnicodeB := false;
    
    l := TStringList.Create;
    try
      
      for i := 1 to NewSourceListSource.Count do
        if ((i -1) mod 3) = 0 then
          if CompareText(NewSourceListSource[(i -1) +0], ExtractFileNameOnly(thxLocal)) = 0 then
          begin
            
            TargetDir := AssertDir(AssertDir(thxFolder) + 
              NewSourceListSource[(i -1) +2]);
            ForceDirectories(TargetDir);
            TargetFile := TargetDir + ExtractFileName(NewSourceListSource[(i -1) +1]);
            SourceFile := AssertDir(AssertDir(s) + ExtractFileNameOnly(thxLocal)) + sZ +
              NewSourceListSource[(i -1) +1];
            if not UnicodeB then
            begin
              
              SetFileAttributes(PChar(TargetFile), FILE_ATTRIBUTE_NORMAL);
              DeleteFile(TargetFile);
              if thxFailedMoveOptimization then
              begin
                if not FileCopyFile(PChar(SourceFile), PChar(TargetFile), false) then
                  UnicodeB := True;
              end
              else
              begin
                if not MyFileExists(SourceFile) then
                begin
                  
                  if l.IndexOf({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}SourceFile{$IFNDEF LINUX}){$ENDIF}) <> -1 then
                  begin
                    
                    FileCopyFile(PChar(l[l.IndexOf({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}SourceFile{$IFNDEF LINUX}){$ENDIF}) +1]),
                      PChar(SourceFile), false);
                  end;
                end;
                
                if not MoveFile(PChar(SourceFile), PChar(TargetFile)) then
                begin
                  UnicodeB := True;
                  
                end
                else
                  
                  begin
                    
                    l.Add({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}SourceFile{$IFNDEF LINUX}){$ENDIF});
                    l.Add({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}TargetFile{$IFNDEF LINUX}){$ENDIF});
                  end;
              end;
            end;
            if UnicodeB then
            begin
              
              FileNameOnlyW := ExtractFileName(NewSourceListSource[(i -1) +1]);
              SourceFileW := AssertDir(ExtractFilePath(SourceFile)) + FileNameOnlyW;
              TargetFileW := AssertDir(ExtractFilePath(TargetFile)) + FileNameOnlyW;
              
              {$IFDEF WINDOWS}
              SetFileAttributes(PChar(TargetFileW), FILE_ATTRIBUTE_NORMAL); 
              {$ENDIF}
              DeleteFile(PChar(TargetFileW));
              if thxFailedMoveOptimization then
              begin
                if not FileCopyFile(PChar(SourceFileW), PChar(TargetFileW), false) then
                begin
                  
                  sX := SourceFileW;
                  sY := SourceFileW;
                  sXW := sX;
                  sYW := sY;
                  
                  if not FileCopyFile(PChar(sXW), PChar(TargetFileW), false) then
                  begin
                    SourceFileW := sY;
                    if not FileCopyFile(PChar(sYW), PChar(TargetFileW), false) then
                    begin
                      Synchronize(SetFinished);
                      Exit;
                    end;
                  end;
                end;
              end
              else
              begin
                if not MyFileExists(SourceFileW) then
                begin
                  
                  if l.IndexOf({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}SourceFile{$IFNDEF LINUX}){$ENDIF}) <> -1 then
                  begin
                    
                    FileCopyFile(PChar(
                      AssertDir(ExtractFilePath(l[l.IndexOf({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}SourceFile{$IFNDEF LINUX}){$ENDIF}) +1]))
                        + FileNameOnlyW),
                      PChar(SourceFileW), false);
                  end;
                end;
                if not MoveFile(PChar(SourceFileW), PChar(TargetFileW)) then
                begin
                  
                  thxFailedMoveOptimization := True;
                  Execute;
                  Exit;
                end
                else
                  
                  begin
                    
                    l.Add({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}SourceFile{$IFNDEF LINUX}){$ENDIF});
                    l.Add({$IFNDEF LINUX}AnsiLowerCase({$ENDIF}TargetFile{$IFNDEF LINUX}){$ENDIF});
                  end;
              end;
            end;
          end;
    finally
      l.Free;
    end;
    if not MoveFolder(s + ExtractFileNameOnly(thxLocal),
      thxFolder + ExtractFileNameOnly(thxLocal), True, True) then
    begin
      Synchronize(SetFinished);
      Exit;
    end;
    
    l := FindAllDirs(AssertDir(s) + ExtractFileNameOnly(thxLocal), false);
    for i := 1 to l.Count do
      
      if AnsiPos('FileBag', ExtractFileName(l[i -1])) = 1 then
      begin
        if not MoveFolder(l[i -1], AssertDir(AssertDir(thxFolder)
          + ExtractFileNameOnly(thxLocal)) + ExtractFileNameOnly(l[i -1]), True, True) then
        begin
          Synchronize(SetFinished);
          Exit;
        end;
        
      end;
      
    l.Free;
    
    thxResult := True;
  end;
  DeleteDirectory(s, false);
  RemoveDirectory(PChar(s));
  Synchronize(SetFinished);
  {$IFNDEF NOGUI}
  {$IFNDEF LINUX}
  SendMessage(thxWindow, 0, 0, 0); 
  SendMessage(Application.Handle, 0, 0, 0); 
  {$ENDIF}
  {$ENDIF}
end;

end.
