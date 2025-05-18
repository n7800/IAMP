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
unit uGlobals;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Classes, SysUtils,
  {$IFDEF WINDOWS}Registry, ShellAPI, ComObj, ShlObj, ActiveX, Windows,{$ENDIF}
  mUtils{$IFDEF DARWIN}, CocoaAll{$ENDIF}{$IFDEF LINUX}, INIFiles, BaseUnix{$ENDIF};

function GetSpecialFolderEx(CSIDL: Integer): String;

procedure SniffCompanyProduct(Items, ApplyToItems: TStrings; SniffBase, NewBase: String; var SniffedCompany, SniffedProduct: String);

function ReverseInjectCommand(Path: String): String;

function ReverseInvokePath(Path: String; Double: Boolean): String;

function GetLinkTarget(const LinkFileName: String): TStringList;

procedure PrepareToParse;

function Reparse(Path: String): String;

var
  FileExclude: TStringList;
  DataDir: String;

implementation

var
  t: TextFile;
  s: String;
  Parsee: TStringList;

function Reparse(Path: String): String;
var
  i: Integer;
begin
  Result := ReverseInvokePath(Path, True);
  for i := 1 to Parsee.Count do
    if (i -1) mod 2 = 0 then
    begin
      
      if AnsiPos(Parsee[i -1], Result) = 1 then
      begin
        Delete(Result, 1, Length(Parsee[i -1]));
        Result := Parsee[i] + Result;
      end;
    end;
end;

procedure PrepareToParse;
begin
  Parsee.Clear;
end;

function GetLinkTarget(const LinkFileName: String): TStringList;
{$IFDEF WINDOWS}
var
  i: Integer;
  psl: IShellLink;
  ppf: IPersistFile;
  WidePath: Array[0..260] of WideChar;
  Info: Array[0..MAX_PATH] of Char;
  wfs: TWin32FindData;
begin
  Result := nil;
  try
    CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER, IShellLink, psl);
    if psl.QueryInterface(IPersistFile, ppf) = 0 then
    begin
      MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, PChar(LinkFileName), -1,
        @WidePath, MAX_PATH);
      ppf.Load(WidePath, STGM_READ);
      Result := TStringList.Create;
      psl.GetPath(@info, MAX_PATH, wfs, SLGP_UNCPRIORITY);
      Result.Add(info);
      psl.GetDescription(@info, MAX_PATH);
      Result.Add(info);
      psl.GetWorkingDirectory(@info, MAX_PATH);
      Result.Add(info);
      psl.GetArguments(@info, MAX_PATH);
      Result.Add(info);
      psl.GetIconLocation(@info, MAX_PATH, i);
      Result.Add(info);
      Result.Add(IntTostr(i));
      for i := 1 to Result.Count do
        Result[i -1] := StringReplace(Result[i -1], '"', '""', [rfReplaceAll, rfIgnoreCase]);
    end
    else
      Result := nil;
  except
  end;
{$ELSE}
{$IFDEF DARWIN}
begin
  Result := nil;
{$ELSE}
var
  s: String;
  i: TINIFile;
begin
  Result := nil;
  i := TINIFile.Create(LinkFileName);
  s := i.ReadString('Desktop Entry', 'Type', '');
  if AnsiCompareText(s, 'Application') = 0 then
  begin
    Result := TStringList.Create;
    s := i.ReadString('Desktop Entry', 'Exec', '');
    Result.Add(s);
    s := i.ReadString('Desktop Entry', 'Comment', '');
    Result.Add(s);
    Result.Add(''); 
    Result.Add(''); 
    s := i.ReadString('Desktop Entry', 'Icon', '');
    Result.Add(s);
    Result.Add('0'); 
    s := i.ReadString('Desktop Entry', 'Name', '');
    Result.Add(s); 
  end;
  i.Free;
{$ENDIF}
{$ENDIF}
end;

procedure SniffCompanyProduct(Items, ApplyToItems: TStrings; SniffBase, NewBase: String; var SniffedCompany, SniffedProduct: String);
var
  i: Integer;
  s, sX: String;
begin
  
  s := '';
  for i := 1 to Items.Count do
    
    if AnsiPos(SniffBase, Items[i -1]) = 1 then
    begin
      s := Items[i -1];
      Break;
    end;
  
  if s <> '' then
  begin
    Delete(s, 1, Length(SniffBase) +1);
    repeat
      
      {$IFDEF WINDOWS}
      SniffedCompany := DeAssertDir(ExtractFilePath(s)); 
      SniffedProduct := ExtractFileName(s); 
      s := DeAssertDir(ExtractFilePath(s)); 
      {$ELSE}
      SniffedProduct := ExtractFileName(s); 
      SniffedCompany := '';
      {$ENDIF}
    until ExtractFilePath(s) = '';
    if SniffedCompany <> '' then
      s := SniffBase + PathDelim + SniffedCompany + PathDelim + SniffedProduct
    else
      s := SniffBase + PathDelim + SniffedProduct;
    
    if NewBase <> '' then
      for i := 1 to ApplyToItems.Count do
        if AnsiPos(s, ApplyToItems[i -1]) = 1 then
        begin
          sX := ApplyToItems[i -1];
          Delete(sX, 1, Length(s) +1);
          ApplyToItems[i -1] := NewBase + PathDelim + sX;
          Parsee.Add(s);
          Parsee.Add(NewBase);
        end;
  end
  else
  
  begin
    SniffedCompany := '';
    SniffedProduct := '';
  end;
end;

{$IFDEF WINDOWS}
function GetWWWRootPathEx: String;
var
  r: TRegistry;
begin
  Result := '';
  r := TRegistry.Create;
  r.Access := KEY_READ;
  r.RootKey := HKEY_LOCAL_MACHINE;
  
  if r.OpenKeyReadOnly('SOFTWARE\Microsoft\InetStp') then
  begin
    try
      Result := r.ReadString('PathWWWRoot');
    except
      Result := '';
    end;
    r.CloseKey;
  end;
  
  if Result = '' then
    if r.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots\') then
    begin
      try
        Result := r.ReadString('/');
      except
        Result := '';
      end;
      
      if AnsiPos(',', Result) <> 0 then
        Delete(Result, AnsiPos(',', Result), Length(Result));
      if Result = '' then
      begin
        try
          Result := r.ReadString('/,');
        except
          Result := '';
        end;
        
        if AnsiPos(',', Result) <> 0 then
          Delete(Result, AnsiPos(',', Result), Length(Result));
      end;
      r.CloseKey;
    end;
  
  r.Free;
end;

function GetQuickLaunchPathEx: String;
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  r.Access := KEY_READ;
  r.RootKey := HKEY_CURRENT_USER;
  if r.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\') then
  begin
    try
      Result := r.ReadString('AppData');
      if Result <> '' then
        Result := AssertDir(Result) + 'Microsoft\Internet Explorer\Quick Launch\';
    except
      Result := '';
    end;
  end;
  r.CloseKey;
  r.Free;
end;
{$ENDIF}

function GetSystemPathEx: String;
var
  p: PChar;
  s: String;
begin
  {$IFDEF WINDOWS}
  GetMem(p, MAX_PATH);
  GetSystemDirectory(p, MAX_PATH);
  Result := AssertDir(p);
  FreeMem(p);
  {$ELSE}
  {$IFDEF DARWIN}
  s := GetSignificantDir(NSLibraryDirectory, NSSystemDomainMask, 0);
  if s <> '' then
    s := IncludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(s)));
  {$ELSE}
  s := '/usr/lib/';
  {$ENDIF}
  if s <> '' then
    s := IncludeTrailingPathDelimiter(s);
  {$ENDIF}
end;

function GetWindowsPathEx: String;
var
  p: PChar;
begin
  {$IFDEF WINDOWS}
  GetMem(p, MAX_PATH);
  GetWindowsDirectory(p, MAX_PATH);
  Result := AssertDir(p);
  FreeMem(p);
  {$ELSE}
  {$IFDEF LINUX}
  Result := '/lib/';
  {$ELSE}
  
  Result := '';
  {$ENDIF}
  {$ENDIF}
end;

function GetTempPathEx: String;
var
  p: PChar;
begin
  {$IFDEF WINDOWS}
  GetMem(p, MAX_PATH);
  GetTempPath(MAX_PATH, p);
  Result := AssertDir(p);
  FreeMem(p);
  {$ELSE}
  Result := MyGetTempPathEx;
  {$ENDIF}
end;

function GetCDROMPathEx: String;
var
  c: Char;
begin
  Result := '';
  {$IFDEF WINDOWS}
  for c := 'A' to 'Z' do
    if GetDriveType(PChar(String(c + ':'))) = DRIVE_CDROM then
    begin
      Result := c + ':\';
      Exit;
    end;
  {$ENDIF}
  
end;

function GetSpecialFolderEx(CSIDL: Integer): String;
begin
  GetSpecialFolder(CSIDL, Result);
  {$IFDEF LINUX}
  if FpGetEUID = 0 then
    if CSIDL = $28 then
     Result := ParamStr(ParamCount); 
  {$ENDIF}
  Result := AssertDir(Result);
end;

function ReverseInjectCommand(Path: String): String;
var
  i: Integer;
  l: TStringList;
begin
  Result := '';
  l := TStringList.Create;
  
  l.Add('$INETCACHE$');
  l.Add('"0","FALSE"');
  l.Add('$INETCOOKIES$');
  l.Add('"1","FALSE"');
  
  l.Add('$TEMPLATES$');
  l.Add('"24","FALSE"');
  l.Add('$WINSYSDIR$');
  l.Add('"23","FALSE"');
  l.Add('$WINDIR$');
  l.Add('"25","FALSE"');
  l.Add('$SENDTO$');
  l.Add('"22","FALSE"');
  l.Add('$RECENTFILES$');
  l.Add('"21","FALSE"');
  
  l.Add('$PROFILESME$');
  l.Add('"19","FALSE"');
  l.Add('$PROFILESALL$');
  l.Add('"19","TRUE"');
  l.Add('$FONTS$');
  l.Add('"18","FALSE"');
  l.Add('$DESKTOPDIR$');
  l.Add('"17","FALSE"');
  l.Add('$DESKTOPALL$');
  l.Add('"17","TRUE"');
  l.Add('$CDBURN$');
  l.Add('"16","FALSE"');
  l.Add('$APPDATAME$');
  l.Add('"15","FALSE"');
  l.Add('$APPDATAALL$');
  l.Add('"15","TRUE"');
  
  l.Add('$STARTMENUALL$'); 
  l.Add('"14","TRUE"'); 
  l.Add('$STARTUPME$');
  l.Add('"13","FALSE"');
  l.Add('$STARTUPALL$');
  l.Add('"13","TRUE"');
  l.Add('$STARTMENU$');
  l.Add('"12","FALSE"');
  l.Add('$STARTMENUALL$');
  l.Add('"12","TRUE"');
  l.Add('$STARTADMINME$');
  l.Add('"11","FALSE"');
  l.Add('$STARTADMINALL$');
  l.Add('"11","TRUE"');
  l.Add('$CDPATH$');
  l.Add('"10","FALSE"');
  l.Add('$BOOTPATH$');
  l.Add('"9","FALSE"');
  l.Add('$NETHOOD$');
  l.Add('"7","FALSE"');
  l.Add('$PRINTHOOD$');
  l.Add('"8","FALSE"');
  l.Add('$MYVIDEOS$');
  l.Add('"6","FALSE"');
  l.Add('$ALLVIDEOS$');
  l.Add('"6","FALSE"');
  l.Add('$MYPICTURES$');
  l.Add('"5","FALSE"');
  l.Add('$ALLPICTURES$');
  l.Add('"5","TRUE"');
  l.Add('$MYMUSIC$');
  l.Add('"4","FALSE"');
  l.Add('$ALLMUSIC$');
  l.Add('"4","TRUE"');
  l.Add('$MYFAVORITES$');
  l.Add('"3","FALSE"');
  l.Add('$ALLFAVORITES$');
  l.Add('"3","TRUE"');
  l.Add('$MYDOCUMENTS$');
  l.Add('"2","FALSE"');
  for i := 1 to l.Count do
    if (i -1) mod 2 = 0 then
      
      if AnsiPos(l[i -1], Path) = 1 then
      begin
        Result := '"' + l[i -1] + '",' + l[i];
        Result := StringReplace(Result, '$', '', [rfReplaceAll, rfIgnoreCase]);
        Break;
      end;
end;

function ReverseInvokePath(Path: String; Double: Boolean): String;
var
  i, j, k: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  
  l.Add('$INETCACHE$');
  l.Add(GetSpecialFolderEx($20));
  l.Add('$INETCOOKIES$');
  l.Add(GetSpecialFolderEx($21));
  {$IFDEF WINDOWS}
  l.Add('$WWWROOTDIR$');
  l.Add(GetWWWRootPathEx);
  l.Add('$QUICKLAUNCHDIR$');
  l.Add(GetQuickLaunchPathEx);
  {$ENDIF}
  l.Add('$TEMPLATES$');
  l.Add(GetSpecialFolderEx($15));
  l.Add('$TEMPDIR$');
  l.Add(GetTempPathEx);
  l.Add('$WINSYSDIR$');
  l.Add(GetSystemPathEx);
  l.Add('$WINDIR$');
  l.Add(GetWindowsPathEx);
  l.Add('$SENDTO$');
  l.Add(GetSpecialFolderEx($9));
  l.Add('$RECENTFILES$');
  l.Add(GetSpecialFolderEx($8));
  l.Add('$COMMONFILES$');
  l.Add(GetSpecialFolderEx($2b));
  l.Add('$PROGRAMFILES$');
  l.Add(GetSpecialFolderEx($26));
  l.Add('$PROFILESME$');
  l.Add(GetSpecialFolderEx($28));
  l.Add('$PROFILESALL$');
  l.Add(GetSpecialFolderEx($3e));
  l.Add('$FONTS$');
  l.Add(GetSpecialFolderEx($14));
  l.Add('$DESKTOPDIR$');
  l.Add(GetSpecialFolderEx($0));
  l.Add('$DESKTOPALL$');
  l.Add(GetSpecialFolderEx($19));
  l.Add('$CDBURN$');
  l.Add(GetSpecialFolderEx($3b));
  l.Add('$APPDATAME$');
  l.Add(GetSpecialFolderEx($1a));
  l.Add('$APPDATAALL$');
  l.Add(GetSpecialFolderEx($23));
  l.Add('$STARTMENU$');
  l.Add(GetSpecialFolderEx($2));
  l.Add('$STARTMENUALL$');
  l.Add(GetSpecialFolderEx($17));
  l.Add('$STARTUPME$');
  l.Add(GetSpecialFolderEx($7));
  l.Add('$STARTUPALL$');
  l.Add(GetSpecialFolderEx($18));
  l.Add('$STARTMENU$');
  l.Add(GetSpecialFolderEx($b));
  l.Add('$STARTMENUALL$');
  l.Add(GetSpecialFolderEx($16));
  l.Add('$STARTADMINME$');
  l.Add(GetSpecialFolderEx($30));
  l.Add('$STARTADMINALL$');
  l.Add(GetSpecialFolderEx($2f));
  l.Add('$CDPATH$');
  l.Add(GetCDROMPathEx);
  l.Add('$BOOTPATH$');
  l.Add(GetBootPath);
  l.Add('$NETHOOD$');
  l.Add(GetSpecialFolderEx($13));
  l.Add('$PRINTHOOD$');
  l.Add(GetSpecialFolderEx($1b));
  l.Add('$MYVIDEOS$');
  l.Add(GetSpecialFolderEx($e));
  l.Add('$ALLVIDEOS$');
  l.Add(GetSpecialFolderEx($37));
  l.Add('$MYPICTURES$');
  l.Add(GetSpecialFolderEx($27));
  l.Add('$ALLPICTURES$');
  l.Add(GetSpecialFolderEx($36));
  l.Add('$MYMUSIC$');
  l.Add(GetSpecialFolderEx($d));
  l.Add('$ALLMUSIC$');
  l.Add(GetSpecialFolderEx($35));
  l.Add('$MYFAVORITES$');
  l.Add(GetSpecialFolderEx($6));
  l.Add('$ALLFAVORITES$');
  l.Add(GetSpecialFolderEx($1f));
  l.Add('$MYDOCUMENTS$');
  l.Add(GetSpecialFolderEx($5));
  if Double then
  begin
    Result := Path;
    for i := 1 to l.Count do
      if (i -1) mod 2 = 0 then
        Result := StringReplace(Result, DeAssertDir(l[i]), l[i -1], [rfReplaceAll, rfIgnoreCase]);
    Exit;
  end;
  j := -1; 
  k := 0; 
  for i := 1 to l.Count do
    if (i mod 2) = 1 then
      
      if AnsiPos(l[i], Path) = 1 then
        if Length(l[i]) > k then 
        begin
          k := Length(l[i]);
          j := i;
        end;
  Result := Path;
  if j <> -1 then
  begin
    Delete(Result, 1, k);
    Result := l[j -1] + PathDelim + Result;
  end;
  l.Free;
end;

initialization
  Parsee := TStringList.Create;

  DataDir := MyGetAppConfigDir(false) + 'PackageAware' + PathDelim;
  ForceDirectories(DataDir);

  FileExclude := TStringList.Create;

  if MyFileExists(DataDir + 'fileexclude.txt') then
    FileExclude.LoadFromFile(DataDir + 'fileexclude.txt')
  else
  begin
    {$IFDEF WINDOWS}
    FileExclude.Add('*\local settings\temp');
    FileExclude.Add('*\local settings\temporary internet files');
    FileExclude.Add('*\local settings\history');
    FileExclude.Add('*\cookies');
    FileExclude.Add('*\recycled');
    FileExclude.Add('*\recycler');
    FileExclude.Add('*\packageaware');
    FileExclude.Add('pagefile.sys');
    FileExclude.Add('hiberfil.sys');
    {$ELSE}
    
    FileExclude.Add('*/PackageAware');
    {$IFDEF DARWIN}
    FileExclude.Add('/Volumes/'); 
    FileExclude.Add('/System/');
    FileExclude.Add('/bin/');
    FileExclude.Add('/sbin/');
    FileExclude.Add('*/Library/Containers/com.apple.quicklook.ui.helper/Data');
    
    {$ELSE}
    FileExclude.Add('/media/');
    FileExclude.Add('/mnt/');
    FileExclude.Add('/proc/');
    FileExclude.Add('/sys/');
    FileExclude.Add('/run/');
    {$ENDIF}
    FileExclude.Add('/dev/');
    FileExclude.Add('/tmp/');
    {$ENDIF}
  end;

finalization
  try
    FreeAndNil(Parsee);
    FreeAndNil(FileExclude);
  except
    
  end;

end.
