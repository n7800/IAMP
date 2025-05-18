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
unit DACLUtils;

interface

uses
  Windows, Types, SysUtils, Classes, DaclAPI;

const
  GENERIC_EXECUTE          = $20000000;
  _DELETE                  = $00010000; 
  READ_CONTROL             = $00020000;

  PRINTER_ACCESS_ADMINISTER   = $00000004;
  PRINTER_ACCESS_USE          = $00000008;
  PRINTER_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or
    PRINTER_ACCESS_ADMINISTER or PRINTER_ACCESS_USE);
  PRINTER_READ = (STANDARD_RIGHTS_READ or PRINTER_ACCESS_USE);
  PRINTER_WRITE = (STANDARD_RIGHTS_WRITE or PRINTER_ACCESS_USE);
  PRINTER_EXECUTE = (STANDARD_RIGHTS_EXECUTE or PRINTER_ACCESS_USE);

type
  TSecurityObjectType = SE_OBJECT_TYPE;

  TGrantAccess = (gaAllow, gaDenied);

  TPermissionType = (ptRead, ptWrite, ptExecute, ptAll);
  TPermissions = set of TPermissionType;

  TSecInfo = record
    sid: PSID;
    computer, name: string;
    need_release: Boolean;
  end;

  TSecurityObject = class
  private
    FobjectType: TSecurityObjectType;
    FobjectName: string;
    FSecInfos: array of TSecInfo;
    FCount: Integer;
    FWriteInfo: DWORD;
    FDacl, FNewDACL: PACL;
    FSecDescriptor: PSECURITY_DESCRIPTOR;
    function GetOwner: string;
    procedure SetOwner(const Value: string);
    procedure ReadACL;
    procedure WriteACL;
    procedure clearDacls;
    function GetOrCreateIndexName(const computer, name: string): Integer;
    procedure DeleteAllACE;
  public
    class function GetSidByName(const computer, name: string): PSID;
    class function GetNameBySid(const computer: string; sid: PSID): string;
  public
    constructor Create(const objectName: string); overload;
    constructor Create(const objectName: string; objectType: TSecurityObjectType); overload;
    destructor Destroy; override;
    property ObjectType: TSecurityObjectType read FobjectType;

    procedure Apply;
    procedure SetAccess(const computer, user: string; GrantAccess, DenyAccess, ACEFlags: DWORD); 

    procedure DeletePermissions(const computer, user: string); overload;
    procedure DeletePermissions; overload;
    property Owner: string read GetOwner write SetOwner;
  end;

  TSuccessorSecurityObject = class abstract(TSecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; virtual; abstract;
    class function PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): DWORD; virtual; abstract;
  public
    constructor Create(const objectName: string); virtual;
    procedure SetAccess(const computer, user: string; AGrant, ADeny: TPermissions;
      ContainerInheri, ObjectInherit, InheritOnly, NoPropagateInherit: Boolean); overload; virtual;
    procedure SetAccess(const computer, user: string; AGrant, ADeny: TPermissions); overload;

    procedure GrantAccessAll(const computer, user: string);
    procedure DanyAccessAll(const computer, user: string);
  end;

  TFileSecurityObject = class(TSuccessorSecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; override;
    class function PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): DWORD; override;
  end;

  TDirecotrySecurityObject = class(TFileSecurityObject)
  end;

  TRegistrySecurityObject = class(TDirecotrySecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; override;
    class function PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): DWORD; override;
  end;

  TRegistryWow64Key32SecurityObject = class(TRegistrySecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; override;
  end;

  TRegistryWow64Key64SecurityObject = class(TRegistrySecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; override;
  end;

  TShareSecurityObject = class(TDirecotrySecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; override;
    class function PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): Cardinal; override;
  end;

  TServiceSecurityObject = class(TFileSecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; override;
    class function PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): Cardinal; override;
  end;

  TPrinterSecurityObject = class(TFileSecurityObject)
  protected
    class function GetObjectType: TSecurityObjectType; override;
    class function PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): Cardinal; override;
  end;

function GetWorldSidName: string;
function GetAuthenticatedUsersName: string;
function IsWow64CurrentProcess: boolean;

function ConvertSidToStringSid(Sid: PSID; var StringSid: LPWSTR): BOOL; stdcall; external advapi32 name 'ConvertSidToStringSidW';

function GetProcessSid(ProcessHandle: THandle; var sid: PSID; var PointerToFree: Pointer): Boolean;
function SIDToString(sid: PSID): string;

function ValidateRegistryName(const s: string): string;

procedure SplitUserAndComputer(const FullUserName: string; var UserName, Computer: string);

implementation

uses StrUtils;

function OSCheck(RetVal: BOOL): BOOL;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  Result := Win32Check(RetVal);
  {$WARN SYMBOL_PLATFORM ON}
end;

function SIDToString(sid: PSID): string;
var
  p: LPWSTR;
begin
  Result:='';
  if ConvertSidToStringSid(sid, p) then
  begin
    Result := p;
    LocalFree(hLocal(p));
  end;
end;

function GetWorldSidName: string;
const
  SECURITY_WORLD_SID_AUTHORITY: TSidIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 1));
  SECURITY_WORLD_RID                = $00000000;
var
  sid: PSID;
begin
  sid := nil;
  OSCheck(AllocateAndInitializeSid(SECURITY_WORLD_SID_AUTHORITY, 1, SECURITY_WORLD_RID, 0, 0, 0, 0, 0, 0, 0, sid));
  try
    Result := TSecurityObject.GetNameBySid('', sid);
  finally
    FreeSid(sid);
  end;
end;

function GetAuthenticatedUsersName: string;
const
  SECURITY_NT_AUTHORITY: TSidIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_AUTHENTICATED_USER_RID     = $0000000B;
var
  sid: PSID;
begin
  sid := nil;
  OSCheck(AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 1, SECURITY_AUTHENTICATED_USER_RID, 0, 0, 0, 0, 0, 0, 0, sid));
  try
    Result := TSecurityObject.GetNameBySid('', sid);
  finally
    FreeSid(sid);
  end;
end;

function IsWow64CurrentProcess: Boolean;
var
  IsWow64: BOOL;
begin
  Result := IsWow64Process(GetCurrentProcess, @IsWow64) and IsWow64;
end;

function GetProcessSid(ProcessHandle: THandle; var sid: PSID; var PointerToFree: Pointer): Boolean;
var
  token: THandle;
  size: dword;
  user: PTokenUser;
begin
  Result := False;
  if OpenProcessToken(ProcessHandle, TOKEN_QUERY, token) then
  begin
    GetTokenInformation(token, TokenUser, nil, 0, size);
    GetMem(user, size);
    if GetTokenInformation(token, TokenUser, user, size, size) then
    begin
      Result := true;
      sid := user^.User.Sid;
      PointerToFree := user;
    end
    else
      FreeMem(user);
    CloseHandle(token);
  end;
end;

procedure TSecurityObject.Apply;
begin
  WriteACL;
end;

procedure TSecurityObject.clearDacls;
begin
  if Assigned(FSecDescriptor) then
    LocalFree(hLocal(FSecDescriptor));
  FSecDescriptor := nil;
  FDacl := nil;
  if Assigned(FNewDACL) then
  begin
    FreeMem(FNewDACL);
    FNewDACL := nil;
  end;
  FWriteInfo := 0;
end;

constructor TSecurityObject.Create(const objectName: string);
begin
  Create(objectName, SE_UNKNOWN_OBJECT_TYPE);
end;

constructor TSecurityObject.Create(const objectName: string; objectType: TSecurityObjectType);
begin
  inherited Create;
  FobjectType := objectType;
  FobjectName := objectName;
  SetLength(FSecInfos, 3);
  FCount := 1;
  ReadACL;
end;

procedure TSecurityObject.DeletePermissions(const computer, user: string);
begin
  SetAccess(computer, user, 0, 0, 0);
end;

procedure TSecurityObject.DeletePermissions;
begin
  if FobjectType = SE_PRINTER then
  begin
    DeleteAllACE;
    Exit;
  end;

  FreeMem(FNewDACL);
  FNewDACL := nil;
  FWriteInfo := FWriteInfo or DACL_SECURITY_INFORMATION;

end;

destructor TSecurityObject.Destroy;
var
  i: Integer;
begin
  for i := 1 to FCount-1 do
  begin
    if FSecInfos[i].sid <> nil then
      FreeMem(FSecInfos[i].sid);
  end;
  clearDacls;
  inherited;
end;

class function TSecurityObject.GetNameBySid(const computer: string; sid: PSID): string;
var
  pcomputer: PChar;
  cbName, cbDomain: DWORD;
  peUse: SID_NAME_USE;
  s: string;
begin
  cbName := 0;
  cbDomain := 0;
  if computer = '' then
    pcomputer := nil
  else
    pcomputer := PChar(computer);

  LookupAccountSid(pcomputer, sid, PChar(Result), cbName, nil, cbDomain, peUse);
  if GetLastError = ERROR_INSUFFICIENT_BUFFER then
  begin
    SetLength(Result, cbName-1);
    if cbName <= 1 then exit;
    SetLength(s, cbDomain);
    OSCheck(LookupAccountSid(pcomputer, sid, PChar(Result), cbName, PChar(s), cbDomain, peUse));
  end else
    Result := SIDToString(sid);
end;

function TSecurityObject.GetOrCreateIndexName(const computer, name: string): Integer;
var
  I: Integer;
begin
  for I := 1 to FCount-1 do
    if (FSecInfos[i].name = name) and (FSecInfos[i].computer = computer) then
      begin
        Result := i;
        exit;
      end;
  Result := FCount;
  inc(FCount);
  if FCount = Length(FSecInfos) then
    SetLength(FSecInfos, FCount + 4);
end;

function TSecurityObject.GetOwner: string;
begin
  if FSecInfos[0].name = '' then
  begin
    FSecInfos[0].name := GetNameBySid(FSecInfos[0].computer, FSecInfos[0].sid);
  end;
  Result := FSecInfos[0].name;
end;

class function TSecurityObject.GetSidByName(const computer, name: string): PSID;
var
  pcomputer: PChar;
  cbSID, cbDomain: DWORD;
  peUse: SID_NAME_USE;
  s: string;
begin
  cbSID := 0;
  cbDomain := 0;
  if computer = '' then
    pcomputer := nil
  else
    pcomputer := PChar(computer);

  LookupAccountName(pcomputer, PChar(name), nil, cbSID, nil, cbDomain, peUse);
  OSCheck(GetLastError = ERROR_INSUFFICIENT_BUFFER);
  GetMem(Result, cbSID);
  try
    SetLength(s, cbDomain);
    OSCheck(LookupAccountName(pcomputer, PChar(name), Result, cbSID, PChar(s), cbDomain, peUse));
  except
    FreeMem(Result);
    raise;
  end;
end;

function AddAccessDeniedAceEx(var pAcl: TACL; dwAceRevision: DWORD;
  ACEFlags: DWORD; AccessMask: DWORD; pSid: PSID): BOOL; stdcall; external advapi32 name 'AddAccessDeniedAceEx';
function AddAccessAllowedAceEx(var pAcl: TACL; dwAceRevision: DWORD;
  AceFlags: DWORD; AccessMask: DWORD; pSid: PSID): BOOL; stdcall; external advapi32 name 'AddAccessAllowedAceEx';

procedure TSecurityObject.SetAccess(const computer, user: string; GrantAccess, DenyAccess, ACEFlags: DWORD);
var
  U, i: Integer;
  szACL: DWORD;
  si: ACL_SIZE_INFORMATION;
  pace: PACCESS_ALLOWED_ACE;
  acl: PACL;
  delete_acl: Boolean;
begin
  U := -1;
  szACL := 0;
  if (computer = '') and (user = '') then
    begin
      GrantAccess := 0;
      DenyAccess := 0;
    end
  else
    begin
      U := GetOrCreateIndexName(computer, user);
      FSecInfos[U].need_release := true;
      FSecInfos[U].sid := GetSidByName(computer, user);
      FSecInfos[U].name := user;
      if GrantAccess <> 0 then Inc(szACL, SizeOf(TACL) + GetLengthSid(FSecInfos[U].sid) + SizeOf(ACCESS_ALLOWED_ACE));
      if DenyAccess <> 0 then Inc(szACL, SizeOf(TACL) + GetLengthSid(FSecInfos[U].sid) + SizeOf(ACCESS_DENIED_ACE));
    end;

  FWriteInfo := FWriteInfo or DACL_SECURITY_INFORMATION;

  if Assigned(FNewDACL) then
    acl := FNewDACL
  else
    acl := FDacl;
  delete_acl := acl = FNewDACL;

  si.AclBytesInUse := 0;
  si.AceCount := 0;
  if Assigned(acl) then
    OSCheck(GetAclInformation(acl,  @si, sizeof(si), AclSizeInformation));
  szACL := si.AclBytesInUse + szACL;
  GetMem(FNewDACL, szACL);
  try
    ZeroMemory(FNewDACL, szACL);
    OSCheck(InitializeAcl(Fnewdacl^, szACL, ACL_REVISION));

    if DenyAccess <> 0 then
    begin
      if ACEFlags <> 0 then
        OSCheck(AddAccessDeniedAceEx(Fnewdacl^, ACL_REVISION, ACEFlags, DenyAccess, FSecInfos[U].sid))
      else
        OSCheck(AddAccessDeniedAce(Fnewdacl, ACL_REVISION, DenyAccess, FSecInfos[U].sid));
    end;

    for i := 0 to si.AceCount-1 do
    begin
      OSCheck(GetAce(acl, i, Pointer(pace)));
      {$IFDEF DEBUG}
      
      {$ENDIF}
      
      if (U = -1) or EqualSid(Pointer(@pace^.SidStart), FSecInfos[U].sid) then
        Continue 
      else
        OSCheck(AddAce(Fnewdacl, ACL_REVISION, MAXDWORD, pace, PACE_HEADER(pace)^.AceSize))
    end;

    if GrantAccess <> 0 then
    begin
      if ACEFlags <> 0 then
        OSCheck(AddAccessAllowedAceEx(Fnewdacl^, ACL_REVISION, ACEFlags, GrantAccess, FSecInfos[U].sid))
      else
        OSCheck(AddAccessAllowedAce(Fnewdacl, ACL_REVISION, GrantAccess, FSecInfos[U].sid));
    end;

    finally
      if delete_acl then
        FreeMem(acl);
    end;
end;

procedure TSecurityObject.DeleteAllACE;
var
  i: Integer;
  szACL: DWORD;
  si: ACL_SIZE_INFORMATION;
  pace: PACCESS_ALLOWED_ACE;
  acl: PACL;
  delete_acl: Boolean;
begin
  FWriteInfo := FWriteInfo or DACL_SECURITY_INFORMATION;

  if Assigned(FNewDACL) then
    acl := FNewDACL
  else
    acl := FDacl;
  delete_acl := acl = FNewDACL;

  si.AclBytesInUse := 0;
  si.AceCount := 0;
  if Assigned(acl) then
    OSCheck(GetAclInformation(acl,  @si, sizeof(si), AclSizeInformation));
  szACL := si.AclBytesInUse;
  GetMem(FNewDACL, szACL);
  try
    ZeroMemory(FNewDACL, szACL);
    OSCheck(InitializeAcl(Fnewdacl^, szACL, ACL_REVISION));

    for i := 0 to si.AceCount-1 do
    begin
      OSCheck(GetAce(acl, i, pointer(pace)));
      OSCheck(AddAce(Fnewdacl, ACL_REVISION, MAXDWORD, pace, PACE_HEADER(pace)^.AceSize));
    end;

    for i := si.AceCount-1 downto 0 do
      OSCheck(DeleteAce(Fnewdacl, i));
  finally
    if delete_acl then
      FreeMem(acl);
  end;
end;

procedure TSecurityObject.ReadACL;
var
  code: Cardinal;
begin
  clearDacls;
  code := GetNamedSecurityInfo(PWideChar(FobjectName), FobjectType, DACL_SECURITY_INFORMATION or OWNER_SECURITY_INFORMATION,
    @FSecInfos[0].sid, nil, @FDacl, nil, FSecDescriptor);
  if code <> ERROR_SUCCESS then
    RaiseLastOSError(code);
end;

procedure TSecurityObject.SetOwner(const Value: string);
begin
  if FSecInfos[0].name <> Value then
  begin
    SplitUserAndComputer(Value, FSecInfos[0].name, FSecInfos[0].computer);
    FSecInfos[0].sid := GetSidByName(FSecInfos[0].Computer, FSecInfos[0].name);
    FSecInfos[0].need_release := true;
    FWriteInfo := FWriteInfo or OWNER_SECURITY_INFORMATION;
  end;
end;

procedure TSecurityObject.WriteACL;
var
  code: Cardinal;
  sidOwner: Pointer;
begin
  code := ERROR_SUCCESS;
  if FWriteInfo <> 0 then
  begin
    sidOwner := FSecInfos[0].sid;
    code := SetNamedSecurityInfo(PWideChar(FobjectName), FobjectType, FWriteInfo, sidOwner, nil, FNewDACL, nil);
  end;
  if code <> ERROR_SUCCESS then
     RaiseLastOSError(code);
  FWriteInfo := 0;
end;

constructor TSuccessorSecurityObject.Create(const objectName: string);
begin
  inherited Create(objectName, GetObjectType);
end;

procedure TSuccessorSecurityObject.GrantAccessAll(const computer, user: string);
begin
  SetAccess(computer, user, PermissionToDessiredAccess(TPermissionType.ptAll, gaAllow), 0, CONTAINER_INHERIT_ACE or OBJECT_INHERIT_ACE);
end;

procedure TSuccessorSecurityObject.DanyAccessAll(const computer, user: string);
begin
  SetAccess(computer, user, 0, PermissionToDessiredAccess(TPermissionType.ptAll, gaDenied), CONTAINER_INHERIT_ACE or OBJECT_INHERIT_ACE);
end;

procedure TSuccessorSecurityObject.SetAccess(const computer, user: string; AGrant, ADeny: TPermissions);
begin
  SetAccess(computer, user, AGrant, ADeny, False, False, False, False);
end;

procedure TSuccessorSecurityObject.SetAccess(const computer, user: string; AGrant, ADeny: TPermissions;
  ContainerInheri, ObjectInherit, InheritOnly, NoPropagateInherit: Boolean);
var
  GrantAccess, DenyAccess, FLags: DWORD;
  Perm: TPermissionType;
begin
  FLags := 0;
  if ContainerInheri then
    FLags := Flags or CONTAINER_INHERIT_ACE;
  if ObjectInherit then
    FLags := Flags or OBJECT_INHERIT_ACE;
  if InheritOnly then
    FLags := FLags or INHERIT_ONLY_ACE;
  if NoPropagateInherit then
    FLags := FLags or NO_PROPAGATE_INHERIT_ACE;

  GrantAccess := 0;
  for Perm := Low(TPermissionType) to High(TPermissionType) do
    if Perm in AGrant then
      GrantAccess := GrantAccess or PermissionToDessiredAccess(Perm, gaAllow);

  DenyAccess := 0;
  for Perm := Low(TPermissionType) to High(TPermissionType) do
    if Perm in ADeny then
      DenyAccess := DenyAccess or PermissionToDessiredAccess(Perm, gaDenied);

  if GrantAccess + DenyAccess <> 0 then
    SetAccess(computer, user, GrantAccess, DenyAccess, Flags);
end;

class function TFileSecurityObject.GetObjectType: TSecurityObjectType;
begin
  Result := SE_FILE_OBJECT;
end;

class function TFileSecurityObject.PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): DWORD;
begin
  if AAccess = gaAllow then
    case APermission of
      ptRead   : Result := GENERIC_READ;
      ptWrite  : Result := GENERIC_WRITE;
      ptExecute: Result := GENERIC_EXECUTE;
      ptAll    : Result := GENERIC_ALL;
      else Result := 0;
    end
  else
    case APermission of
      ptRead   : Result := GENERIC_READ;
      ptWrite  : Result := FILE_WRITE_DATA or FILE_WRITE_ATTRIBUTES or FILE_WRITE_EA or FILE_ADD_FILE or FILE_APPEND_DATA;
      ptExecute: Result := GENERIC_EXECUTE;
      ptAll    : Result := GENERIC_ALL;
      else Result := 0;
    end
end;

class function TRegistrySecurityObject.GetObjectType: TSecurityObjectType;
begin
  Result := SE_REGISTRY_KEY;
end;

class function TRegistrySecurityObject.PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): DWORD;
begin
  if AAccess = gaAllow then
    case APermission of
      ptRead   : Result := KEY_READ;
      ptWrite  : Result := KEY_WRITE or _DELETE;
      ptExecute: Result := KEY_EXECUTE;
      ptAll    : Result := KEY_ALL_ACCESS;
      else Result := 0;
    end
  else 
    case APermission of
      ptRead   : Result := KEY_READ;
      ptWrite  : Result := KEY_SET_VALUE or KEY_CREATE_SUB_KEY or _DELETE or WRITE_DAC or WRITE_OWNER; 
      ptExecute: Result := 0;
      ptAll    : Result := KEY_ALL_ACCESS;
      else Result := 0;
    end
end;

class function TRegistryWow64Key32SecurityObject.GetObjectType: TSecurityObjectType;
begin
  Result := SE_REGISTRY_WOW64_32KEY;
end;

class function TRegistryWow64Key64SecurityObject.GetObjectType: TSecurityObjectType;
begin
  Result := SE_REGISTRY_WOW64_64KEY;
end;

class function TShareSecurityObject.GetObjectType: TSecurityObjectType;
begin
  Result := SE_LMSHARE;
end;

class function TShareSecurityObject.PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): Cardinal;
const
  SHARE_READ   = FILE_SHARE_READ or FILE_READ_EA or FILE_EXECUTE or FILE_READ_ATTRIBUTES or READ_CONTROL or SYNCHRONIZE;
  SHARE_CHANGE = SHARE_READ or FILE_SHARE_WRITE or FILE_ADD_SUBDIRECTORY or FILE_WRITE_EA or FILE_WRITE_ATTRIBUTES or _DELETE;
  SHARE_FULL   = SHARE_CHANGE or FILE_DELETE_CHILD or WRITE_DAC or WRITE_OWNER;
begin
  case APermission of
    ptRead   : Result := SHARE_READ;
    ptWrite  : Result := SHARE_CHANGE;
    ptExecute: Result := SHARE_READ; 
    ptAll    : Result := SHARE_FULL;
    else Result := 0;
  end;
end;

class function TServiceSecurityObject.GetObjectType: TSecurityObjectType;
begin
  Result := SE_SERVICE;
end;

class function TServiceSecurityObject.PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): Cardinal;
begin
  if AAccess = gaAllow then
    case APermission of
      ptRead   : Result := GENERIC_READ; 
      ptWrite  : Result := GENERIC_WRITE; 
      ptExecute: Result := GENERIC_EXECUTE; 
      ptAll    : Result := SERVICE_ALL_ACCESS;
      else Result := 0;
    end
  else
    case APermission of
      ptRead   : Result := GENERIC_READ;
      ptWrite  : Result := SERVICE_CHANGE_CONFIG;
      ptExecute: Result := SERVICE_START or SERVICE_STOP or SERVICE_PAUSE_CONTINUE or SERVICE_USER_DEFINED_CONTROL;
      ptAll    : Result := SERVICE_ALL_ACCESS;
      else Result := 0;
    end
end;

class function TPrinterSecurityObject.GetObjectType: TSecurityObjectType;
begin
  Result := SE_PRINTER;
end;

class function TPrinterSecurityObject.PermissionToDessiredAccess(APermission: TPermissionType; AAccess: TGrantAccess): Cardinal;
begin
  if AAccess = gaAllow then
    case APermission of
      ptRead   : Result := PRINTER_READ; 
      ptWrite  : Result := PRINTER_WRITE; 
      ptExecute: Result := PRINTER_EXECUTE; 
      ptAll    : Result := PRINTER_ALL_ACCESS;
      else Result := 0;
    end
  else
    case APermission of
      ptRead   : Result := PRINTER_READ;
      ptWrite  : Result := PRINTER_WRITE;
      ptExecute: Result := PRINTER_EXECUTE;
      ptAll    : Result := PRINTER_ALL_ACCESS;
      else Result := 0;
    end
end;

function ValidateRegistryName(const s: string): string;
const
  a: array[0..9, 0..1] of string = (
    ('HKEY_CURRENT_USER', 'CURRENT_USER'),
    ('HKEY_LOCAL_MACHINE', 'MACHINE'),
    ('HKEY_USERS', 'USERS'),
    ('HKEY_CLASSES_ROOT', 'CLASSES_ROOT'),
    ('HKEY_CURRENT_CONFIG', 'CURRENT_CONFIG'),

    ('HKCU', 'CURRENT_USER'),
    ('HKLM', 'MACHINE'),
    ('HKU', 'USERS'),
    ('HKCR', 'CLASSES_ROOT'),
    ('HKCC', 'CURRENT_CONFIG')
  );

var
  I, j: Integer;
  
  list: TStringDynArray;
  b: Boolean;
begin
  
  list := SplitString(s, '\');
  for I := 0 to Length(a)-1 do
    begin
      for j := 0 to High(list) do
        if SameText(list[j], a[i, 0])  then
          begin
            list[j] := a[i, 1];
            b := true;
            break;
          end;
      if b then break;
    end;
  
  Result := '';
  for i := 0 to High(list) do
    if i = 0 then
      Result := list[i]
    else
      Result := Result + '\' + list[i];
end;

procedure SplitUserAndComputer(const FullUserName: string; var UserName, Computer: string);
var
  p: Integer;
begin
  UserName := Trim(FullUserName);
  Computer := '';
  p := Pos('\', FullUserName);
  if p > 0 then
  begin
    Computer := Copy(FullUserName, 1, p-1);
    UserName := Copy(FullUserName, p+1)
  end;
end;

end.
