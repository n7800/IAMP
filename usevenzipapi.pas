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
unit uSevenZIPAPI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mtpcpu, mUtils, Types;

type
  TPasswordCallback = function(lpPassword: PCHAR): Integer; stdcall;

  TOverwriteCallback = function(lpArchiveFileName, lpDiskExistingFileName: PCHAR;
    uiArchiveFileSize, uiDiskExistingFileSize: Int64; ftArchiveFileLastWrite,
    ftDiskExistingFileLastWrite: TFILETIME): Integer; stdcall;

  TProgressCallback = function(lpCurrentFileName: PCHAR; uiCompleted,
    uiTotal: Int64): Integer; stdcall;

  TErrorCallback = function(lpCurrentFileName: PCHAR; dwErrorCode: LongWord): Integer; stdcall;

procedure SetArchivePath; 
procedure SetArchivePathEx; 

function CompressArchiveContents(Archive, Password, Options: String; Kind, Path: Integer;
  var Error: String; Items, Recursive: TStrings; Progress: TProgressCallback;
  ErrorBack: TErrorCallback): Boolean;

function ExtractArchiveContents(Archive, Password, Folder: String; WithPath,
  Overwrite: Boolean; var Error: String; Items: TStrings; Progress: TProgressCallback;
  OverwriteBack: TOverwriteCallback; ErrorBack: TErrorCallback; PasswordBack: TPasswordCallback): Boolean;

function GetOptionsString(Factor: String; HeaderEnc: Boolean; NoShim: Boolean = false): String;
function ReverseGetOptionsString(Textual: String): String;

implementation

var
  ShimPath: String;

procedure SetArchivePath;
begin
  {$IFNDEF INTEROP}
  {$IFDEF LINUX}
  ShimPath := EXEDIR + 'linux/miax.lib';
  {$ELSE}
  {$IFDEF DARWIN}
  ShimPath := EXEDIR + 'macos/miax.lib';
  {$ELSE}
  ShimPath := EXEDIR + 'windows\miax.lib';
  {$ENDIF}
  {$ENDIF}
  {$ELSE}
  ShimPath := EXEDIR + 'miax.lib';
  {$ENDIF}
end;

procedure SetArchivePathEx;
begin
  ShimPath := EXEDIR + 'miaxex.lib'; 
end;

function CompressArchiveContents(Archive, Password, Options: String; Kind, Path: Integer;
  var Error: String; Items, Recursive: TStrings; Progress: TProgressCallback;
  ErrorBack: TErrorCallback): Boolean;
var
  s: String;
  i: Integer;
  t: TextFile;
  sl: TStringList;
begin
  Result := false;
  sl := TStringList.Create;
  sl.Add('a');
  
  if Password <> '' then
    sl.Add('-p' + Password);
  
  if TryStrToInt(Options, i) then
    sl.Add('-mx' + Options) 
  else
    sl.Add('-mx' + ReverseGetOptionsString(Options)); 
  sl.Add(Archive);
  if Assigned(Items) then
    if Items.Count > 0 then
    begin
      s := EXEDIR + MyCreateGUID;
      AssignFile(t, s);
      ReWrite(t);
      for i := 1 to Items.Count do
        WriteLn(t, Items[i -1]);
        
      CloseFile(t);
      sl.Add('@' + s);
      Result := LaunchAppAndWait2(ShimPath, sl, True, True) = 0;
      Erase(t);
      if not Result then
      begin
        sl.Free;
        Exit;
      end;
    end;
  
  if Assigned(Recursive) then
    if Recursive.Count > 0 then
    begin
      sl.Clear;
      sl.Add('a');
      if Password <> '' then
        sl.Add('-p' + Password);
      if TryStrToInt(Options, i) then
        sl.Add('-mx' + Options) 
      else
        sl.Add('-mx' + ReverseGetOptionsString(Options)); 
      sl.Add(Archive);
      sl.Add('-r');
      s := EXEDIR + MyCreateGUID;
      AssignFile(t, s);
      ReWrite(t);
      for i := 1 to Recursive.Count do
        
        WriteLn(t, Recursive[i -1]);
      CloseFile(t);
      sl.Add('@' + s);
      Result := LaunchAppAndWait2(ShimPath, sl, True, True) = 0;
      Erase(t);
    end;
  
  sl.Free;
end;

function ExtractArchiveContents(Archive, Password, Folder: String; WithPath,
  Overwrite: Boolean; var Error: String; Items: TStrings;
  Progress: TProgressCallback; OverwriteBack: TOverwriteCallback;
  ErrorBack: TErrorCallback; PasswordBack: TPasswordCallback): Boolean;
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  if WithPath then
    sl.Add('x')
  else
    sl.Add('e');
  
  if Password <> '' then
    sl.Add('-p' + Password);
  sl.Add(Archive);
  sl.Add('-o' + Folder);
  if Overwrite then
    sl.Add('-aoa')
  else
    sl.Add('-aos');
  
  Result := LaunchAppAndWait2(ShimPath, sl, false, True) = 0;
  sl.Add(ShimPath);
  
  sl.Free;
end;

function GetOptionsString(Factor: String; HeaderEnc: Boolean; NoShim: Boolean = false): String;
var
  stc: Integer;
begin
  
  if not NoShim then
    begin
    if Factor <> '0' then
    try
      Result := IntToStr(StrToInt(Factor) +1);
    except
      Result := '6';
    end
    else
      Result := Factor;
    Exit;
  end;
  
  stc := GetSystemThreadCount;
  if Factor = '0' then
    Result := '-ms=off -mhc=off -m0=None -m0=Copy ' 
  else
  if Factor = '1' then
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=23 -m1mf=hc4 -m1fb=64 ' 
  else
  if Factor = '2' then
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=23 -m1mf=bt4 -m1fb=64 ' 
  else
  if Factor = '3' then
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=25 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 ' 
  else
  if Factor = '4' then
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 ' 
  else
  if Factor = '5' then
  begin
    {$IFNDEF INTEROP}
    if Is64Bit then
      Result := '-mqs -mx -mf=bcj2 -md1024m -mmt2 -ms1t'
      
    else
      Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ELSE}
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ENDIF}
  end
  else
  if Factor = '6' then
  begin
    {$IFNDEF INTEROP}
    if Is64Bit then
      Result := '-mqs -mx -myx -md1024m -mmt2 -ms1t'
      
    else
      Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ELSE}
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ENDIF}
  end
  else
  if Factor = '7' then
  begin
    {$IFNDEF INTEROP}
    if Is64Bit then
      Result := '-mqs -mx -mf=bcj2 -md1536m -mmt2 -ms1t'
    else
      Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ELSE}
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ENDIF}
  end
  else
  if Factor = '8' then
  begin
    {$IFNDEF INTEROP}
    if Is64Bit then
      Result := '-mqs -mx -myx -md1536m -mmt2 -ms1t'
    else
      Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ELSE}
    Result := '-ms=on -mhc=on -m0=BCJ2 -m1=LZMA2 -m1d=26 -m1mf=bt4 -m1fb=64 -m2=LZMA2 -m2d=20 -m2mf=bt4 -m2fb=64 -m3=LZMA2 -m3d=20 -m3mf=bt4 -m3fb=64 -mb0:1 -mb0s1:2 -mb0s2:3 '; 
    {$ENDIF}
  end
  else
  begin
    Result := GetOptionsString('4', HeaderEnc); 
    Exit; 
  end;
  
  if stc > 1 then
  begin
    if ((AnsiPos('-m1d=26', Result) <> 0) or (AnsiPos('-md1536m', Result) <> 0)) or ((AnsiPos('-md1024m', Result) <> 0) or ((AnsiPos('-m1d=30', Result) <> 0) or (AnsiPos('-m1d=29', Result) <> 0))) then
      Result := '-mmt=2 ' + Result 
    else
    if AnsiPos('-m1d=25', Result) <> 0 then
    begin
      if stc >= 3 then
        Result := '-mmt=3 ' + Result
      else
        Result := '-mmt=' + IntToStr(stc) + ' ' + Result; 
    end
    else
      Result := '-mmt=' + IntToStr(stc) + ' ' + Result; 
  end
  else
    Result := '-mmt=off ' + Result; 
  if HeaderEnc then
    Result := '-mhe=on ' + Result 
  else
    Result := '-mhe=off ' + Result; 
  
  Result:= '-ssw '+ Result;
end;

function ReverseGetOptionsString(Textual: String): String;
var
  i: Integer;
begin
  for i := 0 to 8 do
    if (AnsiCompareText(GetOptionsString(IntToStr(i), True, True), Textual) = 0) or
      (AnsiCompareText(GetOptionsString(IntToStr(i), false, True), Textual) = 0) then
    begin
      Result := IntToStr(i);
      Exit;
    end;
  Result := '5'; 
end;

initialization
  SetArchivePath;

end.
