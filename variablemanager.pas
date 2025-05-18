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
unit VariableManager;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, LMessages, Classes, LookUpStringList, Collections;

type
  TValueEnumerator = Collections.TStrEnumerator;
  TVarPairEnumerator = TStringHashtable.TPairEnumerator;
  TVarValuePair = TStringHashTable.TPair;

  TVariableManager = class
  private
    FLock: TRTLCriticalSection;
    FLockReads: Boolean;
    FVarHash: TStringHashTable;
    function GetItem(const VarName: string): string; inline;
    procedure SetItem(const VarName, Value: string); inline;
    function GetValuesEnumerator: TValueEnumerator; inline;
  protected
    procedure Lock(WriteLock: Boolean = False); inline;
    procedure Unlock(WriteLock: Boolean = False); inline;
  public
    constructor Create(CaseSensitive: Boolean = False; LockReads: Boolean = False);
    destructor Destroy; override;
    procedure Add(const VarName, Value: string); inline;
    procedure Remove(const VarName: string); inline;
    procedure Clear; inline;
    procedure Clear_ex; inline;
    function GetEnumerator: TVarPairEnumerator; inline;
    function GetVarNames(const List: TStrings): Integer;
    function GetFlatList(const List: TStrings): Integer;
    function SubstituteVariablesEval(const Literal: string): string;
    function SubstituteVariables(const Literal: string): string;
    function Contains(const Key: string; out Value: string): Boolean; overload; inline;
    function Contains(const Key: string): Boolean; overload; inline;
    function ContainsValue(const Value: string): Boolean; inline;
    property Item[const VarName: string]: string read GetItem write SetItem; default;
    property LockReads: Boolean read FLockReads write FLockReads;
    property Values: TValueEnumerator read GetValuesEnumerator;
  end;

implementation

uses
  System.Character,
  System.SysUtils;

procedure FastCharMove(const Source; var Dest; Count: Integer);
  {$IFNDEF DEBUG}inline;{$ENDIF}
begin
  move(Source, Dest, Count * SizeOf(Char));
end;

function FastCharPosNoCase(const aSource: String; C: Char; StartPos: Integer): Integer;
var
  L, I: integer;
begin
  Result := 0;
  L := Length(aSource);
  if L = 0 then exit;
  if StartPos > L then exit;
  if StartPos < 1 then StartPos := 1;
  for i := StartPos to L do
    if TCharacter.ToLower(aSource[i]) = C then
      exit(i);
end;

function FastVarReplace(const SourceStr, VarName, Value : string; Offset: Integer): string;
var
  PResult: PChar;
  PReplace: PChar;
  PSource: PChar;
  LResult,
  LReplace,
  LSource,
  LTail,
  LVarName: Integer;

begin
  Dec(Offset); 
  LSource := Length(SourceStr);
  LReplace := Length(Value);
  LVarName := Length(VarName) + 2; 
  LResult :=  LSource - LVarName + LReplace;
  LTail := LSource - (Offset + LVarName);

  PSource := @SourceStr[1];
  SetLength(Result, LResult);
  PResult := @Result[1];
  
  if Offset > 0 then
  begin
    FastCharMove(PSource^, PResult^, Offset);
    Inc(PSource, Offset);
    Inc(PResult, Offset);
  end;
  
  PReplace := @Value[1];
  if (lReplace > 0) then
  begin
    FastCharMove(PReplace^, PResult^, LReplace);
    Inc(PResult, LReplace);
  end;
  
  if LTail > 0 then
  begin
    Inc(PSource, LVarName);
    FastCharMove(PSource^, PResult^, LTail);
  end;
end;

function ExtractNextVariable(const Literal: string; var VarName: string; var Offset: Integer): Boolean;
var
  VarNameLen: Integer;
begin
  Offset := FastCharPosNoCase(Literal, '$', Offset);
  if (Offset > 0) then
  begin
    VarNameLen := FastCharPosNoCase(Literal, '$', Offset + 1) - Offset - 1;
    VarName := System.Copy(Literal, Offset + 1, VarNameLen);
    Result := True;
  end
  else
    Result := False;
end;

constructor TVariableManager.Create(CaseSensitive: Boolean = False; LockReads: Boolean = False);
begin
  InitializeCriticalSection(FLock);
  FVarHash := TStringHashTable.Create(CaseSensitive);
  FLockReads := LockReads;
end;

destructor TVariableManager.Destroy;
begin
  inherited;
  FreeAndNil(FVarHash);
  DeleteCriticalSection(FLock);
end;

procedure TVariableManager.Add(const VarName, Value: string);
begin
  Lock(True);
  try
    FVarHash.Add(VarName, Value);
  finally
    Unlock(True);
  end;
end;

procedure TVariableManager.Clear;
var
   varlist:tstrings;
   i:Integer;
begin
  varlist:=TStringList.Create;
  GetVarNames(varlist);

  for i := 0 to varlist.Count-1 do
  Remove(varlist[i]);

  varlist.Free;

end;

procedure TVariableManager.Clear_ex;
begin
  Lock(True);
  try
    FVarHash.Clear;
  finally
    Unlock(True);
  end;
end;

function TVariableManager.Contains(const Key: string;
  out Value: string): Boolean;
begin
  Lock;
  try
    Result := FVarHash.Contains(Key, Value);
  finally
    Unlock;
  end;
end;

function TVariableManager.Contains(const Key: string): Boolean;
begin
  Lock;
  try
    Result := FVarHash.Contains(Key);
  finally
    Unlock;
  end;
end;

function TVariableManager.ContainsValue(const Value: string): Boolean;
begin
  Lock;
  try
    Result := FVarHash.ContainsValue(Value);
  finally
    Unlock;
  end;
end;

function TVariableManager.GetEnumerator: TVarPairEnumerator;
begin
  Lock;
  try
    Result := FVarHash.GetEnumerator;
  finally
    Unlock;
  end;
end;

function TVariableManager.GetFlatList(const List: TStrings): Integer;
var
  Data: TStringHashTable.TPair;
begin
  List.BeginUpdate;
  try
    List.Clear;
    for Data in FVarHash do
    begin
      
      List.Add(Data.Key);
      List.Add(Data.Value);
    end;
  finally
    List.EndUpdate;
  end;
  Result := List.Count;
end;

function TVariableManager.GetItem(const VarName: string): string;
begin
  Lock;
  try
    
    Result := FVarHash[VarName];
  finally
    Unlock;
  end;
end;

function TVariableManager.GetValuesEnumerator: TValueEnumerator;
begin
  Lock;
  try
    Result := FVarHash.Values;
  finally
    Unlock;
  end;
end;

function TVariableManager.GetVarNames(const List: TStrings): Integer;
var
  Data: TStringHashTable.TPair;
begin
  List.BeginUpdate;
  try
    List.Clear;
    for Data in FVarHash do
      List.Add(Data.Key);
  finally
    List.EndUpdate;
  end;
  Result := List.Count;
end;

procedure TVariableManager.Lock(WriteLock: Boolean = False);
begin
  if WriteLock or FLockReads then
    EnterCriticalSection(FLock);
end;

procedure TVariableManager.Remove(const VarName: string);
begin
  Lock(True);
  try
    FVarHash.Remove(VarName);
  finally
    Unlock(True);
  end;
end;

procedure TVariableManager.SetItem(const VarName, Value: string);
begin
  Lock(True);
  try
    
    FVarHash[VarName] := Value;
  finally
    Unlock(True);
  end;
end;

function TVariableManager.SubstituteVariablesEval(const Literal: string): string;
var
  Offset: Integer;
  Value,
  VarName: string;
begin
  Result := Literal;
  Offset := 0;
  if FastCharPosNoCase(Literal, '$', Offset) > 0 then
  begin
    while ExtractNextVariable(Result, VarName, Offset) do
    begin
      if Contains(VarName, Value) then
        Result := FastVarReplace(Result, VarName, '"' + Value + '"', Offset)
      else
      begin
        
        Inc(Offset, Length(VarName)+1);
      end;
    end;
  end;
end;

function TVariableManager.SubstituteVariables(const Literal: string): string;
var
  Offset: Integer;
  Value,
  VarName: string;
begin
  Result := Literal;
  Offset := 0;
  if FastCharPosNoCase(Literal, '$', Offset) > 0 then
  begin
    while ExtractNextVariable(Result, VarName, Offset) do
    begin
      if Contains(VarName, Value) then
        Result := FastVarReplace(Result, VarName, Value, Offset)
      else
      begin
        
        Inc(Offset, Length(VarName)+1);
      end;
    end;
  end;
end;

procedure TVariableManager.Unlock(WriteLock: Boolean = False);
begin
  if WriteLock or FLockReads then
    LeaveCriticalSection(FLock);
end;

end.
