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

unit uScanner;

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
  LazFileUtils, Classes, Registry, mUtils, SysUtils, MTProcs;

const
  SizeLimit = 50000;

type
  TScanCallback = function(FileName: String): Boolean of Object;
  TDiffCallback = function(SmartPosition: Integer): Boolean of Object;

  PScanRecord = ^TScanRecord;
  TScanRecord = record
  public
    FileName: String;
    FileTime: LongInt;
    FileSize: Int64;
    FileAttr: LongInt;
    FileVer: Int64;
  end;

procedure AddToExcludeFromScan(FileSpec: String);

function IsExcluded(Item: String): Boolean;

procedure ClearExcludeFromScan;

function GetAllHardDrives: TStringList;

function CreateScanObject(Name: String): TList;

function FindScanObject(Name: String): TList;

function SizeScanObject(Name: String): Int64;

procedure FreeScanObject(Name: String);

procedure ClearScanObjects;

function RunScan(Name, Folder, Mask: String; Recursive, IncludeVersion: Boolean;
  CallBack: TScanCallBack; ActualRoot, RelativeRoot: String): Boolean;

procedure AddFileToScanObject(Name, FileName: String; IncludeVersion: Boolean;
  FileRec: TSearchRec; ActualRoot, RelativeRoot: String);

procedure CopyFileInScanObject(Source, Target: String; Index: Int64);

function FindFileInScanObject(Name, FileName: String): Int64;
function FindFileInScanObjectEx(ScanObject: TList; FileName: String): PScanRecord;
function FindFileInScanObjectEy(ScanObject: TList; FileName: String; var FoundAt: Int64): PScanRecord;

procedure PokeScanObject(ScanObject: String; SmartPosition: Int64;
  var Data: TScanRecord);
procedure PokeScanObjectEx(ScanObject: TList; SmartPosition: Int64;
  var FileName: String);

function ScanMyFileExists(Path, Name: String): Boolean;

procedure SaveScanObject(Name, FileName: String);

procedure LoadScanObject(Name, FileName: String);

procedure DiffScanObjects(Source, Target, Added, Removed, Modified: String;
  CallBack: TDiffCallBack);

function DeleteItemInScanObject(Name: String; SmartPosition: Int64): Boolean;
function DeleteItemInScanObjectEx(ScanObject: TList; SmartPosition: Int64): Boolean;

function CloneObject(Source, Target: String): TList;

implementation

uses
  uScanning; 

var
  ScanObjects: TStringList;
  ExcludeFromScan: TStringList;
  soHandle: TList;

{$IFNDEF DODEBUG}
procedure DoDebug(OutText: String);
begin
end;
{$ELSE}
procedure DoDebug(OutText: String);
var
  t: TextFile;
begin
  OutputDebugString(PChar(OutText));
  AssignFile(t, DataDir + 'out.txt');
  if MyFileExists(DataDir + 'out.txt') then
    Append(t)
  else
    ReWrite(t);
  WriteLn(t, OutText);
  CloseFile(t);
end;
{$ENDIF}

function IsExcluded(Item: String): Boolean;
var
  i: Integer;
  s: String;
begin
  Result := false;
  {$IFDEF LINUX}
  s := LowerCase(Item);
  {$ENDIF}
  for i := 1 to ExcludeFromScan.Count do
   begin
    if AnsiPos('*', ExcludeFromScan[i-1]) = 1 Then
     Begin
      
      If AnsiPos(Copy(ExcludeFromScan[i -1], 2, Length(ExcludeFromScan[i -1])), s) > 0 Then
       Begin
        Result := True;
        Break;
       End;
     End
    Else
     if AnsiPos(ExcludeFromScan[i -1], s) = 1 then
     begin
       Result := True;
       Break;
     end;
   end;
end;

procedure AddToExcludeFromScan(FileSpec: String);
begin
  ExcludeFromScan.Add({$IFDEF LINUX}LowerCase({$ENDIF}FileSpec{$IFDEF LINUX}){$ENDIF});
end;

procedure ClearExcludeFromScan;
begin
  ExcludeFromScan.Clear;
end;

function ScanMyFileExists(Path, Name: String): Boolean;
begin
  Result := MyFileExists(AssertDir(Path) + Name);
end;

function CreateScanObject(Name: String): TList;
begin
  if ScanObjects.IndexOf(Name) <> -1 then
    raise Exception.Create('ScanAPI:: CreateScanObject: Named scan object already exists!');
  ScanObjects.Add(Name);
  ScanObjects.Objects[ScanObjects.Count -1] := TList.Create;
  Result := TList(ScanObjects.Objects[ScanObjects.Count -1]);
  Result.Add(TList.Create);
end;

function FindScanObject(Name: String): TList;
var
  i: Integer;
begin
  Result := nil;
  i := ScanObjects.IndexOf(Name);
  if i = -1 then Exit;
  Result := TList(ScanObjects.Objects[i]);
end;

function SizeScanObject(Name: String): Int64;
var
  l, lX: TList;
  i: Integer;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: SizeScanObject: Named scan object not found!');
  Result := 0;
  for i := 1 to l.Count do
  begin
    lX := l[i -1];
    Result := Result + lX.Count;
  end;
end;

procedure ClearScanObjects;
var
  l: TList;
  i: Integer;
begin
  for i := ScanObjects.Count downto 1 do
    FreeScanObject(ScanObjects[i -1]);
end;

procedure FreeScanObject(Name: String);
var
  l, lX: TList;
  i, j: Integer;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: FreeScanObject: Named scan object not found!');
  for i := 1 to l.Count do
  begin
    lX := l[i -1];
    for j := 1 to lX.Count do
      Dispose(lX[j -1]);
    lX.Free;
  end;
  l.Free;
  i := ScanObjects.IndexOf(Name);
  ScanObjects.Delete(i);
end;

function RunScan(Name, Folder, Mask: String; Recursive, IncludeVersion: Boolean;
  CallBack: TScanCallBack; ActualRoot, RelativeRoot: String): Boolean;
var
  r: TSearchRec;
  s: String;
  i: Cardinal;
begin
  i := FindFirstUTF8(PChar(AssertDir(Folder) + Mask), faAnyFile  or faSymLink, r);
  if i <> 0 then
  begin
    
    Result := True;
    Exit;
  end;
  while i = 0 do
  begin
    s := r.Name;
    
    if (((s <> '.') and (s <> '..')) and (s <> '')) 
      
      then
    begin
      
      if (((r.Attr and faDirectory) <> 0) and Recursive)
        and ((r.Attr and faSymLink) = 0) then 
        
      begin
        
        if not IsExcluded(Folder + s) then
        begin
          Result := RunScan(Name, AssertDir(Folder) + s + PathDelim,
            Mask, True, IncludeVersion, CallBack, ActualRoot, RelativeRoot);
          if not Result then
          begin
            FindCloseUTF8(r);
            Exit;
          end;
        end;
      end;
      
      if not IsExcluded(Folder + s) then
      begin
        
        if DirectoryExists(AssertDir(Folder) + s) then
          AddFileToScanObject(Name, AssertDir(Folder) + s + PathDelim, IncludeVersion,
            r, ActualRoot, RelativeRoot)
        else
          AddFileToScanObject(Name, AssertDir(Folder) + s, IncludeVersion,
            r, ActualRoot, RelativeRoot);
      end;
      if not CallBack(Folder + s) then
      begin
        Result := false;
        FindCloseUTF8(r);
        Exit;
      end;
    end;
    
    i := FindNextUTF8(r);
  end;
  Result := True;
  FindCloseUTF8(r);
end;

procedure AddFileToScanObject(Name, FileName: String; IncludeVersion: Boolean;
  FileRec: TSearchRec; ActualRoot, RelativeRoot: String);
var
  l, lX: TList;
  o: PScanRecord;
begin
  
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: AddFileToScanObject: Named scan object not found!');
  if TList(l[l.Count -1]).Count = SizeLimit then
  begin
    lX := TList.Create;
    l.Add(lX);
    l := lX;
  end;
  
  New(o);
  
  if (ActualRoot <> '') and (RelativeRoot <> '') then
  begin
    Delete(FileName, 1, Length(AssertDir(ActualRoot)));
    FileName := AssertDir(RelativeRoot) + FileName;
  end;
  
  o^.FileName := FileName;
  o^.FileAttr := FileRec.Attr;
  o^.FileTime := FileRec.Time;
  o^.FileSize := FileRec.Size;
  
  l.Add(o);
end;

function GetAllHardDrives: TStringList;
var
  c: Char;
begin
  Result := TStringList.Create;
  {$IFDEF WINDOWS}
  for c := 'A' to 'Z' do
  begin
    if GetDriveType(PChar(c + ':\')) = DRIVE_FIXED then
      Result.Add(c);
  end;
  {$ELSE}
  Result.Add(PathDelim); 
  {$ENDIF}
end;

procedure CopyFileInScanObject(Source, Target: String; Index: Int64);
var
  src, trg, l: TList;
  r, o: PScanRecord;
  i: Integer;
begin
  
  src := FindScanObject(Source);
  if src = nil then
    raise Exception.Create('ScanAPI:: CopyFileInScanObject: Named source scan object does not exist!');
  trg := FindScanObject(Target);
  if trg = nil then
    raise Exception.Create('ScanAPI:: CopyFileInScanObject: Named target scan object does not exist!');
  if SizeScanObject(Source) -1 < Index then
    raise Exception.Create('ScanAPI:: CopyFileInScanObject: SmartPosition index in source scan object out of range!');
  
  l := nil;
  for i := 1 to src.Count do
  begin
    l := src[i -1];
    if l.Count -1 <= Index then
    begin
      r := PScanRecord(l[Index]);
      Break;
    end;
    Index := Index - l.Count;
  end;
  
  New(o);
  o^ := r^;
  if TList(trg[trg.Count -1]).Count = SizeLimit then
  begin
    l := TList.Create;
    trg.Add(l);
  end
  else
    l := TList(trg[trg.Count -1]);
  l.Add(o);
end;

function DeleteItemInScanObjectEx(ScanObject: TList; SmartPosition: Int64): Boolean;
var
  i: Integer;
  l: TList;
begin
  Result := false;
  for i := 1 to ScanObject.Count do
  begin
    l := ScanObject[i -1];
    if l.Count -1 >= SmartPosition then
    begin
      Dispose(PScanRecord(l[SmartPosition]));
      l.Delete(SmartPosition);
      Result := True;
      Exit;
    end;
    SmartPosition := SmartPosition - l.Count;
  end;
end;

function DeleteItemInScanObject(Name: String; SmartPosition: Int64): Boolean;
var
  i: Integer;
  l, lX: TList;
begin
  Result := false;
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: DeleteItemInScanObject: Named scan object not found!');
  for i := 1 to l.Count do
  begin
    lX := l[i -1];
    if lX.Count -1 >= SmartPosition then
    begin
      Dispose(PScanRecord(lX[SmartPosition]));
      lX.Delete(SmartPosition);
      Result := True;
      Exit;
    end;
    SmartPosition := SmartPosition - lX.Count;
  end;
end;

function FindFileInScanObjectEy(ScanObject: TList; FileName: String; var FoundAt: Int64): PScanRecord;
var
  sr: TScanRecord;
  s: String;
  i, j: Integer;
  l: TList;
  k: Int64;
begin
  Result := nil;
  k := 0;
  for i := 1 to ScanObject.Count do
  begin
    l := ScanObject[i -1];
    for j := 1 to l.Count do
    begin
      sr := PScanRecord(l[j -1])^;
      s := sr.FileName;
      if Length(s) = Length(FileName) then
        {$IFDEF LINUX}
        if CompareStr(s, FileName) = 0 then
        {$ELSE}
        if CompareText(s, FileName) = 0 then
        {$ENDIF}
        begin
          Result := PScanRecord(l[j -1]);
          FoundAt := k + j;
          Exit;
        end;
    end;
    k := k + l.Count;
  end;
end;

function FindFileInScanObjectEx(ScanObject: TList; FileName: String): PScanRecord;
var
  sr: TScanRecord;
  s: String;
  i, j: Integer;
  l: TList;
begin
  Result := nil;
  for i := 1 to ScanObject.Count do
  begin
    l := ScanObject[i -1];
    for j := 1 to l.Count do
    begin
      sr := PScanRecord(l[j -1])^;
      s := sr.FileName;
      if Length(s) = Length(FileName) then
        {$IFDEF LINUX}
        if CompareStr(s, FileName) = 0 then
        {$ELSE}
        if CompareText(s, FileName) = 0 then
        {$ENDIF}
        begin
          Result := PScanRecord(l[j -1]);
          Exit;
        end;
    end;
  end;
end;

function FindFileInScanObject(Name, FileName: String): Int64;
var
  l, lX: TList;
  i, j: Integer;
  k: Int64;
begin
  l := FindScanObject(Name);
  if FileName = '' then
    raise Exception.Create('ScanAPI:: FindFileInScanObject: Filespec invalid!');
  if l = nil then
    raise Exception.Create('ScanAPI:: FindFileInScanObject: Named scan object not found!');
  Result := -1;
  k := 0; 
  for i := 1 to l.Count do
  begin
    lX := l[i -1];
    for j := 1 to lX.Count do
      if Length(PScanRecord(lX[j -1]).FileName) = Length(FileName) then
        {$IFDEF LINUX}
        if CompareStr(PScanRecord(lX[j -1]).FileName, FileName) = 0 then
        {$ELSE}
        if CompareText(PScanRecord(lX[j -1]).FileName, FileName) = 0 then
        {$ENDIF}
        begin
          Result := k + (j -1);
          Break;
        end;
    k := k + lX.Count;
  end;
end;

procedure PokeScanObjectEx(ScanObject: TList; SmartPosition: Int64;
  var FileName: String);
var
  i: Integer;
  l: TList;
begin
  for i := 1 to ScanObject.Count do
  begin
    l := ScanObject[i -1];
    if l.Count -1 >= SmartPosition then
    begin
      FileName := PScanRecord(l[SmartPosition])^.FileName;
      Exit;
    end;
    SmartPosition := SmartPosition - l.Count;
  end;
end;

procedure PokeScanObject(ScanObject: String; SmartPosition: Int64;
  var Data: TScanRecord);
var
  i: Integer;
  k: Int64;
  l, lX: TList;
begin
  l := FindScanObject(ScanObject);
  if l = nil then
    raise Exception.Create('ScanAPI:: PokeScanObject: Named scan object not found!');
  
  k := 0;
  for i := 1 to l.Count do
  begin
    lX := l[i -1];
    if lX.Count -1 >= SmartPosition then
    begin
      Data := PScanRecord(lX[SmartPosition])^;
      Exit;
    end;
    SmartPosition := SmartPosition - lX.Count;
  end;
end;

procedure SaveScanObject(Name, FileName: String);
var
  t: TextFile;
  i, j: Integer;
  l, lX: TList;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: SaveScanObject: Named scan object not found!');
  AssignFile(t, FileName);
  ReWrite(t);
  for i := 1 to l.Count do
  begin
    lX := l[i -1];
    for j := 1 to lX.Count do
    begin
      WriteLn(t, PScanRecord(lX[j -1])^.FileAttr);
      WriteLn(t, PScanRecord(lX[j -1])^.FileName);
      WriteLn(t, PScanRecord(lX[j -1])^.FileSize);
      WriteLn(t, PScanRecord(lX[j -1])^.FileTime);
      WriteLn(t, PScanRecord(lX[j -1])^.FileVer);
    end;
  end;
  CloseFile(t);
end;

procedure LoadScanObject(Name, FileName: String);
var
  T: TextFile;
  s, sX: String;
  o: PScanRecord;
  l, lX: TList;
begin
  if FindScanObject(Name) <> nil then
    raise Exception.Create('ScanAPI:: LoadScanObject: Named scan object already exists!');
  l := CreateScanObject(Name);
  lX := l[0];
  AssignFile(t, FileName);
  Reset(t);
  while not EOF(t) do
  begin
    New(o);
    ReadLn(t, o^.FileAttr);
    ReadLn(t, o^.FileName);
    ReadLn(t, o^.FileSize);
    ReadLn(t, o^.FileTime);
    ReadLn(t, o^.FileVer);
    if lX.Count = SizeLimit then
    begin
      lX := TList.Create;
      l.Add(lX);
    end;
    lX.Add(o);
  end;
  CloseFile(t);
end;

function CloneObject(Source, Target: String): TList;
var
  i: Int64;
  o: TScanRecord;
  oX: PScanRecord;
  src, trg, l: TList;
begin
  DoDebug('Enter Clone');
  
  src := FindScanObject(Source);
  if src = nil then
    raise Exception.Create('ScanAPI:: CloneObject: Named source scan object does not exist!');
  trg := FindScanObject(Target);
  if trg <> nil then
    FreeScanObject(Target);
  
  trg := CreateScanObject(Target);
  l := trg[0];
  for i := 1 to SizeScanObject(Source) do
  begin
    PokeScanObject(Source, i -1, o);
    New(oX);
    oX^ := o;
    if l.Count = SizeLimit then
    begin
      l := TList.Create;
      trg.Add(l);
    end;
    l.Add(oX);
  end;
  Result := trg;
  DoDebug('Leave Clone');
end;

procedure FindAdded(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
var
  j: Int64;
  sr: PScanRecord;
  s: String;
begin
  PokeScanObjectEx(soHandle, Index, s);
  sr := FindFileInScanObjectEx(Data, s);
  if sr = nil then
    CopyFileInScanObject('__Target', 'Added-', Index);
  if Index mod 10000 = 0 then
    CurrentFile := IntToStr(Index);
end;

procedure FindRemoved(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
var
  j: Integer;
begin
  j := FindFileInScanObject('__Target', PScanRecord(TList(Data)[Index]).FileName);
  if j = -1 then
    CopyFileInScanObject('__Source', 'Removed-', Index);
end;

procedure FindModified(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
var
  b: Boolean;
  j: Integer;
  o, r: TScanRecord;
begin
  j := FindFileInScanObject('__Target', PScanRecord(TList(Data)[Index]).FileName);
  if j <> -1 then
  begin
    PokeScanObject('__Source,', Index, o);
    PokeScanObject('__Target', j, r);
    b := True;
    if o.FileVer <> r.FileVer then b := false
      else
      if o.FileTime <> r.FileTime then b := false
        else
        if o.FileSize <> r.FileSize then b := false;
    if not b then
      CopyFileInScanObject('__Target', 'Modified-', j);
    
  end;
end;

procedure DiffScanObjects(Source, Target, Added, Removed, Modified: String;
  CallBack: TDiffCallBack);
var
  src, trg: TList;
  o, r, sr: TScanRecord;
  i, j, k: Int64;
  b: Boolean;
  SourceEx, TargetEx: String;
  s: String;
  psr: PScanRecord;
begin
  DoDebug('Enter Diff');
  DoDebug('Source: ' + Source);
  DoDebug('Target: ' + Target);
  SourceEx := Source;
  TargetEx := Target;
  
  src := FindScanObject(Source);
  if src = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named source scan object ('+Source+') does not exist!');
  trg := FindScanObject(Target);
  if trg = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named target scan object does not exist!');
  if FindScanObject(Added) <> nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named added files scan object already exists!');
  if FindScanObject(Removed) <> nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named removed files scan object already exists!');
  if FindScanObject(Modified) <> nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named modified files scan object already exists!');
  
  CreateScanObject(Added);
  CreateScanObject(Removed);
  CreateScanObject(Modified);
  
  Source := '__Source';
  Target := '__Target';
  CloneObject(SourceEx, '__Source');
  trg := CloneObject(TargetEx, '__Target');
  
  soHandle := FindScanObject('__Source');
  
  for i := 1 to SizeScanObject('__Target') do
  begin
    PokeScanObjectEx(soHandle, i -1, s);
    psr := FindFileInScanObjectEy(trg, s, j);
    if psr = nil then
      CopyFileInScanObject(Target, Added, i -1)
    else
      
      DeleteItemInScanObjectEx(soHandle, j);
    k := i * 100 div SizeScanObject('__Target');
    k := k div 3;
    if not CallBack(k) then
    begin
      FreeScanObject('__Source');
      FreeScanObject('__Target');
      Exit;
    end;
  end;
  k := 100 div 3;
  if not CallBack(k) then
  begin
    FreeScanObject('__Source');
    FreeScanObject('__Target');
    Exit;
  end;
  src := CloneObject(SourceEx, '__Source');
  CloneObject(TargetEx, '__Target');
  
  ProcThreadPool.DoParallel(FindRemoved, 1, src.Count, src);
  
  k := (100 div 3) +33;
  if not CallBack(k) then
  begin
    FreeScanObject('__Source');
    FreeScanObject('__Target');
    Exit;
  end;
  src := CloneObject(SourceEx, '__Source');
  CloneObject(TargetEx, '__Target');
  
  ProcThreadPool.DoParallel(FindModified, 1, src.Count, src);
  
  k := (100 div 3) +67;
  if not CallBack(k) then
  begin
    FreeScanObject('__Source');
    FreeScanObject('__Target');
    Exit;
  end;
  FreeScanObject('__Source');
  FreeScanObject('__Target');
end;

initialization
  ScanObjects := TStringList.Create;
  ExcludeFromScan := TStringList.Create;

finalization
  try
    FreeAndNil(ScanObjects);
    FreeAndNil(ExcludeFromScan);
  finally
    
  end;

end.
