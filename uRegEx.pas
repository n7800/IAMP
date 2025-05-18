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
unit uRegEx;

interface

uses Windows, SysUtils;

type
  TByteArray = array of Byte;

function StringToByteArray(Value: String): TByteArray;
function RegGetValueTypeEz(RootKey: HKEY; Subkey, Leaf: String; var Value: Cardinal; Computer: String = ''): boolean;
function RegValueExistsEz(RootKey: HKEY; Subkey, Leaf: String; Computer: String = ''): boolean;
function RegKeyExistsEz(RootKey: HKEY; Subkey: String; Computer: String = ''): boolean;
function RegDelValueEz(RootKey: HKEY; Subkey, Leaf: String; var LastError: Integer; Computer: String = ''): boolean;
function RegDelKeyEz(RootKey: HKEY; Subkey: String; var LastError: Integer; Computer: String = ''): boolean;
function RegSetStringEz(RootKey: HKEY; Subkey, Leaf: String; Value: String; var LastError: Integer; Computer: String = ''): boolean;
function RegSetMultiStringEz(RootKey: HKEY; Subkey, Leaf: String; Value: String; var LastError: Integer; Computer: String = ''): boolean;
function RegSetExpandStringEz(RootKey: HKEY; Subkey, Leaf: String; Value: String; var LastError: Integer; Computer: String = ''): boolean;
function RegSetDWORDEz(RootKey: HKEY; Subkey, Leaf: String; Value: Cardinal; var LastError: Integer; Computer: String = ''): boolean;
function RegSetBinaryEz(RootKey: HKEY; Subkey, Leaf: String; Value: Array of Byte; var LastError: Integer; Computer: String = ''): boolean;
function RegGetMultiStringEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: String; var LastError: Integer; Computer: String = ''): boolean;
function RegGetDWORDEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: Cardinal; Var LastError: Integer): boolean;
function RegGetExpandStringEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: String; Var LastError: Integer): boolean;
function RegGetStringEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: String; var LastError: Integer): boolean;

function RegSetString(RootKey: HKEY; Name: String; Value: String): boolean;
function RegSetStringEy(RootKey: HKEY; Name: String; Value: String; var LastError: Integer): boolean;
function RegSetMultiString(RootKey: HKEY; Name: String; Value: String): boolean;
function RegSetMultiStringEy(RootKey: HKEY; Name: String; Value: String; var LastError: Integer): boolean;
function RegSetExpandString(RootKey: HKEY; Name: String; Value: String): boolean;
function RegSetExpandStringEy(RootKey: HKEY; Name: String; Value: String; var LastError: Integer): boolean;
function RegSetDWORD(RootKey: HKEY; Name: String; Value: Cardinal): boolean;
function RegSetDWORDEy(RootKey: HKEY; Name: String; Value: Cardinal; var LastError: Integer): boolean;
function RegSetBinary(RootKey: HKEY; Name: String; Value: Array of Byte): boolean;
function RegSetBinaryEy(RootKey: HKEY; Name: String; Value: Array of Byte; var LastError: Integer): boolean;
function RegGetString(RootKey: HKEY; Name: String; Var Value: String): boolean;
function RegGetMultiString(RootKey: HKEY; Name: String; Var Value: String; Computer: String = ''): boolean;
function RegGetMultiStringEy(RootKey: HKEY; Name: String; Var Value: String; var LastError: Integer; Computer: String = ''): boolean;
function RegGetExpandString(RootKey: HKEY; Name: String; Var Value: String): boolean;
function RegGetDWORD(RootKey: HKEY; Name: String; Var Value: Cardinal): boolean;
function RegGetBinary(RootKey: HKEY; Name: String; Var Value: String; Computer: String = ''): boolean;
function RegGetValueType(RootKey: HKEY; Name: String; var Value: Cardinal): boolean;
function RegDefaultValueExists(RootKey: HKEY; Name: String; Computer: String = ''): boolean;
function RegValueExists(RootKey: HKEY; Name: String): boolean;
function RegKeyExists(RootKey: HKEY; Name: String): boolean;
function RegDelValue(RootKey: HKEY; Name: String): boolean;
function RegDelValueEy(RootKey: HKEY; Name: String; var LastError: Integer): boolean;
function RegDelKey(RootKey: HKEY; Name: String): boolean;
function RegDelKeyEy(RootKey: HKEY; Name: String; var LastError: Integer): boolean;
function RegConnect(MachineName: String; RootKey: HKEY; var RemoteKey: HKEY): boolean;
function RegDisconnect(RemoteKey: HKEY): boolean;
function RegEnumKeys(RootKey: HKEY; Name: String; var KeyList: String; Computer: String = ''): boolean;
function RegEnumValues(RootKey: HKEY; Name: String; var ValueList: String; Computer: String = ''): boolean;

implementation

uses
  mUtils;

function StringToByteArray(Value: String): TByteArray;
var
  i: Integer;
  arrayPos: Integer;
  hex: String;
  arraySize: Integer;
  byteVal: SmallInt;
begin
  try
    arraySize := Trunc(Length(Value) / 2);
    SetLength(Result, arraySize);
    arrayPos := 0;
    i := 1;
    while not (i = Length(Value) +1) do
    begin
      hex := Copy(Value, i, 2);
      byteVal := Ord(StrToInt('$' + hex));
      Result[arrayPos] := byteVal;
      Inc(arrayPos);
      Inc(i);
      Inc(i);
    end;
  except
  end;
end;

function LastPos(Needle: Char; Haystack: String): integer;
begin
  for Result := Length(Haystack) downto 1 do
    if Haystack[Result] = Needle then
      Break;
end;

function RegConnect(MachineName: String; RootKey: HKEY; var RemoteKey: HKEY): boolean;
begin
  Result := (RegConnectRegistry(PChar(MachineName), RootKey, RemoteKey) = ERROR_SUCCESS);
end;

function RegDisconnect(RemoteKey: HKEY): boolean;
begin
  Result := (RegCloseKey(RemoteKey) = ERROR_SUCCESS);
end;

function RegSetValueEy(RootKey: HKEY; Name: String; ValType: Cardinal; PVal: Pointer; ValSize: Cardinal; var LastError: Integer): boolean;
var
  SubKey: String;
  n: integer;
  dispo: DWORD;
  hTemp: HKEY;
  li: LongInt;
begin
  LastError := 0;
  Result := False;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    li := RegCreateKeyEx(RootKey, PChar(SubKey), 0, nil, REG_OPTION_NON_VOLATILE, KEY_WRITE or REG_ACCESS_CONST,
      nil, hTemp, @dispo);
    if li = ERROR_SUCCESS then
    begin
      SubKey := Copy(Name, n + 1, Length(Name) - n);
      li := (RegSetValueEx(hTemp, PChar(SubKey), 0, ValType, PVal, ValSize) );
      Result := li = ERROR_SUCCESS;
      if not Result then
        LastError := li;
      RegCloseKey(hTemp);
    end
    else
      LastError := li;
  end;
end;

function RegSetValueEz(RootKey: HKEY; Subkey, Leaf: String; ValType: Cardinal; PVal: Pointer; ValSize: Cardinal; var LastError: Integer; Computer: String = ''): boolean;
var
  dispo: DWORD;
  hTemp: HKEY;
  li: LongInt;
begin
  LastError := 0;
  Result := False;
  if Computer <> '' then
  begin
    li := RegConnectRegistry(PChar(Computer), RootKey, hTemp);
    if li <> ERROR_SUCCESS then
    begin
      LastError := li;
      Exit;
    end
    else
      RootKey := hTemp;
  end;
  li := RegCreateKeyEx(RootKey, PChar(SubKey), 0, nil, REG_OPTION_NON_VOLATILE, KEY_WRITE or REG_ACCESS_CONST,
    nil, hTemp, @dispo);
  if li = ERROR_SUCCESS then
  begin
    li  := (RegSetValueEx(hTemp, PChar(Leaf), 0, ValType, PVal, ValSize) );
    Result := li = ERROR_SUCCESS;
    if li <> ERROR_SUCCESS  then
      LastError := li;
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end
  else
    LastError := li;
end;

function RegSetValue(RootKey: HKEY; Name: String; ValType: Cardinal; PVal: Pointer; ValSize: Cardinal): boolean;
var
  LastError: Integer;
begin
  Result := RegSetValueEy(RootKey, Name, ValType, PVal, ValSize, LastError);
end;

function RegGetValueEy(RootKey: HKEY; Name: String; ValType: Cardinal; var PVal: Pointer;
  var ValSize: Cardinal; var LastError: Integer; Computer: String = ''): boolean;
var
  SubKey: String;
  n: integer;
  MyValType: DWORD;
  hTemp: HKEY;
  Buf: Pointer;
  BufSize: Cardinal;
  li: LongInt;
begin
  LastError := 0;
  Result := False;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    if Computer <> '' then 
    begin
      if AnsiPos('\\', Computer) <> 1 then
        Computer := '\\' + Computer;
      li := RegConnectRegistry(PChar(Computer), RootKey, hTemp);
      if li <> ERROR_SUCCESS then
      begin
        LastError := li;
        Exit;
      end
      else
        RootKey := hTemp;
    end;
    li := RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp);
    if li = ERROR_SUCCESS then
    begin
      SubKey := Copy(Name, n + 1, Length(Name) - n);
      li := RegQueryValueEx(hTemp, PChar(SubKey), nil, @MyValType, nil, @BufSize);
      if li = ERROR_SUCCESS then
      begin
        GetMem(Buf, BufSize*8);
        li := RegQueryValueEx(hTemp, PChar(SubKey), nil, @MyValType, Buf, @BufSize);
        if li = ERROR_SUCCESS then
        begin
          if ValType = MyValType then
          begin
            PVal := Buf;
            ValSize := BufSize;
            Result := True;
          end else
          begin
            FreeMem(Buf);
          end;
        end
        else
        begin
          LastError := li;
          FreeMem(Buf);
        end;
      end
      else
        LastError := li;
      RegCloseKey(hTemp);
      if Computer <> '' then
        RegCloseKey(RootKey);
    end
    else
      LastError := li;
  end;
end;

function RegGetValue(RootKey: HKEY; Name: String; ValType: Cardinal; var PVal: Pointer;
  var ValSize: Cardinal; Computer: String = ''): boolean;
var
  LastError: Integer;
begin
  Result := RegGetValueEy(RootKey, Name, ValType, PVal, ValSize, LastError, Computer);
end;

function RegGetValueEz(RootKey: HKEY; Subkey, Leaf: String; ValType: Cardinal; var PVal: Pointer;
  var ValSize: Cardinal; var LastError: Integer; Computer: String = ''): boolean;
var
  n: integer;
  MyValType: DWORD;
  hTemp: HKEY;
  Buf: Pointer;
  BufSize: Cardinal;
  li: LongInt;
begin
  LastError := 0;
  Result := False;
  if Computer <> '' then
  begin
    li := RegConnectRegistry(PChar(Computer), RootKey, hTemp);
    if li <> ERROR_SUCCESS then
    begin
      LastError := li;
      Exit;
    end
    else
      RootKey := hTemp;
  end;
  li := RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp);
  if li = ERROR_SUCCESS then
  begin
    li := RegQueryValueEx(hTemp, PChar(Leaf), nil, @MyValType, nil, @BufSize);
    if li = ERROR_SUCCESS then
    begin
      GetMem(Buf, BufSize*8);
      li := RegQueryValueEx(hTemp, PChar(Leaf), nil, @MyValType, Buf, @BufSize);
      if li = ERROR_SUCCESS then
      begin
        if ValType = MyValType then
        begin
          PVal := Buf;
          ValSize := BufSize;
          Result := True;
        end else
        begin
          FreeMem(Buf);
        end;
      end
      else
      begin
        LastError := li;
        FreeMem(Buf);
      end;
    end
    else
      LastError := li;
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end
  else
    LastError := li;
end;

function RegSetString(RootKey: HKEY; Name: String; Value: String): boolean;
begin
  Result := RegSetValue(RootKey, Name, REG_SZ, PChar(Value + #0), (Length(Value) + 1) *SizeOf(Char));
end;

function RegSetStringEy(RootKey: HKEY; Name: String; Value: String; var LastError: Integer): boolean;
begin
  Result := RegSetValueEy(RootKey, Name, REG_SZ, PChar(Value + #0), (Length(Value) + 1) *SizeOf(Char), LastError);
end;

function RegSetMultiString(RootKey: HKEY; Name: String; Value: String): boolean;
begin
  Result := RegSetValue(RootKey, Name, REG_MULTI_SZ, PChar(Value + #0#0), (Length(Value) + 2) *SizeOf(Char));
end;

function RegSetMultiStringEy(RootKey: HKEY; Name: String; Value: String; var LastError: Integer): boolean;
begin
  Result := RegSetValueEy(RootKey, Name, REG_MULTI_SZ, PChar(Value + #0#0), (Length(Value) + 2) *SizeOf(Char), LastError);
end;

function RegSetExpandString(RootKey: HKEY; Name: String; Value: String): boolean;
begin
  Result := RegSetValue(RootKey, Name, REG_EXPAND_SZ, PChar(Value + #0), (Length(Value) + 1) *SizeOf(Char));
end;

function RegSetExpandStringEy(RootKey: HKEY; Name: String; Value: String; var LastError: Integer): boolean;
begin
  Result := RegSetValueEy(RootKey, Name, REG_EXPAND_SZ, PChar(Value + #0), (Length(Value) + 1) *SizeOf(Char), LastError);
end;

function RegSetDwordEy(RootKey: HKEY; Name: String; Value: Cardinal; var LastError: Integer): boolean;
begin
  Result := RegSetValueEy(RootKey, Name, REG_DWORD, @Value, SizeOf(Cardinal), LastError);
end;

function RegSetDword(RootKey: HKEY; Name: String; Value: Cardinal): boolean;
begin
  Result := RegSetValue(RootKey, Name, REG_DWORD, @Value, SizeOf(Cardinal));
end;

function RegSetBinaryEy(RootKey: HKEY; Name: String; Value: Array of Byte; var LastError: Integer): boolean;
begin
  Result := RegSetValueEy(RootKey, Name, REG_BINARY, @Value[Low(Value)], length(Value), LastError);
end;

function RegSetBinary(RootKey: HKEY; Name: String; Value: Array of Byte): boolean;
begin
  Result := RegSetValue(RootKey, Name, REG_BINARY, @Value[Low(Value)], length(Value));
end;

function RegGetStringEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: String; var LastError: Integer): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  if RegGetValueEz(RootKey, Subkey, Leaf, REG_SZ, Buf, BufSize, LastError) then
  begin
    Dec(BufSize);
    SetLength(Value, BufSize div SizeOf(Char));
    if BufSize > 0 then
      CopyMemory(@Value[1], Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegGetString(RootKey: HKEY; Name: String; Var Value: String): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  if RegGetValue(RootKey, Name, REG_SZ, Buf, BufSize) then
  begin
    Dec(BufSize);
    SetLength(Value, BufSize div SizeOf(Char));
    if BufSize > 0 then
      CopyMemory(@Value[1], Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegGetMultiString(RootKey: HKEY; Name: String; Var Value: String; Computer: String = ''): boolean;
var
  LastError: Integer;
begin
  Result := RegGetMultiStringEy(RootKey, Name, Value, LastError, Computer);
end;

function RegGetMultiStringEy(RootKey: HKEY; Name: String; Var Value: String; var LastError: Integer; Computer: String = ''): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  LastError := 0;
  Result := False;
  if RegGetValueEy(RootKey, Name, REG_MULTI_SZ, Buf, BufSize, LastError, Computer) then
  begin
    Dec(BufSize);
    SetLength(Value, BufSize div SizeOf(Char));
    if BufSize > 0 then
      CopyMemory(@Value[1], Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegGetExpandStringEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: String; Var LastError: Integer): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  if RegGetValueEz(RootKey, Subkey, Leaf, REG_EXPAND_SZ, Buf, BufSize, LastError) then
  begin
    Dec(BufSize);
    SetLength(Value, BufSize div SizeOf(Char));
    if BufSize > 0 then
      CopyMemory(@Value[1], Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegGetExpandString(RootKey: HKEY; Name: String; Var Value: String): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  if RegGetValue(RootKey, Name, REG_EXPAND_SZ, Buf, BufSize) then
  begin
    Dec(BufSize);
    SetLength(Value, BufSize div SizeOf(Char));
    if BufSize > 0 then
      CopyMemory(@Value[1], Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegGetDWORDEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: Cardinal; Var LastError: Integer): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  if RegGetValueEz(RootKey, Subkey, Leaf, REG_DWORD, Buf, BufSize, LastError) then
  begin
    CopyMemory(@Value, Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegGetDWORD(RootKey: HKEY; Name: String; Var Value: Cardinal): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  if RegGetValue(RootKey, Name, REG_DWORD, Buf, BufSize) then
  begin
    CopyMemory(@Value, Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegGetBinary(RootKey: HKEY; Name: String; Var Value: String; Computer: String = ''): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  if RegGetValue(RootKey, Name, REG_BINARY, Buf, BufSize, Computer) then
  begin
    SetLength(Value, BufSize);
    CopyMemory(@Value[1], Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegDefaultValueExists(RootKey: HKEY; Name: String; Computer: String = ''): boolean;
var
  SubKey: String;
  n: integer;
  hTemp: HKEY;
begin
  Result := False;
  if Computer <> '' then
  begin
    if RegConnectRegistry(PChar(Computer), RootKey, hTemp) <> ERROR_SUCCESS then
      Exit
    else
      RootKey := hTemp;
  end;
  if RegOpenKeyEx(RootKey, PChar(Name), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS then
  begin
    Result := (RegQueryValueEx(hTemp, nil, nil, nil, nil, nil) = ERROR_SUCCESS);
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end;
end;

function RegValueExists(RootKey: HKEY; Name: String): boolean;
var
  SubKey: String;
  n: integer;
  hTemp: HKEY;
begin
  Result := False;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    if RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS then
    begin
      SubKey := Copy(Name, n + 1, Length(Name) - n);
      Result := (RegQueryValueEx(hTemp, PChar(SubKey), nil, nil, nil, nil) = ERROR_SUCCESS);
      RegCloseKey(hTemp);
    end;
  end;
end;

function RegValueExistsEz(RootKey: HKEY; Subkey, Leaf: String; Computer: String = ''): boolean;
var
  hTemp: HKEY;
begin
  Result := False;
  if Computer <> '' then
  begin
    if RegConnectRegistry(PChar(Computer), RootKey, hTemp) <> ERROR_SUCCESS then
      Exit
    else
      RootKey := hTemp;
  end;
  if RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS then
  begin
    Result := (RegQueryValueEx(hTemp, PChar(Leaf), nil, nil, nil, nil) = ERROR_SUCCESS);
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end;
end;

function RegGetValueType(RootKey: HKEY; Name: String; var Value: Cardinal): boolean;
var
  SubKey: String;
  n: integer;
  hTemp: HKEY;
  ValType: Cardinal;
begin
  Result := False;
  Value := REG_NONE;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    if (RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS) then
    begin
      SubKey := Copy(Name, n + 1, Length(Name) - n);
      Result := (RegQueryValueEx(hTemp, PChar(SubKey), nil, @ValType, nil, nil) = ERROR_SUCCESS);
      if Result then
        Value := ValType;
      RegCloseKey(hTemp);
    end;
  end;
end;

function RegGetValueTypeEz(RootKey: HKEY; Subkey, Leaf: String; var Value: Cardinal; Computer: String = ''): boolean;
var
  hTemp: HKEY;
  ValType: Cardinal;
begin
  Result := False;
  Value := REG_NONE;
  if Computer <> '' then
  begin
    if RegConnectRegistry(PChar(Computer), RootKey, hTemp) <> ERROR_SUCCESS then
      Exit
    else
      RootKey := hTemp;
  end;
  if (RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS) then
  begin
    Result := (RegQueryValueEx(hTemp, PChar(Leaf), nil, @ValType, nil, nil) = ERROR_SUCCESS);
    if Result then
      Value := ValType;
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end;
end;

function RegKeyExists(RootKey: HKEY; Name: String): boolean;
var
  SubKey: String;
  n: integer;
  hTemp: HKEY;
begin
  Result := False;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    if RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS then
    begin
      Result := True;
      RegCloseKey(hTemp);
    end;
  end;
end;

function RegKeyExistsEz(RootKey: HKEY; Subkey: String; Computer: String = ''): boolean;
var
  hTemp: HKEY;
begin
  
  Result := False;
  if Computer <> '' then 
  begin
    if RegConnectRegistry(PChar(Computer), RootKey, hTemp) <> ERROR_SUCCESS then
      Exit
    else
      RootKey := hTemp;
  end;
  if RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS then
  begin
    Result := True;
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end;
end;

function RegDelValue(RootKey: HKEY; Name: String): boolean;
var
  i: Integer;
begin
  Result := RegDelValueEy(RootKey, Name, i);
end;

function RegDelValueEy(RootKey: HKEY; Name: String; var LastError: Integer): boolean;
var
  SubKey: String;
  n: integer;
  hTemp: HKEY;
  li: LongInt;
begin
  LastError := 0;
  Result := False;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    li := RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_WRITE or REG_ACCESS_CONST, hTemp);
    if li = ERROR_SUCCESS then
    begin
      SubKey := Copy(Name, n + 1, Length(Name) - n);
      li := (RegDeleteValue(hTemp, PChar(SubKey)) );
      Result := li = ERROR_SUCCESS;
      if not Result then
        LastError := li;
      RegCloseKey(hTemp);
    end
    else
      LastError := li;
  end;
end;

function RegDelValueEz(RootKey: HKEY; Subkey, Leaf: String; var LastError: Integer; Computer: String = ''): boolean;
var
  hTemp: HKEY;
  li: LongInt;
begin
  LastError := 0;
  Result := False;
  if Computer <> '' then
  begin
    li := RegConnectRegistry(PChar(Computer), RootKey, hTemp);
    if li <> ERROR_SUCCESS then
    begin
      LastError := li;
      Exit;
    end
    else
      RootKey := hTemp;
  end;
  li := RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_WRITE or REG_ACCESS_CONST, hTemp);
  if li = ERROR_SUCCESS then
  begin
    
    li := (RegDeleteValue(hTemp, PChar(Leaf)) );
    Result := li = ERROR_SUCCESS;
    if not Result then
      LastError := li;
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end
  else
    LastError := li;
end;

function RegDelKey(RootKey: HKEY; Name: String): boolean;
var
  i: Integer;
begin
  Result := RegDelKeyEy(RootKey, Name, i);
end;

function RegDelKeyEy(RootKey: HKEY; Name: String; var LastError: Integer): boolean;
var
  SubKey: String;
  n: integer;
  hTemp: HKEY;
  li: LongInt;
begin
  LastError := 0;
  Result := False;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    li := RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_WRITE or REG_ACCESS_CONST, hTemp);
    if li = ERROR_SUCCESS then
    begin
      SubKey := Copy(Name, n + 1, Length(Name) - n);
      li := (RegDeleteKey(hTemp, PChar(SubKey)) );
      Result := li = ERROR_SUCCESS;
      if not Result then
        LastError := li;
      RegCloseKey(hTemp);
    end
    else
      LastError := li;
  end;
end;

function RegSetStringEz(RootKey: HKEY; Subkey, Leaf: String; Value: String; var LastError: Integer; Computer: String = ''): boolean;
begin
  Result := RegSetValueEz(RootKey, Subkey, Leaf, REG_SZ, PChar(Value + #0), (Length(Value) + 1) *SizeOf(Char), LastError, Computer);
end;

function RegSetMultiStringEz(RootKey: HKEY; Subkey, Leaf: String; Value: String; var LastError: Integer; Computer: String = ''): boolean;
begin
  Result := RegSetValueEz(RootKey, Subkey, Leaf, REG_MULTI_SZ, PChar(Value + #0#0), (Length(Value) + 2) *SizeOf(Char), LastError, Computer);
end;

function RegSetExpandStringEz(RootKey: HKEY; Subkey, Leaf: String; Value: String; var LastError: Integer; Computer: String = ''): boolean;
begin
  Result := RegSetValueEz(RootKey, Subkey, Leaf, REG_EXPAND_SZ, PChar(Value + #0), (Length(Value) + 1) *SizeOf(Char), LastError, Computer);
end;

function RegSetDWORDEz(RootKey: HKEY; Subkey, Leaf: String; Value: Cardinal; var LastError: Integer; Computer: String = ''): boolean;
begin
  Result := RegSetValueEz(RootKey, Subkey, Leaf, REG_DWORD, @Value, SizeOf(Cardinal), LastError, Computer);
end;

function RegSetBinaryEz(RootKey: HKEY; Subkey, Leaf: String; Value: Array of Byte; var LastError: Integer; Computer: String = ''): boolean;
begin
  Result := RegSetValueEz(RootKey, Subkey, Leaf, REG_BINARY, @Value[Low(Value)], length(Value), LastError, Computer);
end;

function RegGetMultiStringEz(RootKey: HKEY; Subkey, Leaf: String; Var Value: String; var LastError: Integer; Computer: String = ''): boolean;
var
  Buf: Pointer;
  BufSize: Cardinal;
begin
  LastError := 0;
  Result := False;
  if RegGetValueEz(RootKey, Subkey, Leaf, REG_MULTI_SZ, Buf, BufSize, LastError, Computer) then
  begin
    Dec(BufSize);
    SetLength(Value, BufSize div SizeOf(Char));
    if BufSize > 0 then
      CopyMemory(@Value[1], Buf, BufSize);
    FreeMem(Buf);
    Result := True;
  end;
end;

function RegDelKeyEz(RootKey: HKEY; Subkey: String; var LastError: Integer; Computer: String = ''): boolean;
type
  TRegDeleteKeyExFunc = function(hKey: HKEY; lpSubKey: PChar;
    samDesired: REGSAM; Reserved: DWORD): Longint; stdcall;
var
  RegDeleteKeyExFunc: TRegDeleteKeyExFunc;
  li: LongInt;
  hTemp: HKEY;
begin
  Pointer(RegDeleteKeyExFunc) := GetProcAddress(GetModuleHandle('advapi32.dll'), 
    'RegDeleteKeyExA'); 
  LastError := 0;
  if Computer <> '' then
  begin
    li := RegConnectRegistry(PChar(Computer), RootKey, hTemp);
    if li <> ERROR_SUCCESS then
    begin
      Result := false;
      LastError := li;
      Exit;
    end
    else
      RootKey := hTemp;
  end;
  if Assigned(RegDeleteKeyExFunc) then
  begin
    
    li := RegDeleteKeyExFunc(RootKey, PChar(SubKey), REG_ACCESS_CONST, 0) ;
    
    if li = 1745 then 
      li := (RegDeleteKey(RootKey, PChar(SubKey)) );
  end
  else
    
    li := (RegDeleteKey(RootKey, PChar(SubKey)) );
    
  Result := li = ERROR_SUCCESS;
  if not Result then
    LastError := li;
  if Computer <> '' then
    RegCloseKey(RootKey);
end;

function RegEnum(RootKey: HKEY; Name: String; var ResultList: String; const DoKeys: Boolean; Computer: String = ''): boolean;
var
  i: integer;
  iRes: integer;
  s: String;
  hTemp: HKEY;
  Buf: Pointer;
  BufSize: Cardinal;
begin
  Result := False;
  ResultList := '';
  if Computer <> '' then
  begin
    if RegConnectRegistry(PChar(Computer), RootKey, hTemp) <> ERROR_SUCCESS then
      Exit;
    RootKey := hTemp;
  end;
  if RegOpenKeyEx(RootKey, PChar(Name), 0, KEY_READ or REG_ACCESS_CONST, hTemp) = ERROR_SUCCESS then
  begin
    Result := True;
    BufSize := 1024;
    GetMem(buf, BufSize*8);
    i := 0;
    iRes := ERROR_SUCCESS;
    while iRes = ERROR_SUCCESS do
    begin
      BufSize := 1024;
      if DoKeys then
        iRes := RegEnumKeyEx(hTemp, i, buf, BufSize, nil, nil, nil, nil)
      else
        iRes := RegEnumValue(hTemp, i, buf, BufSize, nil, nil, nil, nil);
      if iRes = ERROR_SUCCESS then
      begin
        SetLength(s, BufSize);
        CopyMemory(@s[1], buf, BufSize);
        if ResultList = '' then
          ResultList := s
        else
          ResultList := Concat(ResultList, #13#10, s);
        inc(i);
      end;
    end;
    FreeMem(buf);
    RegCloseKey(hTemp);
    if Computer <> '' then
      RegCloseKey(RootKey);
  end;
end;

function RegEnumValues(RootKey: HKEY; Name: String; var ValueList: String; Computer: String = ''): boolean;
begin
  Result := RegEnum(RootKey, Name, ValueList, False, Computer);
end;

function RegEnumKeys(RootKey: HKEY; Name: String; var KeyList: String; Computer: String = ''): boolean;
begin
  Result := RegEnum(RootKey, Name, KeyList, True, Computer);
end;

end.
