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

unit ubencher;

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
  {$IFDEF UNIX}
  BaseUnix,
  {$ENDIF}
  LazFileUtils, Classes, Registry, mUtils, SysUtils, MTProcs, MTPCPU
  {$IFDEF WINDOWS}, Windows{$ENDIF};

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
    {$ifdef unix}
    FileMode: TMode;
    {$else}
    FileMode: Cardinal; 
    {$endif unix}
  end;

procedure AddToExcludeFromScan(FileSpec: String);

function IsExcluded(Item: String): Boolean;

procedure ClearExcludeFromScan;

function GetAllHardDrives: TStringList;

function CreateScanObject(Name: String): TList;

function FindScanObject(Name: String): TList;

function FindScanObjectEx(Name: String): TStringList;

function SizeScanObject(Name: String): Int64;

procedure FreeScanObject(Name: String);

procedure ClearScanObjects;

function RunScan(Name, Folder, Mask: String; Recursive, IncludeVersion: Boolean;
  CallBack: TScanCallBack; ActualRoot, RelativeRoot: String): Boolean;

procedure AddFileToScanObject(Name, FileName: String; IncludeVersion: Boolean;
  FileRec: TSearchRec; ActualRoot, RelativeRoot: String);
procedure AddFileToScanObjectEx(Scan: TList; Path: String);

procedure AddFolderToScanObject(Name, Folder: String);
procedure AddFolderToScanObjectEx(Scan: TStringList; Folder: String); inline;
procedure AddFolderToScanObjectEy(Scan: TStringList; Folder: String); inline;

procedure CopyFileInScanObject(Source, Target: String; Index: Int64);
procedure CopyFileInScanObjectEx(Source, Target: TList; Index: Int64);

function FindFileInScanObject(Name, FileName: String): Integer;
function FindFileInScanObjectEx(ScanObject: TList; FileName: String): Int64;
function FindFileInScanObjectEy(ScanObject: TList; FileName: String; SuggestedIndex: Int64; SuggestedOffset: Integer): Int64;

procedure PokeScanObject(ScanObject: String; SmartPosition: Integer;
  var Data: TScanRecord);
function PokeScanObjectEx(ScanObject: TList; SmartPosition: Integer): PScanRecord; inline;

function ScanMyFileExists(Path, Name: String): Boolean;

procedure SaveScanObject(Name, FileName: String);

procedure LoadScanObject(Name, FileName: String);

procedure DiffScanObjects(Source, Target, Added, Removed, Modified: String;
  CallBack: TDiffCallBack);

function DeleteItemInScanObject(Name: String; SmartPosition: Integer): Boolean;

function CloneObject(Source, Target: String): TList;

implementation

uses
  uBenching;

var
  ScanObjects, ScanObjectPaths: TStringList;
  ExcludeFromScan: TStringList;
  soHandle, toHandle, aoHandle, moHandle, roHandle: TList;
  spfdHandle, tpfdHandle: TStringList;
  soName, toName, aoName, moName, roName: String;
  Offset: Integer;

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
  
  s := Item;
  for i := 1 to ExcludeFromScan.Count do
    begin
    if AnsiPos('*', ExcludeFromScan[i -1]) = 1 then
    begin
      
      if AnsiPos(Copy(ExcludeFromScan[i -1], 2, Length(ExcludeFromScan[i -1])), s) > 0 Then
      begin
        Result := True;
        Break;
      end;
    end
    else
    if AnsiPos(ExcludeFromScan[i -1], s) = 1 then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure AddToExcludeFromScan(FileSpec: String);
begin
  
  ExcludeFromScan.Add(FileSpec);
end;

procedure ClearExcludeFromScan;
begin
  ExcludeFromScan.Clear;
end;

function ScanMyFileExists(Path, Name: String): Boolean;
begin
  Result := MyFileExists(AssertDir(Path) + Name) and
    
    MyFileExists(AssertDir(Path) + Name + '.pfd');
end;

function CreateScanObject(Name: String): TList;
begin
  if ScanObjects.IndexOf(Name) <> -1 then
    raise Exception.Create('ScanAPI:: CreateScanObject: Named scan object already exists!');
  if ScanObjectPaths.IndexOf(Name) <> -1 then
    raise Exception.Create('ScanAPI:: CreateScanObject: Named scan object pathfinding already exists!');
  ScanObjects.Add(Name);
  ScanObjectPaths.Add(Name);
  ScanObjects.Objects[ScanObjects.Count -1] := TList.Create;
  Result := TList(ScanObjects.Objects[ScanObjects.Count -1]);
  ScanObjectPaths.Objects[ScanObjectPaths.Count -1] := TStringList.Create;
end;

function FindScanObjectEx(Name: String): TStringList;
begin
  Result := nil;
  if ScanObjectPaths.IndexOf(Name) = -1 then Exit;
  Result := TStringList(ScanObjectPaths.Objects[ScanObjectPaths.IndexOf(Name)]);
end;

function FindScanObject(Name: String): TList;
begin
  Result := nil;
  if ScanObjects.IndexOf(Name) = -1 then Exit;
  Result := TList(ScanObjects.Objects[ScanObjects.IndexOf(Name)]);
end;

function SizeScanObject(Name: String): Int64;
var
  l: TList;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: SizeScanObject: Named scan object not found!');
  Result := l.Count;
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
  l: TList;
  i: Integer;
  lX: TStringList;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: FreeScanObject: Named scan object not found!');
  for i := 1 to l.Count do
    Dispose(l[i -1]);
  l.Free;
  i := ScanObjects.IndexOf(Name);
  ScanObjects.Delete(i);
  lX := FindScanObjectEx(Name);
  if lX = nil then
    raise Exception.Create('ScanAPI:: FreeScanObject: Named scan pathfinder object not found!');
  lX.Free;
  i := ScanObjectPaths.IndexOf(Name);
  ScanObjectPaths.Delete(i);
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
          
          AddFolderToScanObject(Name, AssertDir(Folder) + s + PathDelim)
          
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
  l: TList;
  s: String;
  o: PScanRecord;
  lX: TStringList;
begin
  
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: AddFileToScanObject: Named scan object not found!');
  
  New(o);
  
  if (ActualRoot <> '') and (RelativeRoot <> '') then
  begin
    Delete(FileName, 1, Length(AssertDir(ActualRoot)));
    FileName := AssertDir(RelativeRoot) + FileName;
  end;
  
  o.FileName := FileName;
  o.FileAttr := FileRec.Attr;
  o.FileTime := FileRec.Time;
  o.FileSize := FileRec.Size;
  {$IFDEF WINDOWS}
  o.FileMode := 0;
  {$ELSE}
  o.FileMode := FileRec.Mode;
  {$ENDIF}
  
  l.Add(o);
  
end;

function GetAllHardDrives: TStringList;
var
  c: Char;
begin
  Result := TStringList.Create;
  Result.Add(PathDelim); 
end;

procedure CopyFileInScanObjectEx(Source, Target: TList; Index: Int64);
var
  r, o: PScanRecord;
begin
  
  r := PScanRecord(Source[Index]);
  
  New(o);
  o^ := r^;
  EnterCriticalSection(cs);
  Target.Add(o);
  LeaveCriticalSection(cs);
end;

procedure AddFileToScanObjectEx(Scan: TList; Path: String);
var
  o: PScanRecord;
begin
  New(o);
  o.FileName := Path;
  
  EnterCriticalSection(cs);
  Scan.Add(o);
  LeaveCriticalSection(cs);
end;

procedure AddFolderToScanObject(Name, Folder: String);
var
  lX: TStringList;
begin
  
  lX := FindScanObjectEx(Name);
  if lX = nil then
    raise Exception.Create('ScanAPI:: AddFileToScanObject: Named scan object pathfinder not found!');
  AddFolderToScanObjectEx(lX, Folder);
end;

procedure AddFolderToScanObjectEy(Scan: TStringList; Folder: String); inline;
begin
  EnterCriticalSection(cs);
  Scan.Add(Folder);
  LeaveCriticalSection(cs);
end;

procedure AddFolderToScanObjectEx(Scan: TStringList; Folder: String); inline;
var
  b: Boolean;
  i, j: Integer;
begin
  b := false;
  j := Length(Folder);
  for i := 1 to Scan.Count do
    
    if Length(Scan[i -1]) = j then
      if AnsiCompareText(Scan[i -1], Folder) = 0 then
      begin
        b := True;
        Break;
      end;
  if (not b)  then 
    AddFolderToScanObjectEy(Scan, Folder);
  
end;

procedure CopyFileInScanObject(Source, Target: String; Index: Int64);
var
  src, trg: TList;
  r, o: PScanRecord;
begin
  
  src := FindScanObject(Source);
  if src = nil then
    raise Exception.Create('ScanAPI:: CopyFileInScanObject: Named source scan object does not exist!');
  trg := FindScanObject(Target);
  if trg = nil then
    raise Exception.Create('ScanAPI:: CopyFileInScanObject: Named target scan object does not exist!');
  if src.Count -1 < Index then
    raise Exception.Create('ScanAPI:: CopyFileInScanObject: SmartPosition index in source scan object out of range!');
  
  r := PScanRecord(src[Index]);
  
  New(o);
  o^ := r^;
  trg.Add(o);
end;

function DeleteItemInScanObject(Name: String; SmartPosition: Integer): Boolean;
var
  l: TList;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: DeleteItemInScanObject: Named scan object not found!');
  Dispose(PScanRecord(l[SmartPosition]));
  l.Delete(SmartPosition);
  Result := True;
end;

function FindFileInScanObjectEy(ScanObject: TList; FileName: String; SuggestedIndex: Int64; SuggestedOffset: Integer): Int64;
var
  s: String;
  l: Integer;
  i: NativeUInt;
  j: Int64;
begin
  Result := -1;
  j := SuggestedIndex -SuggestedOffset;
  l := Length(FileName);
  if j < 1 then j := 1;
  for i := j to ScanObject.Count do
  begin
    s := PScanRecord(ScanObject[i -1]).FileName;
    if Length(s) = l then
      
      if CompareText(s, FileName) = 0 then
      begin
        Result := i -1;
        Exit;
      end;
  end;
  for i := 1 to j -1 do
  begin
    s := PScanRecord(ScanObject[i -1]).FileName;
    if Length(s) = l then
      
      if CompareText(s, FileName) = 0 then
      begin
        Result := i -1;
        Break;
      end;
  end;
end;

function FindFileInScanObjectEx(ScanObject: TList; FileName: String): Int64;
var
  i: NativeUInt;
  l: Integer;
begin
  Result := -1;
  l := Length(FileName);
  for i := 1 to ScanObject.Count do
    
    if Length(PScanRecord(ScanObject[i -1]).FileName) = l then
      if CompareText(PScanRecord(ScanObject[i -1]).FileName, FileName) = 0 then
      begin
        Result := i -1;
        Break;
      end;
end;

function FindFileInScanObject(Name, FileName: String): Integer;
var
  l: TList;
  i, j: Integer;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: FindFileInScanObject: Named scan object not found!');
  Result := -1;
  j := Length(FileName);
  for i := 1 to l.Count do
    
    if Length(PScanRecord(l[i -1]).FileName) = j then
      if CompareText(PScanRecord(l[i -1]).FileName, FileName) = 0 then
      begin
        Result := i -1;
        Break;
      end;
end;

function PokeScanObjectEx(ScanObject: TList; SmartPosition: Integer): PScanRecord; inline;
begin
  Result := PScanRecord(ScanObject[SmartPosition]);
end;

procedure PokeScanObject(ScanObject: String; SmartPosition: Integer;
  var Data: TScanRecord);
var
  l: TList;
begin
  l := FindScanObject(ScanObject);
  if l = nil then
    raise Exception.Create('ScanAPI:: PokeScanObject: Named scan object not found!');
  if (SmartPosition < 0) or (SmartPosition > l.Count) then
    raise Exception.Create('ScanAPI:: PokeScanObject: Specified poke index invalid!');
  Data := PScanRecord(l[SmartPosition])^;
end;

procedure SaveScanObject(Name, FileName: String);
var
  lX: TStringList;
  t: TextFile;
  i: Integer;
  l: TList;
begin
  l := FindScanObject(Name);
  if l = nil then
    raise Exception.Create('ScanAPI:: SaveScanObject: Named scan object not found!');
  AssignFile(t, FileName);
  ReWrite(t);
  for i := 1 to l.Count do
  begin
    WriteLn(t, PScanRecord(l[i -1])^.FileAttr);
    WriteLn(t, PScanRecord(l[i -1])^.FileName);
    WriteLn(t, PScanRecord(l[i -1])^.FileSize);
    WriteLn(t, PScanRecord(l[i -1])^.FileTime);
    WriteLn(t, PScanRecord(l[i -1])^.FileMode);
  end;
  CloseFile(t);
  
  lX := FindScanObjectEx(Name);
  if lX = nil then
    raise Exception.Create('ScanAPI:: SaveScanObject: Named scan object pathfinder not found!');
  lX.SaveToFile(FileName + '.pfd');
end;

procedure LoadScanObject(Name, FileName: String);
var
  T: TextFile;
  s, sX: String;
  o: PScanRecord;
  l: TList;
  i: Integer;
  lX: TStringList;
begin
  if FindScanObject(Name) <> nil then Exit;
    
  l := CreateScanObject(Name);
  AssignFile(t, FileName);
  Reset(t);
  while not EOF(t) do
  begin
    New(o);
    l.Add(o);
    ReadLn(t, o^.FileAttr);
    ReadLn(t, o^.FileName);
    {$IFDEF WINDOWS}
    o^.FileName := StringReplace(o^.FileName, '/', '\', [rfReplaceAll, rfIgnoreCase]);
    
    {$ENDIF}
    o^.FileName := StringReplace(o^.FileName, ':', '', [rfReplaceAll, rfIgnoreCase]); 
    ReadLn(t, o^.FileSize);
    ReadLn(t, o^.FileTime);
    ReadLn(t, o^.FileMode);
  end;
  CloseFile(t);
  
  lX := FindScanObjectEx(Name);
  if lX = nil then
    raise Exception.Create('ScanAPI:: LoadScanObject: Named scan object pathfinder not found!');
  
    lX.LoadFromFile(FileName + '.pfd');
  for i := 1 to lX.Count do
  begin
    {$IFDEF WINDOWS}
    lX[i -1] := StringReplace(lX[i -1], '/', '\', [rfReplaceAll, rfIgnoreCase]);
    {$ENDIF}
    lX[i -1] := StringReplace(lX[i -1], ':', '', [rfReplaceAll, rfIgnoreCase]); 
  end;
end;

function CloneObject(Source, Target: String): TList;
var
  i: Integer;
  o: TScanRecord;
  oX: PScanRecord;
  src, trg: TList;
  l, lX: TStringList;
begin
  DoDebug('Enter Clone');
  
  src := FindScanObject(Source);
  if src = nil then
    raise Exception.Create('ScanAPI:: CloneObject: Named source scan object does not exist!');
  trg := FindScanObject(Target);
  if trg <> nil then
    FreeScanObject(Target);
  
  trg := CreateScanObject(Target);
  for i := 1 to src.Count do
  begin
    PokeScanObject(Source, i -1, o);
    New(oX);
    oX^ := o;
    trg.Add(oX);
  end;
  Result := trg;
  
  l := FindScanObjectEx(Source);
  if l = nil then
    raise Exception.Create('ScanAPI:: CloneObject: Named source scan object pathfinder does not exist!');
  lX := FindScanObjectEx(Target);
  if lX = nil then
    raise Exception.Create('ScanAPI:: CloneObject: Named target scan object pathfinder does not exist!');
  lX.Text := l.Text;
  DoDebug('Leave Clone');
end;

procedure FindAdded(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
var
  j: Int64;
  b: Boolean;
  s, sX: String;
begin
  
  s := AssertDir(ExtractFilePath(PScanRecord(TList(Data)[Index -1]).FileName));
  if spfdHandle.IndexOf(s) = -1 then 
  begin
                                    
    if not (tpfdHandle.IndexOf(s) <> -1) then
    begin
      
      b := false;
      sX := s;
      while sX <> PathDelim do
      begin
        
        sX := AssertDir(ExtractFilePath(DeAssertDir(sX)));
        if tpfdHandle.IndexOf(sX) <> -1 then
        begin
          b := True;
          Break;
        end;
      end;
      if not b then
      
        AddFolderToScanObjectEy(tpfdHandle, s);
        
    end;
  end                              
  else
  begin
    j := FindFileInScanObjectEy(soHandle, PScanRecord(TList(Data)[Index -1]).FileName,
      Index -1, Offset);
    
    if j = -1 then
      CopyFileInScanObjectEx(toHandle, aoHandle, Index -1);
  end;
  if Index mod 10 = 0 then
  begin
    EnterCriticalSection(cs);
    
    CurrentFile := PScanRecord(TList(Data)[Index -1]).FileName;
    ComparePos := CompareBase + (Index div 1024);
    b := AbortProcess;
    LeaveCriticalSection(cs);
    if b then raise Exception.Create('User abort during FindAdded');
  end;
end;

procedure FindModifiedRemoved(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
var
  j: Int64;
  b, bX: Boolean;
  s, sX, sY: String;
  o, r: PScanRecord;
  l: Integer;
begin
  o := PScanRecord(TList(Data)[Index -1]); 
  
  s := AssertDir(ExtractFilePath(PScanRecord(TList(Data)[Index -1]).FileName));
  
  if not (spfdHandle.IndexOf(s) <> -1) then 
  begin
    if not (tpfdHandle.IndexOf(s) <> -1) then 
    begin
      b := false;
      sX := s;
      while sX <> PathDelim do
      begin
        sX := AssertDir(ExtractFilePath(DeAssertDir(sX)));
        
        if tpfdHandle.IndexOf(sX) <> -1 then
        begin
          b := True;
          Break;
        end;
      end;
      if not b then
        AddFolderToScanObjectEy(tpfdHandle, s);
    end;
  end
  else
  begin
    j := FindFileInScanObjectEy(toHandle, PScanRecord(TList(Data)[Index -1]).FileName,
      Index -1, Offset);
    if j = -1 then
      CopyFileInScanObjectEx(soHandle, roHandle, Index -1)
    else
    begin
      o := PScanRecord(TList(Data)[Index -1]);
      r := PokeScanObjectEx(toHandle, j);
      if (o.FileSize <> r.FileSize) or
        (o.FileTime <> r.FileTime) then
        
        CopyFileInScanObjectEx(toHandle, moHandle, j);
    end;
  end;
  
  if  ((Index mod 100) = 0) then
  begin
    EnterCriticalSection(cs);
    
    CurrentFile := o.FileName;
    ComparePos := CompareBase + (Index div 1024);
    b := AbortProcess;
    LeaveCriticalSection(cs);
    if b then raise Exception.Create('User abort during FindModifiedRemoved');
  end;
end;

procedure DiffScanObjects(Source, Target, Added, Removed, Modified: String;
  CallBack: TDiffCallBack);
var
  i, j: Integer;
  b: Boolean;
  s, sX: String;
  src, trg: TList;
begin
  DoDebug('Enter Diff');
  DoDebug('Source: ' + Source);
  DoDebug('Target: ' + Target);
  
  src := FindScanObject(Source);
  if src = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named source scan object does not exist!');
  trg := FindScanObject(Target);
  if trg = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named target scan object does not exist!');
  spfdHandle := FindScanObjectEx(Source);
  if spfdHandle = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named source scan object pathfinder does not exist!');
  if FindScanObject(Added) <> nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named added files scan object already exists!');
  if FindScanObject(Removed) <> nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named removed files scan object already exists!');
  if FindScanObject(Modified) <> nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named modified files scan object already exists!');
  
  CreateScanObject(Added);
  CreateScanObject(Removed);
  CreateScanObject(Modified);
  
  soHandle := src;
  toHandle := trg;
  aoHandle := FindScanObject(Added);
  moHandle := FindScanObject(Modified);
  roHandle := FindScanObject(Removed);
  soName := Source;
  toName := Target;
  aoName := Added;
  moName := Modified;
  roName := Removed;
  Offset := Abs(SizeScanObject(Source) - SizeScanObject(Target))
    
    +10000;
    
  tpfdHandle := FindScanObjectEx(Added);
  if tpfdHandle = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named added scan object pathfinder does not exist!');
  
  EnterCriticalSection(cs);
  TotalSeconds := 0;
  TotalItems := trg.count;
  CompareMax := TotalItems div 1024;
  ComparePos := 0;
  CurrentType := 'Workload objects warming up your CPU registers:';
  LeaveCriticalSection(cs);
  try
    
  except
    
    Exit;
  end;
  
  for i := tpfdHandle.Count downto 1 do
  begin
    if i > tpfdHandle.Count then Continue; 
    
    b := false;
    s := tpfdHandle[i -1]; 
    sX := s;
    while sX <> PathDelim do
    begin
      sX := AssertDir(ExtractFilePath(DeAssertDir(sX))); 
      if tpfdHandle.IndexOf(sX) <> -1 then 
      begin
        tpfdHandle.Delete(i -1); 
        b := True;
        Break;
      end;
    end;
    while tpfdHandle.IndexOf(s) <> -1 do 
      tpfdHandle.Delete(tpfdHandle.IndexOf(s)); 
      
    for j := tpfdHandle.Count downto 1 do
      if AnsiPos(s, tpfdHandle[j -1]) = 1 then
        tpfdHandle.Delete(j -1); 
    
    if not b then
      AddFileToScanObjectEx(aoHandle, s + '*'); 
  end;
  
  spfdHandle := FindScanObjectEx(Target);
  if spfdHandle = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named target scan object pathfinder does not exist!');
  tpfdHandle := FindScanObjectEx(Removed);
  if tpfdHandle = nil then
    raise Exception.Create('ScanAPI:: DiffScanObjects: Named removed scan object pathfinder does not exist!');
  EnterCriticalSection(cs);
  TotalSeconds := 0;
  
    TotalItems := 25900 *3;
  CompareMin := 0;
  CompareMax := TotalItems div 1024;
  ComparePos := 0;
  CurrentType := 'Workload objects benchmarking your CPU:';
  ProcThreadPool.MaxThreadCount := GetSystemThreadCount *2;
  LeaveCriticalSection(cs);
  try
    CompareBase := (TotalItems div 3) *0 div 1024;
    ProcThreadPool.DoParallel(FindModifiedRemoved, 1, (TotalItems div 3), src, GetSystemThreadCount *2);
    moHandle.Clear;
    CompareBase := (TotalItems div 3) *1 div 1024;
    ProcThreadPool.DoParallel(FindModifiedRemoved, 1, (TotalItems div 3), src, GetSystemThreadCount *2);
    moHandle.Clear;
    CompareBase := (TotalItems div 3) *2 div 1024;
    ProcThreadPool.DoParallel(FindModifiedRemoved, 1, (TotalItems div 3), src, GetSystemThreadCount *2);
    moHandle.Clear;
    CompareBase := (TotalItems div 3) *3 div 1024;
  except
    
    Exit;
  end;
  
  for i := tpfdHandle.Count downto 1 do
  begin
    if i > tpfdHandle.Count then Continue; 
    
    b := false;
    s := tpfdHandle[i -1]; 
    sX := s;
    while sX <> PathDelim do
    begin
      sX := AssertDir(ExtractFilePath(DeAssertDir(sX))); 
      if tpfdHandle.IndexOf(sX) <> -1 then 
      begin
        tpfdHandle.Delete(i -1); 
        b := True;
        Break;
      end;
    end;
    while tpfdHandle.IndexOf(s) <> -1 do 
      tpfdHandle.Delete(tpfdHandle.IndexOf(s));
    for j := tpfdHandle.Count downto 1 do
      if AnsiPos(s, tpfdHandle[j -1]) = 1 then
        tpfdHandle.Delete(j -1); 
    if not b then
      AddFileToScanObjectEx(roHandle, s + '*'); 
  end;
  
end;

initialization
  ScanObjects := TStringList.Create;
  ScanObjectPaths := TStringList.Create;
  ExcludeFromScan := TStringList.Create;

finalization
  try
  FreeAndNil(ScanObjects);
  FreeAndNil(ScanObjectPaths);
    FreeAndNil(ExcludeFromScan);
  finally
    
  end;

end.
