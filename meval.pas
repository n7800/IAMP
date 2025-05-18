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
unit mEval;

{$MODE Delphi}

interface

uses
  SysUtils;

function TestSyntax(Text: String): Boolean;
function Eval(Text: String): String;
procedure skipSpace(var Text: String);
function evalOP(var Text: String): Integer;
function evalNextPart(var Text: String): Integer;
function EvalEx(var Text: String): Integer;
function cutString(var Text: String): String;

implementation

function cutString(var Text: String): String;
var
  str: String;
  i: Integer;
begin
  if Length(Text) < 1 then
  begin
    Result := '';
    Exit;
  end;
  if Text[1] <> '"' then
  begin
    Result := '';
    Exit;
  end;
  for i := 1 to Length(Text) -1 do
  begin
    if Text[i +1] = '"' then
    begin
      if Text[i +1 +1] <> '"' then
      begin
        Delete(Text, 1, i +1);
        Break;
      end
      else str := str + '"'
    end
    else str := str + Text[i +1];
  end;
  Result := str;
end;

function TestSyntax(Text: String): Boolean;
var
  Logging: String;
begin
  Text := StringReplace(Text, '$', '"', [rfReplaceAll, rfIgnoreCase]);
  Result := Eval(Text) <> 'ERROR'; 
end;

function Eval(Text: String): String;
var
  i: Integer;
begin
  Text := '(' + Text + ')';
  i := EvalEx(Text);
  if i = 1 then
    Result := 'TRUE'; 
  if i = 0 then
    Result := 'FALSE'; 
  if Length(Text) > 0 then
    Result := 'ERROR'; 
end;

procedure skipSpace(var Text: String);
begin
  while (Length(Text) > 0) and (Text[1] = ' ') do
    Delete(Text, 1, 1);
end;

function IsInteger(Str: String) : boolean;
var 
  I, L: Integer;
begin 
  Result := False; 
  L := Length(Str); 
  if L = 0 then 
    
    Exit; 
  if L > 1 then
    
    if not (Str[1] in ['+', '-', '0'..'9']) then
      Exit
    else
  else
    
    if not (Str[1] in ['0'..'9']) then
      Exit;
  for I := 2 to length(Str) do
    
    if not (Str[I] in ['0'..'9']) then
      Exit;
  Result := True;
end;

function evalOP(var Text: String): Integer;
var
  left, op, right: String;
  leftint, rightint : Int64;
  isInt : Boolean;
begin
  skipSpace(Text);
  if Length(Text) < 1 then
  begin
    Result := -1;
    Exit;
  end;
  if Text[1] <> '"' then
  begin
    Result := -1;
    Exit;
  end;
  left := cutString(Text);
  skipSpace(Text);
  op := '';
  while (Length(Text) > 0) and ((Text[1] <> '"') and (Text[1] <> ' ')) do
  begin
    op := op + Text[1];
    Delete(Text, 1, 1);
  end;
  skipSpace(Text);
  if Length(Text) < 1 then
  begin
    Result := -1;
    Exit;
  end;
  if Text[1] <> '"' then
  begin
    Result := -1;
    Exit;
  end;
  right := cutString(Text);
  skipSpace(Text);

  if IsInteger(left) and IsInteger(right) then
  begin
    isInt := true;
    leftInt := StrToInt(left);
    rightInt := StrToInt(right);
  end
  else
  begin
    isInt := false;
    leftInt := 0;
    rightInt := 0;
  end;

  if op = '=' then
  begin
    if isInt then
    begin
      if leftInt = rightInt then
        Result := 1
      else
        Result := 0;
    end
    else
    begin
      if left = right then
        Result := 1
       else
        Result := 0;
    end;
    Exit;
  end;
  if op = '<>' then
  begin
      if isInt then
    begin
      if leftInt <> rightInt then
        Result := 1
      else
        Result := 0;
    end
    else
    begin
      if left <> right then
        Result := 1
      else
        Result := 0;
    end;
    Exit;
  end;
  if op = '<=' then
  begin
      if isInt then
    begin
      if leftInt <= rightInt then
        Result := 1
      else
        Result := 0;
    end
    else
    begin
      if left <= right then
        Result := 1
      else
        Result := 0;
    end;
    Exit;
  end;
  if op = '<' then
  begin
    if isInt then
    begin
      if leftInt < rightInt then
        Result := 1
      else
        Result := 0;
    end
    else
    begin
      if left < right then
        Result := 1
      else
        Result := 0;
    end;
    Exit;
  end;
  if op = '>=' then
  begin
    if isInt then
    begin
      if leftInt >= rightInt then
        Result := 1
      else
        Result := 0;
    end
    else
    begin
      if left >= right then 
        Result := 1
      else 
        Result := 0;
    end;
    Exit;
  end;
  if op = '>' then
  begin
    if isInt then
    begin
      if leftInt > rightInt then
        Result := 1
      else
        Result := 0;
    end
    else
    begin
      if left > right then
        Result := 1
      else 
        Result := 0;
    end;
    Exit;
  end;
  Result := -1;
end;

function evalNextPart(var Text: String): Integer;
var
  rc: Integer;
begin
  skipSpace(Text);
  if Length(Text) < 1 then
  begin
    Result := -1;
    Exit;
  end;
  if Text[1] = '(' then
  begin
    Delete(Text, 1, 1);
    rc := EvalEx(Text);
    skipSpace(Text);
    if Length(Text) < 1 then
    begin
      Result := -1;
      Exit;
    end;
    if Text[1] <> ')' then
    begin
      Result := -1;
      Exit;
    end;
    Delete(Text, 1, 1);
    Result := rc;
  end
  else
  begin
    if Length(Text) < 1 then
    begin
      Result := -1;
      Exit;
    end;
    if Text[1] = '"' then
      Result := evalOP(Text)
    else
      Result := -1;
  end;
end;

function EvalEx(var Text: String): Integer;
var
  op: String;
  rc1, rc2: Integer;
begin
  rc1 := evalNextPart(Text);
  if rc1 = -1 then
  begin
    Result := -1;
    Exit;
  end;
  while Length(Text) > 0 do
  begin
    skipSpace(Text);
    if (Length(Text) = 0) or (Text[1] = ')') then Break;
    op := '';
    while (Length(Text) > 0) and ((Text[1] <> '"') and (Text[1] <> ' ')) do
    begin
      op := op + Text[1];
      Delete(Text, 1, 1);
    end;
    rc2 := evalNextPart(Text);
    if rc2 = -1 then
    begin
      Result := -1;
      Exit;
    end;
    if op = 'and' then 
    begin
      if (rc1 = rc2) and (rc1 = 1) then
        rc1 := 1
      else
        rc1 := 0;
    end
    else
      if op = 'or' then 
      begin
        if (rc1 = 1) or (rc2 = 1) then
          rc1 := 1
        else
          rc1 := 0;
      end
      else
      begin
        Result := -1;
        Exit;
      end;
  end;
  Result := rc1;
end;

end.

